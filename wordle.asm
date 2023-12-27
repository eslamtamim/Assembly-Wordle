.MODEL SMALL
.DATA

DO DW '$'
NL DB 10 ,'$'
WORDS DB "WRITE$","TABLE$","SPEAK$","HOUSE$","PLANT$"

KEYBOARD db 10,"Q W E R T Y U I O P",10,"A S D F G H J K L",10 ,"Z X C V B N M"

START_PLAYING DB 10,"CHOOSE A NUMBER FROM 1 TO 5 TO START THE GAME $"
PLAY_AGAIN DB 10,"DO YOU WANT TO PLAY (Y,N)? $"

GUESS DB 10,"NOW TRY TO GUESS THE 5 LETTER WORD IM THINKING OF...$"
WRITE DB 10, "WRITE A 5 LETTER WORD - CAPS ON -  $"

GAME_WORD DB 6 dup('*')
USER_WORD DB 6 dup('*')
CHAR DB '*$'
S DB 0
U DB 0
G DB 6
WON DB 0




CORRECT_ANS DB 10,"CORRECT ANSWER, WELL DONE !$"
WRONG_ANS DB 10,"WRONG ANSWER, THE WORD WAS.. $"

YES DB 'Y'
NO DB 'N'


.CODE

   

    MAIN PROC FAR
    .STARTUP
   
    
GAME:
    MOV S , 0
    MOV U ,0
    MOV G ,6
    MOV WON ,0
    LEA SI, WORDS
    LEA DX, PLAY_AGAIN
    MOV AH, 09
    INT 21H
    
    ;TAKE THE ANSWER FROM USER AND PUTS IT IN AL
    MOV AH,01
    INT 21H
    
    ;IF NO
    MOV AH, NO
    CMP AH, AL
    JE N
    JNE CON
N:
    .EXIT
    
CON:
    MOV AH, YES
    CMP AH, AL
    JNE GAME
    
CHOOSE_WORD:
    ; TELL THE USER TO CHOOSE A NUMBER
    LEA DX, START_PLAYING
    MOV AH, 09H
    INT 21H
    
    
    ;TAKE THE WORD INDEX FROM USER 
    MOV AH,01
    INT 21H
    
    
    ; SUB THE USER'S INPUT FROM THE 0 CHAR SO YOU GET THE DEC VALUE OF THE USER INPUT
    ; DECREMENT IT SO WE GET THE CORRECT INDEX OF THE WORD
    ; MOVE THE INDEX OF THE WORDS ARRAY TO THE RIGHT WORD 
    ; GET THE WORD THE USER CHOOSES SO YOU CAN WORK WITH IT 
   
    
    MOV AH, 0 
    SUB AL, '0'
    CMP AL, 5
    JG CHOOSE_WORD
    DEC AL
    MOV BL , 6
    MUL BL
    LEA SI, WORDS
    ADD SI,AX
    
    LEA DX, NL
    MOV AH, 09H
    INT 21H
    
    MOV CX, 6
    LEA DI , GAME_WORD
    MOV BL , 0
    
BUILD_WORD:
    
    MOV BL , [SI]
    MOV [DI], BL
    INC DI
    INC SI
    LOOP BUILD_WORD
    
   
    SUB DI, 6     
    
    LEA DX, WRITE
    MOV AH, 09H
    INT 21H
    
    LEA DX, NL
    MOV AH, 09H
    INT 21H

GUESSING:
    LEA SI , USER_WORD
    MOV CX, 5
    
        TAKE_WORD:    
            MOV AH, 01H
            INT 21H
            MOV AH, 0
            MOV [SI], AX
            INC SI
        LOOP TAKE_WORD
    
    MOV BX , 0
    MOV BX, DO
    MOV [SI], BX
    
    SUB SI ,5 
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    MOV BH, 0
    MOV BL, 0
    MOV AL, 0CH
    JMP TEST_WORD
    
CONGUESS:
    
    LEA DX, NL
    INT 21H
    DEC G
    MOV BL, WON
    CMP BL, 5
    JE RIGHT_ANSWER
    MOV WON , 0
    
MOV AL, G
CMP AL, 0
JNE GUESSING
JE WRONG_ANSWER


;CASE 1 :THE ANSWER IS CORRECT    
RIGHT_ANSWER:
    LEA DX,CORRECT_ANS
    MOV AH,09
    INT 21H
    JMP GAME
    
;WHEN HE FINISHES TRING WITH OUT GETTING A CORRECT ANSWER:
; THE ANSWER IS CORRECT AND THE GAME IS OVER
WRONG_ANSWER: 
    LEA DX, WRONG_ANS
    MOV AH,09
    INT 21H
    LEA DX, GAME_WORD
    INT 21H
    JMP GAME
   
    
; SI HOLDS THE SYSTEM WORD
; DI HOLDS THE USER   WORD

TEST_WORD:
     
      LEA DI, USER_WORD
      LEA SI, GAME_WORD
      MOV S,0
      MOV U,0

  OUTLOOP:
      MOV AL, [DI]
      LEA SI, GAME_WORD
      MOV S, 0
      MOV AH, 09H 
      MOV BL, 04H 
      MOV BH, 0
      INNERLOOP:
          MOV DL, [SI]
          CMP DL, AL
          JE YELLOW
          JNE CONIN
          
          YELLOW:
              MOV CL, U
              MOV CH, S
              CMP CH, CL
              JE GREEN
              ; MAKE THE COLOR YELLOW
              MOV BL, 0EH 
              
              INC SI
              INC S
              MOV DL, [SI]
              CMP DL, '$'
              JE CONOUT
              JNE INNERLOOP 
          GREEN:
              INC WON
              ;MAKE THE COLOR GREEN
              MOV BL, 02H  
              JMP CONOUT
          CONIN:
              INC SI
              INC S
              MOV DL, [SI]
              CMP DL, '$'
              JNE INNERLOOP
      CONOUT:
          LEA SI , CHAR
          MOV [SI], AL
          LEA DX, CHAR
          MOV CX, 1
          INT 10H
          INT 21H
          INC DI
          INC U
          MOV AL, [DI]
          CMP AL, '$'
          JNE OUTLOOP
          
JMP CONGUESS

  
; START THE GAME AGAIN
JMP GAME

    MAIN ENDP


END MAIN