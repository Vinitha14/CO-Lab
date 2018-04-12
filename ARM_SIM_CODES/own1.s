.equ SWI_Open, 0x66 @open a file 
.equ SWI_Close,0x68 @close a file 
.equ SWI_PrChr,0x00  @ Write an ASCII char to Stdout 
.equ SWI_PrStr, 0x69  @ Write a null-ending string 
.equ SWI_PrInt,0x6b @ Write an Integer 
.equ SWI_RdInt,0x6c @ Read an Integer from a file 
.equ SWI_Exit, 0x11  @ Stop execution 
.global _start 
.text

ldr r0,=OutFileName @ set Name for output file 
mov r1,#1 @ mode is output 
swi SWI_Open @ open file for output 
bcs OutFileError @ if error
ldr r1,=OutFileHandle @ load output file handle 
str r0,[r1] @ save the file handle 

ldr r0,=OutFileHandle 
ldr r0,[r0] 
ldr r1,=MatMsg @ R1 = address of string 
swi SWI_PrStr @ output string to file

ldr r0,=OutFileHandle 
ldr r0,[r0] 
swi SWI_Close
Exit:
swi SWI_Exit
OutFileError:.asciz "Unable to open output file\n"
.align
OutFileName: .asciz "outfile1.txt" 
OutFileHandle:.word 0 
MatMsg: .asciz "\nThis is the resulting matrix:\n"
.end