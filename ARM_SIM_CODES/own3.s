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

ldr R0,=OutFileHandle
ldr R0,[R0]
ldr R1,=CharArr
mov R2, #80
swi SWI_RdStr

ldr R0,=CharArr
@swi 0x02

mov R5, #'\0'
mov R4, #' '

@\n =0x0a

ldr R7, =CharArr

RLoop:
	ldrb R0, [R7], #1

	@ to compare if \0

	cmp  R0,R5
	beq Exit

	@ to compare if ,

	cmp R0, R4
	bleq Change

	@to print Char

	swi SWI_PrChr

	bal RLoop

Change:
	mov R0, #0x0a
	swi SWI_PrChr
	bal RLoop

ldr r0,=OutFileHandle 
ldr r0,[r0] 
swi SWI_Close
Exit:
swi SWI_Exit
OutFileError:.asciz "Unable to open output file\n"
.align
OutFileName: .asciz "File2.txt" 
OutFileHandle:.word 0 
CharArr:.skip 80
.end