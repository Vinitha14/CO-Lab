.equ SWI_Open, 0x66                  	                @open a file 
.equ SWI_Close,0x68 					@close a file 
.equ SWI_PrChr,0x00  					@ Write an ASCII char to Stdout 
.equ SWI_PrStr, 0x69  					@ Write a null-ending string 
.equ SWI_RdStr,0x6a 					@ Read an String from a file 
.equ Stdout, 1 						@ Set output target to be Stdout 
.equ SWI_Exit, 0x11 					@ Stop execution 

mov R0, #Stdout 					@print an initial message 
ldr R1, =Msg1  					        @ load address of Message1 
swi SWI_PrStr  						@ display message to Stdout 

ldr R0,=InputFileName 					@ set Name for input file 
mov R1,#0 						@ mode is input 
swi SWI_Open 						@ open file for input 
bcs Errormsg 						@ Check Carry-Bit, if 1 then display Error msg 

ldr R1,=InputFileHandle 				@ load InputFileHandle 
str R0,[R1] 						@ Save the file handle

RLoop: 
ldr R0,=InputFileHandle 			        @ load InputFileHandle 
ldr R0,[R0]
ldr R1,=CharArr 
mov R2,#80 
swi SWI_RdStr 						@ Read the string into R0 
bcs EOFReached 						@ Check Carry-Bit, if 1 then EOF reached 

mov R0,#Stdout 						@ mode is Stdout 
ldr R1, =CharArr 					@ load address of Message1  
swi SWI_PrStr 
mov R0,#Stdout 						
ldr R1, =NL 						@ print new line 
swi SWI_PrStr 
bal RLoop 						@ keep reading till end of file 

EOFReached: 
mov R0, #Stdout 					@ print last message 
ldr R1, =EOFMsg 
swi SWI_PrStr 

ldr R0, =InputFileHandle  				@ get address of file handle 
ldr R0, [R0] 						@ get value at address 
swi SWI_Close 

Exit: 
swi SWI_Exit  						@ stop executing 
Errormsg: 
mov R0, #Stdout 
ldr R1, =ErrMsg 
swi SWI_PrStr 
bal Exit 						@ give up, go to end 
.data 
.align 
InputFileHandle: 
.word 0
CharArr:
.skip 80
InputFileName:  
.asciz "lab1a.txt" 
ErrMsg: .asciz "Failed to open input file \n" 
EOFMsg: .asciz "End of file reached\n" 
ColonSpace:     .asciz": " 
NL: .asciz "\n "					 @ new line 
Msg1: .asciz "Default Message! \n" 
.end




