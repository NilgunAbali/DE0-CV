$NOLIST
$MODDE0CV

Number_2 EQU #0A4H
Number_8 EQU #080H
Number_0 EQU #0C0H
Number_6 EQU #082H
Number_3 EQU #0B0H

Letter_H EQU #089H
Letter_E EQU #086H 
Letter_L EQU #0C7H
Letter_O EQU #0C0H

Letter_C EQU #0C6H 
Letter_P EQU #08CH 
Letter_N EQU #0ABH  
Letter_3 EQU #0B0H 
Letter_1 EQU #0F9H 
Letter_2 EQU #0A4H 

org 0000H
    ljmp myprogram

; For a 33.33MHz clock, 1 machine cycle takes 30ns
WaitOneSec:
    mov R2, #180
   
DelayLoop1:
    mov R1, #250
DelayLoop2:
    mov R0, #250
    djnz R0, $ ; 3 machine cycles
    djnz R1, DelayLoop2 ; 3*250*30ns = 22.5us
    djnz R2, DelayLoop1 ;
    ret

WaitHalfSec:
    mov R2, #90
   
HalfSecLoop1:
    mov R1, #250
HalfSecLoop2:
    mov R0, #250
    djnz R0, $ ; 3 machine cycles
    djnz R1, HalfSecLoop2 ; 3*250*30ns = 22.5us
    
    djnz R2, HalfSecLoop1 ;
    ret

Display_0000:
    ; Display the number "280063"
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    ret
    

Display_0001:
    ; Display the number "360000"
    mov hex5, #0ffh
    mov hex4, #0ffh
    mov hex3, #0ffh
    mov hex2, #0ffh
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
    ret
   
Skipy1:
	ljmp Check_0000
   
Display_1010:

    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skipy1
    lcall WaitHalfSec 
    JnB KEY.3, Skipy1
    mov hex5, #080H ; 8
    mov hex4, #0C0H ; 0
    mov hex3, #0C0H ; 0
    mov hex2, #082H ; 6
    mov hex1, #0B0H ; 3
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skipy1
    lcall WaitHalfSec
    JnB KEY.3, Skipy1
    mov hex5, #0C0H ; 0
    mov hex4, #0C0H ; 0
    mov hex3, #082H ; 6
    mov hex2, #0B0H ; 3
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
    JnB KEY.3, Skipy1
    lcall WaitHalfSec
    JnB KEY.3, Skipy1
    mov hex5, #0C0H ; 0
    mov hex4, #082H ; 6
    mov hex3, #0B0H ; 3
    mov hex2, #0B0H ; 3
    mov hex1, #082H ; 6
    mov hex0, #0A4H ; 2
    JnB KEY.3, Skippy1
    lcall WaitHalfSec
    JnB KEY.3, Skippy1
    mov hex5, #082H ; 6
    mov hex4, #0B0H ; 3
    mov hex3, #0B0H ; 3
    mov hex2, #082H ; 6
    mov hex1, #0A4H ; 2
    mov hex0, #080H ; 8
    JnB KEY.3, Skippy1
    lcall WaitHalfSec
    JnB KEY.3, Skippy1
    mov hex5, #0B0H ; 3
    mov hex4, #0B0H ; 3
    mov hex3, #082H ; 6
    mov hex2, #0A4H ; 2
    mov hex1, #080H ; 8
    mov hex0, #0C0H ; 0
    JnB KEY.3, Skippy1
    lcall WaitHalfSec
    JnB KEY.3, Skippy1
    mov hex5, #0B0H ; 3
    mov hex4, #082H ; 6
    mov hex3, #0A4H ; 2
    mov hex2, #080H ; 8
    mov hex1, #0C0H ; 0
    mov hex0, #0C0H ; 0
    JnB KEY.3, Skippy1
    lcall WaitHalfSec
    JnB KEY.3, Skippy1
    mov hex5, #082H ; 6
    mov hex4, #0A4H ; 2
    mov hex3, #080H ; 8
    mov hex2, #0C0H ; 0
    mov hex1, #0C0H ; 0
    mov hex0, #082H ; 6
    Jnb KEY.3, Skippy1
    lcall WaitHalfSec  
    JnB KEY.3, Skippy1
    
    ljmp Display_1010
   
 Skippy1:
	ljmp Check_0000
	
 Display_0010:
   
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skippy1

    lcall WaitOneSec 
    JnB KEY.3, Skippy1
    mov hex5, #080H ; 8
    mov hex4, #0C0H ; 0
    mov hex3, #0C0H ; 0
    mov hex2, #082H ; 6
    mov hex1, #0B0H ; 3
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skippy1
   
    lcall WaitOneSec 
    JnB KEY.3, Skippy1
    mov hex5, #0C0H ; 0
    mov hex4, #0C0H ; 0
    mov hex3, #082H ; 6
    mov hex2, #0B0H ; 3
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
   JnB KEY.3, Skippy1
 
    lcall WaitOneSec 
    JnB KEY.3, Skippy1
    mov hex5, #0C0H ; 0
    mov hex4, #082H ; 6
    mov hex3, #0B0H ; 3
    mov hex2, #0B0H ; 3
    mov hex1, #082H ; 6
    mov hex0, #0A4H ; 2
   JnB KEY.3, Skippy1
    lcall WaitOneSec 

    JnB KEY.3, Skippy1
    mov hex5, #082H ; 6
    mov hex4, #0B0H ; 3
    mov hex3, #0B0H ; 3
    mov hex2, #082H ; 6
    mov hex1, #0A4H ; 2
    mov hex0, #080H ; 8
   JnB KEY.3, Skippy3
    lcall WaitOneSec 
    JnB KEY.3, Skippy3
    mov hex5, #0B0H ; 3
    mov hex4, #0B0H ; 3
    mov hex3, #082H ; 6
    mov hex2, #0A4H ; 2
    mov hex1, #080H ; 8
    mov hex0, #0C0H ; 0
     JnB KEY.3, Skippy3
    lcall WaitOneSec 
    JnB KEY.3, Skippy3
    mov hex5, #0B0H ; 3
    mov hex4, #082H ; 6
    mov hex3, #0A4H ; 2
    mov hex2, #080H ; 8
    mov hex1, #0C0H ; 0
    mov hex0, #0C0H ; 0
    JnB KEY.3, Skippy3
    lcall WaitOneSec 
    JnB KEY.3, Skippy3
    mov hex5, #082H ; 6
    mov hex4, #0A4H ; 2
    mov hex3, #080H ; 8
    mov hex2, #0C0H ; 0
    mov hex1, #0C0H ; 0
    mov hex0, #082H ; 6
     JnB KEY.3, Skippy3
    lcall WaitOneSec 
    JnB KEY.3, Skippy3
    
    ljmp Display_0010
    
