.equ SWI_Open, 0x66         				@open a file 
.equ SWI_Close,0x68         				@close a file
.equ SWI_PrChr,0x00         				@ Write an ASCII char to Stdout 
.equ SWI_PrStr, 0x69        				@ Write a null-ending string 
.equ SWI_PrInt,0x6b         				@ Write an Integer 
.equ SWI_RdInt,0x6c         				@ Read an Integer from a file 
.equ SWI_RdStr,0x6a 					@ Read an String from a file 
.equ Stdout, 1              				@ Set output target to be Stdout 
.equ SWI_Exit, 0x11         				@ Stop execution 

ldr R0,=InputFileName 
mov R1,#0 						@ mode is input
swi SWI_Open 						@ open file for input
ldr R1,=InputFileHandle 				@ load input file handle
str R0,[R1] 						@ save the file handle
ldr R0,=InputFileHandle
ldr R0,[R0]
ldr R1,=CharArr
mov R2, #80
swi SWI_RdStr

ldr R0,=CharArr
@swi 0x02

mov R5, #'\0
mov R4, #',

@\n =0x0a

ldr R7, =CharArr

RLoop:
	ldrb R0, [R7], #1

	@ to compare if \0

	cmp  R0,R5
	beq Terminate

	@ to compare if ,

	cmp R0, R4
	bleq Change

	@to print Char

	swi SWI_PrChr

	bal RLoop


Terminate:
	swi SWI_Exit

Change:
	mov R0, #0x0a
	mov PC, R14

InputFileName: .asciz "File2.txt"
InputFileError: .asciz "Error!Unable to open input file\n"
InputFileHandle:  .word 0
CharArr: .skip 80
