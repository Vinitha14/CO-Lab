.equ SWI_Open, 0x66                       @open a file 
.equ SWI_Close,0x68 			  @close a file 
.equ SWI_PrStr,0x69  			  @ Write a null-ending string 
.equ SWI_Exit, 0x11 			  @ Stop execution 

ldr R0,=Filename 			  @Set name for output	 
mov R1,#1 				  @Output mode 
swi SWI_Open 				  @Open file for output	 
bcs Errormsg 				  @Check carry bit, if 1 then error
 
ldr R1,=InputFileHandle 		  @load output		 
str R0,[r1] 				  @save the file

ldr R0,=InputFileHandle 		 
ldr R0,[R0]				  
ldr R1,=Msg 				  
swi SWI_PrStr 
 
ldr R0, =InputFileHandle  		  @get address of file	 
ldr R0, [R0] 				  @get value at address 	 
swi SWI_Close 

Exit: 
swi SWI_Exit 				  @stop executing

Errormsg:.asciz "Error!Unable to open file...\n" 
 
InputFileHandle: 
.word 0
Filename:  
.asciz "lab1a.txt" 
 
Msg: .asciz "\nFirst sentence of the File.\n"

.end