Skippy3:
ljmp Check_0000

Display_1011: 
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skippy3
    lcall WaitHalfSec
    JnB KEY.3, Skippy3
    mov hex5, #082H ; 6
    mov hex4, #0A4H ; 2
    mov hex3, #080H ; 8
    mov hex2, #0C0H ; 0
    mov hex1, #0C0H ; 0
    mov hex0, #082H ; 6
     JnB KEY.3, Skippy3
    lcall WaitHalfSec
    JnB KEY.3, Skippy3
    mov hex5, #0B0H ; 3
    mov hex4, #082H ; 6
    mov hex3, #0A4H ; 2
    mov hex2, #080H ; 8
    mov hex1, #0C0H ; 0
    mov hex0, #0C0H ; 0
     JnB KEY.3, Skippy3
    lcall WaitHalfSec
    JnB KEY.3, Skippy3
    mov hex5, #0B0H ; 3
    mov hex4, #0B0H ; 3
    mov hex3, #082H ; 6
    mov hex2, #0A4H ; 2
    mov hex1, #080H ; 8
    mov hex0, #0C0H ; 0
    JnB KEY.3, Skippy3
    lcall WaitHalfSec
    JnB KEY.3, Skippy3
    mov hex5, #082H ; 6
    mov hex4, #0B0H ; 3
    mov hex3, #0B0H ; 3
    mov hex2, #082H ; 6
    mov hex1, #0A4H ; 2
    mov hex0, #080H ; 8
    JnB KEY.3, Skipy2
    lcall WaitHalfSec
    JnB KEY.3, Skipy2
    mov hex5, #0C0H ; 0
    mov hex4, #082H ; 6
    mov hex3, #0B0H ; 3
    mov hex2, #0B0H ; 3
    mov hex1, #082H ; 6
    mov hex0, #0A4H ; 2
    JnB KEY.3, Skipy2
    lcall WaitHalfSec
    JnB KEY.3, Skipy2
    mov hex5, #0C0H ; 0
    mov hex4, #0C0H ; 0
    mov hex3, #082H ; 6
    mov hex2, #0B0H ; 3
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
    Jnb KEY.3, Skipy2
    lcall WaitHalfSec
    JnB KEY.3, Skipy2
    mov hex5, #080H ; 8
    mov hex4, #0C0H ; 0
    mov hex3, #0C0H ; 0
    mov hex2, #082H ; 6
    mov hex1, #0B0H ; 3
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skipy2
    lcall WaitHalfSec
    JnB KEY.3, Skipy2
    
    ljmp Display_1011
    
    
