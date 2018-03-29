;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; scrabble.asm                                                                 ;
; A function accepting a single word as input and computes its Scrabble score: ;
; int scrabble(const char *word)                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global _scrabble
section .text
_scrabble:
  ; Print error message and exit program if provided string is empty
  cmp byte [rdi], 0
  jne start
printErr:
  mov rax, 0x02000004
  mov rdi, 1
  mov rsi, errMsg
  mov rdx, errMsgLen
  syscall
  mov rax, 0x02000001
  mov rdi, 1
  syscall
start:
  mov rax, 0 ; Initialize scrabble score to 0
readChar:
  mov r10b, byte [rdi] ; Read current character and store in register 10
  ; Change case (lower => upper) to ease calculation
  cmp r10b, 97
  jl addScore
  sub r10b, 32
addScore:
  cmp r10b, 'Q'
  je add10
  cmp r10b, 'Z'
  je add10
  cmp r10b, 'J'
  je add8
  cmp r10b, 'X'
  je add8
  cmp r10b, 'K'
  je add5
  cmp r10b, 'F'
  je add4
  cmp r10b, 'H'
  je add4
  cmp r10b, 'V'
  je add4
  cmp r10b, 'W'
  je add4
  cmp r10b, 'Y'
  je add4
  cmp r10b, 'B'
  je add3
  cmp r10b, 'C'
  je add3
  cmp r10b, 'M'
  je add3
  cmp r10b, 'P'
  je add3
  cmp r10b, 'D'
  je add2
  cmp r10b, 'G'
  je add2
  cmp r10b, 'E'
  je add1
  cmp r10b, 'A'
  je add1
  cmp r10b, 'I'
  je add1
  cmp r10b, 'O'
  je add1
  cmp r10b, 'N'
  je add1
  cmp r10b, 'R'
  je add1
  cmp r10b, 'T'
  je add1
  cmp r10b, 'L'
  je add1
  cmp r10b, 'S'
  je add1
  cmp r10b, 'U'
  je add1
  jmp printErr
add10:
  add rax, 2
add8:
  add rax, 3
add5:
  add rax, 1
add4:
  add rax, 1
add3:
  add rax, 1
add2:
  add rax, 1
add1:
  add rax, 1
nextChar:
  inc rdi ; Move pointer to next character in C-string
  cmp byte [rdi], 0 ; End of C-string reached?
  jne readChar ; If not, keep reading in characters and adding their letter scores
  ret ; Return the computed scrabble score

section .data
errMsg db "Error: input string to function `scrabble` cannot be empty and may only contain English letters", 10
errMsgLen equ $-errMsg
