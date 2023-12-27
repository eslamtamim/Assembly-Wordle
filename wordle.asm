.model small
.data
arr_string db "write","table","speak","house","plant"
play_again db "do you want to play again ?"
correct_ans db "correct answer well done "
wrong_ans db "wrong answer try again"
enter_word db 
yes db 'Y'
no db 'N'


.code
    main proc far
    .startup
    
   
    
    
;case 1 :the answer is correct    
R:
    lea dx,correct_ans
    mov ah,09
    int 21h
    
    lea dx,play_again
    mov ah,09
    int 21h
;take the answer from user
    mov ah,01
    int 21h
;if yes
    mov al,yes
    cmp ah,al
    je y
    jne n
y:
    ;the loop to start game again 
    loop choose_number
 
    
n:
 .exit   
    
    main endp
    

end main