Skipy2:
	ljmp Check_0000
	
Display_0011: 
    JnB KEY.3, Skipy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skipy2
    lcall WaitOneSec
    JnB KEY.3, Skipy2
    mov hex5, #082H ; 6
    mov hex4, #0A4H ; 2
    mov hex3, #080H ; 8
    mov hex2, #0C0H ; 0
    mov hex1, #0C0H ; 0
    mov hex0, #082H ; 6
   JnB KEY.3, Skipy2
    lcall WaitOneSec
    JnB KEY.3, Skipy2
    mov hex5, #0B0H ; 3
    mov hex4, #082H ; 6
    mov hex3, #0A4H ; 2
    mov hex2, #080H ; 8
    mov hex1, #0C0H ; 0
    mov hex0, #0C0H ; 0
  JnB KEY.3, Skipy2
    lcall WaitOneSec
    JnB KEY.3, Skipy2
    mov hex5, #0B0H ; 3
    mov hex4, #0B0H ; 3
    mov hex3, #082H ; 6
    mov hex2, #0A4H ; 2
    mov hex1, #080H ; 8
    mov hex0, #0C0H ; 0
  JnB KEY.3, Skipy2
    lcall WaitOneSec
    JnB KEY.3, Skipy2
    mov hex5, #082H ; 6
    mov hex4, #0B0H ; 3
    mov hex3, #0B0H ; 3
    mov hex2, #082H ; 6
    mov hex1, #0A4H ; 2
    mov hex0, #080H ; 8
    JnB KEY.3, Skippy4
    lcall WaitOneSec
    JnB KEY.3, Skippy4
    mov hex5, #0C0H ; 0
    mov hex4, #082H ; 6
    mov hex3, #0B0H ; 3
    mov hex2, #0B0H ; 3
    mov hex1, #082H ; 6
    mov hex0, #0A4H ; 2
    JnB KEY.3, Skippy4
    lcall WaitOneSec
    JnB KEY.3, Skippy4
    mov hex5, #0C0H ; 0
    mov hex4, #0C0H ; 0
    mov hex3, #082H ; 6
    mov hex2, #0B0H ; 3
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
   JnB KEY.3, Skippy4
    lcall WaitOneSec
    JnB KEY.3, Skippy4
    mov hex5, #080H ; 8
    mov hex4, #0C0H ; 0
    mov hex3, #0C0H ; 0
    mov hex2, #082H ; 6
    mov hex1, #0B0H ; 3
    mov hex0, #0B0H ; 3
   JnB KEY.3, Skippy4
    lcall WaitOneSec
    
    ljmp Display_0011
    
    
Skippy4:
	ljmp Check_0000
   
   
BlinkFast: 
    JnB KEY.3, Skippy4
    mov hex5, #0C0H ; 0
    mov hex4, #0C0H ; 0
    mov hex3, #082H ; 6
    mov hex2, #0B0H ; 3
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
    JnB KEY.3, Skippy4
    LCALL WaitHalfSec
    JnB KEY.3, Skippy4
    mov hex5, #0ffh ; 2
    mov hex4, #0ffh ; 8
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 6
    mov hex0, #0ffh ; 3
    JnB KEY.3, Skippy4
    LCALL WaitHalfSec
    JnB KEY.3, Skippy4
ljmp BlinkFast 
    
BlinkSlow: 
	JnB KEY.3, Skipy3
    mov hex5, #0C0H ; 0
    mov hex4, #0C0H ; 0
    mov hex3, #082H ; 6
    mov hex2, #0B0H ; 3
    mov hex1, #0B0H ; 3
    mov hex0, #082H ; 6
    JnB KEY.3, Skipy3
    LCALL WaitOneSec 
    JnB KEY.3, Skipy3
    mov hex5, #0ffh ; 2
    mov hex4, #0ffh ; 8
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 6
    mov hex0, #0ffh ; 3
    JnB KEY.3, Skipy3
    LCALL WaitOneSec
    JnB KEY.3, Skipy3
