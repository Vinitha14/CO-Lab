ldr r0,=FileName 				 
mov r1,#1 					 
swi 0x66 					 
bcs Error 				 

 
ldr r1,=FileHandle 				 
str r0,[r1] 


ldr r0,=FileHandle 
ldr r0,[r0] 
ldr r1,=Msg 
swi 0x69 
 
ldr R0, =FileHandle  			 
ldr R0, [R0] 					 
swi 0x68 

Exit: 
swi 0x11  				 

Error:.asciz "Unable to open file\n" 
 
FileHandle: 
.word 0
FileName:  
.asciz "HariNarayan.txt" 
 
Msg: .asciz "\nThis is the First sentence\n"

.end
