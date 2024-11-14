.model small
.stack 200h
.data

    menuTitle    db "Main Menu                   ", 0
    option1      db "1. Balance Inquiry          ", 0
    option2      db "2. Deposit                  ", 0
    option3      db "3. Withdrawal               ", 0
    option4      db "4. Exit                     ", 0
    promptChoice db 13, 10, "Enter your choice: ", 0

    userChoice   db ?
    balance      dw 0
    amount       dw ?

    balanceInquiryTitle db 13, 10, "Balance Inquiry"
                        db 13, 10, "Your current balance: P", 0

    depositTitle db 13, 10, "Deposit"
                 db 13, 10, "Enter deposit amount: P", 0
    depositMessage db 13, 10, "You deposited P", 0

    withdrawalTitle db 13, 10, "Withdrawal"
                   db 13, 10, "Enter withdrawal amount: P", 0
    withdrawalMessage db 13, 10, "You withdrew P", 0

    exitMessage db 13, 10, "Exiting ATM"
                db 13, 10, "Thank you!", 0

    invalidChoiceError db "ERROR! Invalid Choice!", 0
    insufficientBalanceError db "ERROR! Insufficient Balance!", 0

.code
include io.mac

main proc

    mov ax, @data
    mov ds, ax

    mov ax, 03h
    int 10h

createMenu proc

    mov ah, 09h
    mov bl, 7Fh
    mov cx, 28
    int 10h
    PutStr menuTitle
    PutCh 0Ah

    mov ah, 09h
    mov bl, 7Fh
    mov cx, 28
    int 10h
    PutStr option1
    PutCh 0Ah

    mov ah, 09h
    mov bl, 7Fh
    mov cx, 28
    int 10h
    PutStr option2
    PutCh 0Ah

    mov ah, 09h
    mov bl, 7Fh
    mov cx, 28
    int 10h
    PutStr option3
    PutCh 0Ah

    mov ah, 09h
    mov bl, 7Fh
    mov cx, 28
    int 10h
    PutStr option4

    PutStr promptChoice
    GetCh userChoice

    cmp userChoice, '1'
    je option1Selected
    cmp userChoice, '2'
    je option2Selected
    cmp userChoice, '3'
    je option3Selected
    cmp userChoice, '4'
    je option4Selected

    PutCh 0ah
    mov ah, 09h
    mov bl, 0CEH
    mov cx, 22
    int 10h
    PutStr invalidChoiceError
    PutCh 0ah
    PutCh 0ah
    call createMenu

option1Selected:
    call balanceInquiry
option2Selected:
    call depositAmount
option3Selected:
    call withdrawalAmount
option4Selected:
    call exitATM

createMenu endp

balanceInquiry proc
    PutStr balanceInquiryTitle
    PutInt balance
    PutCh 0ah
    PutCh 0ah
    call createMenu
balanceInquiry endp

depositAmount proc
    PutStr depositTitle
    GetInt CX

    cmp CX, 0
    jg validDeposit

    PutCh 0ah
    mov ah, 09h
    mov bl, 0CEH
    mov cx, 22
    int 10h
    PutStr invalidChoiceError
    PutCh 0ah
    PutCh 0ah
    call createMenu

validDeposit:
    PutStr depositMessage
    PutInt CX
    PutCh '.'
    call addBalance
    PutCh 0ah
    PutCh 0ah
    call createMenu
depositAmount endp

withdrawalAmount proc
    PutStr withdrawalTitle
    GetInt CX

    cmp balance, CX
    jge sufficientFunds

    PutCh 0ah
    mov ah, 09h
    mov bl, 0CEH
    mov cx, 28
    int 10h
    PutStr insufficientBalanceError
    PutCh 0ah
    PutCh 0ah
    call createMenu

sufficientFunds:
    PutStr withdrawalMessage
    PutInt CX
    PutCh '.'
    call subtractBalance
    PutCh 0ah
    PutCh 0ah
    call createMenu
withdrawalAmount endp

addBalance PROC
    add balance, CX         ; balance := balance + deposit amount
    ret
addBalance ENDP

subtractBalance PROC
    sub balance, CX         ; balance := balance - withdrawal amount
    ret
subtractBalance ENDP

exitATM proc
    PutStr exitMessage
    mov ah, 4ch
    int 21h
exitATM endp    

main endp
end main