ljmp BlinkSlow 

Skipy3:
	ljmp Check_0000
   
Display_1101: 
    JnB KEY.3, Skipy3
    mov hex5, #0ffh ; 0
    mov hex4, #0ffh ; 0
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skipy3
    LCALL WaitHalfSec
    JnB KEY.3, Skipy3
    mov hex5, #0A4H ; 2
    mov hex4, #0ffh ; 0
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skipy3
    lcall WaitHalfSec
    JnB KEY.3, Skipy3
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skipy3
    lcall WaitHalfSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy2
    lcall WaitHalfSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy2
    lcall WaitHalfSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy2
    lcall WaitHalfSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skippy2
    lcall WaitHalfSec
    
    ljmp Display_1101
    
Skippy2:
	ljmp Check_0000

Display_0101: 
    JnB KEY.3, Skippy2
    mov hex5, #0ffh ; 0
    mov hex4, #0ffh ; 0
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy2
    LCALL WaitOneSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #0ffh ; 0
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy2
    LCALL WaitOneSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy2
    LCALL WaitOneSec
    JnB KEY.3, Skippy2
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0ffh ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy5
    lcall WaitOneSec
    JnB KEY.3, Skippy5
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #0ffh ; 0
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy5
    lcall WaitOneSec
    JnB KEY.3, Skippy5
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0ffh ; 0
    JnB KEY.3, Skippy5
    lcall WaitOneSec
    JnB KEY.3, Skippy5
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skippy5
    lcall WaitOneSec
   
    
    ljmp Display_0101
    
Skippy5:
	ljmp Check_0000



Skippy6:
ljmp Check_0000

OneSecLoop: 
    
	JnB KEY.3, Skippy6
    mov hex5, #0ffh ; off
    mov hex4, Letter_H
    mov hex3, Letter_E
    mov hex2, Letter_L
    mov hex1, Letter_L
    mov hex0, Letter_O
    JnB KEY.3, Skippy6
    lcall WaitOneSec
    JnB KEY.3, Skippy6
 
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skippy6
    lcall WaitOneSec
    JnB KEY.3, Skippy6
  
    mov hex5, Letter_C
    mov hex4, Letter_P
    mov hex3, Letter_N
    mov hex2, Letter_3
    mov hex1, Letter_1
    mov hex0, Letter_2
    JnB KEY.3, Skippy6; If Key3 is pressed, latch the switches
	lcall WaitOneSec
ljmp OneSecLoop	


   
HalfSecLoop:
   
    JnB KEY.3, Skipy4 ; If Key3 is pre
    mov hex5, #0ffh ; off
    mov hex4, Letter_H
    mov hex3, Letter_E
    mov hex2, Letter_L
    mov hex1, Letter_L
    mov hex0, Letter_O            ; Insert '3' at the start of the sequence
    JnB KEY.3, Skipy4 ; If Key3 is pre
    LCALL WaitHalfSec 
    JnB KEY.3, Skipy4 ; If Key3 is pre
    mov hex5, #0A4H ; 2
    mov hex4, #080H ; 8
    mov hex3, #0C0H ; 0
    mov hex2, #0C0H ; 0
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3 
    JnB KEY.3, Skipy4 ; If Key3 is pre
    LCALL WaitHalfSec 
    JnB KEY.3, Skipy4 
    mov hex5, Letter_C
    mov hex4, Letter_P
    mov hex3, Letter_N
    mov hex2, Letter_3
    mov hex1, Letter_1
    mov hex0, Letter_2
    jnB KEY.3, Skipy4 ; If Key3 is pre
    LCALL WaitHalfSec  
ljmp HalfSecLoop	   
 
  Skipy4:
	ljmp Check_0000
   
