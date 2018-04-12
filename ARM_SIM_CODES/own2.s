.equ SWI_Open, 0x66 @open a file 
.equ SWI_Close,0x68 @close a file 
.equ SWI_PrChr,0x00  @ Write an ASCII char to Stdout 
.equ SWI_PrStr, 0x69  @ Write a null-ending string 
.equ SWI_PrInt,0x6b @ Write an Integer 
.equ SWI_RdInt,0x6c @ Read an Integer from a file
.equ SWI_RdStr,0x6a 
.equ Stdout, 1 	@ Set output target to be Stdout 
.equ SWI_Exit, 0x11  @ Stop execution 
.global _start 
.text

ldr r0,=OutFileName @ set Name for output file 
mov r1,#0 @ mode is output 
swi SWI_Open @ open file for output 
bcs OutFileError @ if error
ldr r1,=OutFileHandle @ load output file handle 
str r0,[r1] @ save the file handle 

RLoop:
ldr r0,=OutFileHandle 
ldr r0,[r0] 
ldr r1,=CharArray 
mov r2,#80 
swi 0x6a 
bcs ReadError  

mov r0,#Stdout @ mode is Stdout 
ldr R1, =CharArray 
swi SWI_PrStr  @ display message to Stdout
bal RLoop 

ldr r0,=OutFileHandle 
ldr r0,[r0] 
swi SWI_Close
Exit:
swi SWI_Exit
OutFileError:.asciz "Unable to open output file\n"
.align
ReadError:.asciz "No text available\n"
.align
OutFileName: .asciz "outfile1.txt" 
OutFileHandle:.word 0 
CharArray: .skip 80
.end