$modde0cv

	CSEG at 0
	ljmp mycode

dseg at 30h
x: ds 4 ; 32-bits for variable ‘x’
y: ds 4 ; 32-bits for variable ‘y’
sqrt_count: ds 4 
sqrt_number: ds 4
holding: ds 4
holdingy: ds 4
hexacount: ds 4
hexstore: ds 4
tenta:ds 1
bcd: ds 5 ; 10-digit packed BCD (each byte stores 2 digits)
bseg
mf: dbit 1 ; Math functions flag
$include(math32.asm)

	CSEG

; Look-up table for 7-seg displays
myLUT:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 099H        ; 0 TO 4
    DB 092H, 082H, 0F8H, 080H, 090H        ; 4 TO 9


showBCD MAC
	; Display LSD
    mov A, %0
    anl a, #0fh
    movc A, @A+dptr
    mov %1, A
	; Display MSD
    mov A, %0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov %2, A
ENDMAC

Display:
	mov dptr, #myLUT
	showBCD(bcd+0, HEX0, HEX1)
	showBCD(bcd+1, HEX2, HEX3)
	showBCD(bcd+2, HEX4, HEX5)
    ret

MYRLC MAC
	mov a, %0
	rlc a
	mov %0, a
ENDMAC

Shift_Digits:
	mov R0, #4 ; shift left four bits
Shift_Digits_L0:
	clr c
	MYRLC(bcd+0)
	MYRLC(bcd+1)
	MYRLC(bcd+2)
	MYRLC(bcd+3)
	MYRLC(bcd+4)
	djnz R0, Shift_Digits_L0
	; R7 has the new bcd digit	
	mov a, R7
	orl a, bcd+0
	mov bcd+0, a
	; bcd+3 and bcd+4 don't fit in the 7-segment displays so make them zero
	clr a
	mov bcd+4, a
	ret

Wait50ms:
;33.33MHz, 1 clk per cycle: 0.03us
	mov R0, #30
L3: mov R1, #74
L2: mov R2, #250
L1: djnz R2, L1 ;3*250*0.03us=22.5us
    djnz R1, L2 ;74*22.5us=1.665ms
    djnz R0, L3 ;1.665ms*30=50ms
    ret

; Check if SW0 to SW9 are toggled up.  Returns the toggled switch in
; R7.  If the carry is not set, no toggling switches were detected.
ReadNumber:
	mov r4, SWA ; Read switches 0 to 7
	mov a, SWB ; Read switches 8 to 9
	anl a, #00000011B ; Only two bits of SWB available
	mov r5, a
	mov a, r4
	orl a, r5
	jz ReadNumber_no_number
	lcall Wait50ms ; debounce
	mov a, SWA
	clr c
	subb a, r4
	jnz ReadNumber_no_number ; it was a bounce
	mov a, SWB
	anl a, #00000011B
	clr c
	subb a, r5
	jnz ReadNumber_no_number ; it was a bounce
	mov r7, #16 ; Loop counter
ReadNumber_L0:
	clr c
	mov a, r4
	rlc a
	mov r4, a
	mov a, r5
	rlc a
	mov r5, a
	jc ReadNumber_decode
	djnz r7, ReadNumber_L0
	sjmp ReadNumber_no_number	
ReadNumber_decode:
	dec r7
	setb c
ReadNumber_L1:
	mov a, SWA
	jnz ReadNumber_L1
ReadNumber_L2:
	mov a, SWB
	jnz ReadNumber_L2
	ret
ReadNumber_no_number:
	clr c
	ret
	
mycode:
    mov  SP, #7FH
    clr  a
    mov  LEDRA, a
    mov  LEDRB, a
    mov  bcd+0, a
    mov  bcd+1, a
    mov  bcd+2, a
    mov  bcd+3, a
    mov  bcd+4, a
    lcall Display

    mov  b, #0              ; b=0:addition, b=1:subtraction, etc.
    setb LEDRA.0            ; Turn LEDR0 on to indicate addition