Display_0111: 
 
    JnB KEY.3, Skipy4 ; If Key3 is pressed, latch the switches
    mov hex5, #0ffh ; 0
    mov hex4, #0ffh ; 0
    mov hex3, #0ffh ; 0
    mov hex2, #0ffh ; 0
	mov hex1, #0A4H ; 2
    mov hex0, #080H ; 8
    JnB KEY.3, Skipy4
    LCALL WaitHalfSec
    JnB KEY.3, Skipy4
    mov hex1, #0C0H ; 0
    mov hex0, #0C0H ; 0
   JnB KEY.3, Skipy4
    LCALL WaitHalfSec
    JnB KEY.3, Skipy4 
    ; If Key3 is pressed, latch the switches
    mov hex1, #082H ; 6
    mov hex0, #0B0H ; 3
    JnB KEY.3, Skipy4 ; If Key3 is pressed, latch the switches
    LCALL WaitHalfSec
    JnB KEY.3, Skipy4
    mov hex1,#0B0H ; 3
    mov hex0,#082H ; 6
    JnB KEY.3, Skipy4 
    LCALL WaitHalfSec
    JnB KEY.3, Skipy4 ; If Key3 is pressed, latch the switches
ljmp Display_0111 





Skipy:
	ljmp myprogram
   
myprogram:
    mov SP, #7FH
    mov LEDRA, #0
    mov LEDRB, #0

M0:
    ;; Read the values of switches
    MOV A, SWA
    ANL A, #0fH ; Mask only the lower 4 bits 
    Mov R1, #00H  
   
    JB KEY.3, Skipy ; If Key3 is pressed, latch the switches

    ; If Key3 is not pressed, proceed normally
Check_0000: 
    MOV A, SWA
    ANL A, #0fH ; Mask only the lower 3 bits 
  
    CJNE A, #0, Check_0001 ; If switches are not "000", check for "001"
    LCALL Display_0000 ; Execute the display routine for "000"
    SJMP M0
    
Check_0001:
    CJNE A, #1, Check_0010 ; If switches are not "001", call scroll routine
    LCALL Display_0001 ; Execute the display routine for "001"
    SJMP M0

Check_0010:
    CJNE A, #2, Check_0011 ; If switches are not "010", check for "011"
    LCALL Display_0010 ; Execute the display routine for "010"
    SJMP M0

Check_0011:
    CJNE A, #3, Check_0100 ; If switches are not "011", check for "100"
    LCALL Display_0011 ; Execute the display routine for "011"
    SJMP M0

Check_0100:
    CJNE A, #4, Check_0101 ; If switches are not "100", check for "101"
    Lcall BlinkSlow
    SJMP M0

Check_0101:
    CJNE A, #5, Check_0110 ; If switches are not "101", check for "110"
    LCALL Display_0101 ; Execute the display routine for "101"
    SJMP M0

Check_0110:
    CJNE A, #6, Check_0111 ; If switches are not "110", check for "111"
    LCALL OneSecLoop ; Execute the display routine for "110"
    SJMP M0

Check_0111:
    CJNE A, #7, Check_1000 ; If switches are not "111", skip to NoDisplay
    LCALL Display_0111 ; Execute the display routine for "111"
    SJMP M0
    
Check_1000:
    CJNE A, #8, Check_1001 ; If switches are not "111", skip to NoDisplay
    LCALL Display_0000 ; Execute the display routine for "111"
    SJMP M0

Check_1001:
    CJNE A, #9, Check_1010 ; If switches are not "111", skip to NoDisplay
    LCALL Display_0001 ; Execute the display routine for "111"
    SJMP M0
    
Check_1010:
    CJNE A, #10, Check_1011 ; If switches are not "111", skip to NoDisplay
    LCALL Display_1010 ; Execute the display routine for "111"
    SJMP M0
    
Check_1011:
    CJNE A, #11, Check_1100 ; If switches are not "111", skip to NoDisplay
    LCALL Display_1011 ; Execute the display routine for "111"
    SJMP M0
    
Check_1100:
    CJNE A, #12,Check_1101 ; If switches are not "111", skip to NoDisplay
    LCALL BlinkFast ; Execute the display routine for "111"
    SJMP M0
   
Check_1101:
    CJNE A, #13,Check_1110 ; If switches are not "111", skip to NoDisplay
    LCALL Display_1101 ; Execute the display routine for "111"
    SJMP M0
    
Check_1110:
    CJNE A, #14, Check_1111 ; If switches are not "111", skip to NoDisplay
    LCALL HalfSecLoop ; Execute the display routine for "111"
    LjMP M0
    
Check_1111:
    CJNE A, #15, NoDisplay ; If switches are not "111", skip to NoDisplay
    LCALL Display_0111 ; Execute the display routine for "111"
    LJMP M0

NoDisplay:
    ; Add any necessary delay or other operations here
    CPL LEDRA.0 ; Toggle LED for debugging
    LJMP M0



END