forever:
    jb   KEY.3, no_funct    ; Check if 'Function Select' button is pressed
    jnb  KEY.3, $           ; Wait for button release
    inc  b                  ; Increment function mode (select next operation)
    mov  a, b
    acall UpdateLEDs        ; Update LEDs based on selected operation
    cjne a, #7, no_funct    ; Check if it's time to wrap around
    mov  b, #0     
    
UpdateLEDs:
    mov  a, b              ; Load current operation mode into A
    mov  LEDRA, #0x00      ; Clear all LEDs by setting LEDRA to 0

    ; Depending on the value of 'a' (which has the current operation), 
    ; we'll set the appropriate bit in LEDRA.
    ; Note: Assuming LEDRA is directly mapped to LEDR[6..0] and is byte-addressable.
     ; Set LED for addition first
    cjne a, #0, check_sub   ; If not addition, check next
    mov  LEDRA, #01H       ; If addition, turn on LEDR0
    sjmp UpdateLEDs_end

check_sub:
    cjne a, #1, check_mul
    mov  LEDRA, #02H       ; If subtraction, turn on LEDR1
    sjmp UpdateLEDs_end

check_mul:
    cjne a, #2, check_div
    mov  LEDRA, #04H       ; If multiplication, turn on LEDR2
    sjmp UpdateLEDs_end

check_div:
    cjne a, #3, check_rem
    mov  LEDRA, #08H       ; If division, turn on LEDR3
    sjmp UpdateLEDs_end

check_rem:
    cjne a, #4, check_hex
    mov  LEDRA, #10H       ; If remainder, turn on LEDR4
    sjmp UpdateLEDs_end

check_hex:
    cjne a, #5, check_sqrt
    mov  LEDRA, #20H       ; If decimal to hexadecimal, turn on LEDR5
    sjmp UpdateLEDs_end

check_sqrt:
    cjne a, #6, UpdateLEDs_end
    mov  LEDRA, #40H       ; If integer square root, turn on LEDR6

UpdateLEDs_end:
    ret
no_funct:
    jb   KEY.2, no_load    ; If 'Load' key not pressed, skip
    jnb  KEY.2, $          ; Wait for user to release 'Load' key
    lcall bcd2hex          ; Convert the BCD number to hex in x
    lcall copy_xy          ; Copy x to y
    Load_X(0)              ; Clear x (this is a macro)
    lcall hex2bcd          ; Convert result in x to BCD
    lcall Display          ; Display the new BCD number
    ljmp forever           ; Go check for more input

no_load:
    jb   KEY.1, no_equal   ; If 'equal' key not pressed, skip
    jnb  KEY.1, $          ; Wait for user to release 'equal' key
    lcall bcd2hex          ; Convert the BCD number to hex in x
    mov  a, b              ; Check if we are doing addition
    cjne a, #0, subtract
    lcall add32            ; Perform x+y
    lcall hex2bcd          ; Convert result in x to BCD
    lcall Display          ; Display the new BCD number
    ljmp forever           ; Go check for more input
 
subtract:
    cjne a, #1, multiply
    lcall xchg_xy
    lcall x_lt_y ; Check if x < y, where x is initialized as 0
    jb mf, negative_sub
    lcall sub32
    lcall hex2bcd   ;do negative subtraction
    lcall Display
    ljmp forever
    
negative_sub:
    lcall xchg_xy
    lcall sub32
    lcall hex2bcd   ;do negative subtraction
    lcall Display
    ljmp forever
    
multiply:
    cjne a, #2, divide
    lcall xchg_xy
    lcall mul32
    lcall hex2bcd
    lcall Display
    ljmp forever

divide: 
	cjne a, #3, remainder
    lcall xchg_xy ;try dividing smaller value
    lcall div32
    lcall hex2bcd
    lcall Display
    ljmp forever
 
no_equal:
    ; get more numbers
    lcall ReadNumber
    jnc  no_new_digit      ; Indirect jump to 'forever'
    lcall Shift_Digits
    lcall Display

no_new_digit:
    ljmp forever           ; 'forever' is too far away, need to use ljmp 
    
remainder:
    cjne a, #4, Hexa
    mov holding+0, #0x00
    mov holding+1, #0x00
    mov holding+2, #0x00
    mov holding+3, #0x00
    mov holdingy+0, #0x00
    mov holdingy+1, #0x00
    mov holdingy+2, #0x00
    mov holdingy+3, #0x00
    mov holding+0, x+0 ;(7)
    mov holding+1, x+1
    mov holding+2, x+2
    mov holding+3, x+3
    mov holdingy+0, y+0 ;(35)
    mov holdingy+1, y+1
    mov holdingy+2, y+2
    mov holdingy+3, y+3
    lcall xchg_xy 
    lcall div32          ; Perform division: (35)x/ y (7) = x(5)
    mov y+0, holding+0 ; (y)7 x 5 (x) = x(35)
    mov y+1, holding+1
    mov y+2, holding+2
    mov y+3, holding+3
    lcall mul32   ;new x is 35
    lcall xchg_xy ; y(35)
    mov x+0, holdingy+0
    mov x+1, holdingy+1
    mov x+2, holdingy+2
    mov x+3, holdingy+3 ; x(35)
    lcall sub32  ;x(0)               
    lcall hex2bcd
    lcall Display
    ljmp forever
    
   
   
Hexa: 
	cjne a, #5, SquareRoot
    lcall hex2bcd
    lcall Display
	ljmp forever


SquareRoot:
    cjne a, #6, no_equal1
    ;mov tenta, #0x00
    ;mov tenta, a
    mov sqrt_count+0, #0x00
    mov sqrt_count+1, #0x00   ;do bit by bit
    mov sqrt_count+2, #0x00
    mov sqrt_count+3, #0x00
    mov sqrt_number+0, #0x00
    mov sqrt_number+1, #0x00
    mov sqrt_number+2, #0x00
    mov sqrt_number+3, #0x00
    mov x+0, #0x00
    mov x+1, #0x00
    mov x+2, #0x00
    mov x+3, #0x00
    
    sjmp RepeatRoot
 
no_equal1:
    ; get more numbers
    lcall ReadNumber
    jnc  no_new_digit1      ; Indirect jump to 'forever'
    lcall Shift_Digits
    lcall Display

no_new_digit1:
    ljmp forever           ; 'forever' is too far away, need to use ljmp    

    
RepeatRoot:
    clr mf  
    mov sqrt_number+0, y+0 ;y is the uploaded number
    mov sqrt_number+1, y+1 
    mov sqrt_number+2, y+2 
    mov sqrt_number+3, y+3 
    lcall x_gt_y ; Check if x < y, x is initialized as 0
    jb mf, found_sqrt ; If x >= y, square root found
    mov x+0, sqrt_count+0          ; Retrieve before-multiplication x
     mov x+1, sqrt_count+1
      mov x+2, sqrt_count+2
       mov x+3, sqrt_count+3
    mov y+0, #0x01
    mov y+1, #0x00
    mov y+2, #0x00
    mov y+3, #0x00
    lcall add32
    mov sqrt_count+0,x+0
    mov sqrt_count+1,x+1
    mov sqrt_count+2,x+2
    mov sqrt_count+3,x+3
    lcall copy_xy
    lcall mul32         ; Store multiplication x         
    mov y+0, sqrt_number+0
    mov y+1, sqrt_number+1
    mov y+2, sqrt_number+2
    mov y+3, sqrt_number+3           
    sjmp RepeatRoot  ; Repeat the process

found_sqrt:
    mov x+0, sqrt_count+0
    mov x+1, sqrt_count+1
    mov x+2, sqrt_count+2
    mov x+3, sqrt_count+3
    mov y+0, #0x01
    mov y+1, #0x00
    mov y+2, #0x00
    mov y+3, #0x00
    lcall sub32
    lcall hex2bcd
    lcall Display
    ljmp forever

end

 
end
