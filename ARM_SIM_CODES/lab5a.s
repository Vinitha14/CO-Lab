mov r0, #0
@mov r2, #0

ldr r1, =Address1
@str r0, [r1]

ldr r1, =Address1
CreateLoop:
   @mov r3, r0, lsl #2
   @add r1, r1, r3
   add r3, r1, r0, lsl #2
   @add r2,r2,r0
   str r0, [r3]
   add r0,r0, #1     
   cmp r0, #100
   bne CreateLoop

   ldr r1, =Address1
   ldr r0, =Address2
   mov r5, #0
   mov r6, #0

CopyLoop:
   ldr r3, [r1,r5,lsl #2] 
   mov r6, r5, lsl #2
   add r6, r0, r6
   str r3, [r6]
   add r5, r5, #1
   cmp r5, #100 
   bne CopyLoop  


   ldr r1, =Address1
   ldr r0, =Address2
   mov r9, #0
   mov r5, #0
   mov r6, #0

AddLoop:

   ldr r3,[r1, r5, lsl #2]
   ldr r4,[r0, r9, lsl #2]

   mov r6, r5, lsl #2
   add r6, r0, r6

   mov r7, r9, lsl #2
   add r7, r1, r7

   add r10,r3,r4
   str r10,[r7]

   add r5,r5,#1
   add r9,r9,#1
   
   cmp r9, #100
   bne AddLoop
      
ldr r0, =Address1
mov r2, #0
mov r5, #5
MulLoop:
  ldr r1, [r0,r2, lsl #2]
  mov r3, r2, lsl #2
  add r3, r0, r3

  mov r7,r1,lsl #2
 @ mul r7,r1, r5
  str r7, [r3]

  add r2,r2, #1
  cmp r2, #100
  bne MulLoop


                                ldr r2, =Address1
				MOV R4 , #0
				printloop:
	  			LDR R1,[R2,R4,LSL #2]

	  			MOV R0,#1
				SWI 0x6b

				LDR R0,=Space
				SWI 0x02

				ADD R4,R4,#1
				CMP R4,#100
				BNE printloop


				LDR R0,=newline 
				SWI 0x02

ldr r0, =Address1
mov r2, #0
mov r5, #4
DivLoop:
   ldr r1, [r0,r2, lsl #1]
   mov r3, r2, lsl #2
   add r3, r0, r3

   mov r7,r1,lsr #2
  @ div r7,r1, r5
   str r7, [r3]

   add r2,r2, #1
   cmp r2, #100
   bne DivLoop


                              ldr r2, =Address1
				MOV R4 , #0
				print1loop:
	  			LDR R1,[R2,R4,LSL #2]

	  			MOV R0,#1
				SWI 0x6b

				LDR R0,=Space
				SWI 0x02

				ADD R4,R4,#1
				CMP R4,#100
				BNE print1loop


				LDR R0,=newline 
				SWI 0x02

@ldr r0, =Address1
@mov r2, #0
@mov r5, #1
@mov r5,r5,lsl #14
@AddOnceNumber:
@   ldr r1, [r0]
@   add r1,r1,r4, lsl #14
@   mov r3,r2, lsl #2
@   add r3,r0,r3

   

ldr r0, =Address1
mov r2, #0
mov r5,#0
add r5,r5,#1000
add r5,r5,#2000
add r5,r5,#2000
Addnumber:
   ldr r1, [r0,r2, lsl #2]
   mov r3, r2, lsl #2
   add r3, r0, r3

  @ mov r7,r1,lsr #2
  @ div r7,r1, r5
   add r7, r1,r5                                                                                                    
   str r7, [r3]

   add r2,r2, #1
   cmp r2, #100
   bne Addnumber

                               ldr r2, =Address1
				MOV R4 , #0
				print2loop:
	  			LDR R1,[R2,R4,LSL #2]

	  			MOV R0,#1
				SWI 0x6b

				LDR R0,=Space
				SWI 0x02

				ADD R4,R4,#1
				CMP R4,#100
				BNE print2loop


     ldr r0, =FileName
     mov r1, #1
     swi 0x66
     bcs Error
     ldr r1, =FileHandler
     str r0, [r1]
     mov r5, #0

@    ldr r0, =FileHandler
@     ldr r0, [r0]
 @    ldr r1, =Address1
 @    ldr r1, [r1]
@    mov r1, #2
 @    swi 0x6b

IntoFile:
     ldr r0, =FileHandler
     ldr r0, [r0]
     ldr r1, =Address1
     ldr r1, [r1,r5, lsl #2]  
     swi 0x6b   

     ldr r0, =FileHandler
     ldr r0, [r0]
     ldr r1, =Space
     swi 0x69 

     add r5, r5, #1
     cmp r5, #100
     bne IntoFile


     ldr r0, =FileHandler
     ldr r0, [r0]
     swi 0x68

     Exit:
     swi 0x11

     Error: 
         ldr r0, =ErrorMsg
         swi 0x02
         bal Exit

     ErrorMsg: .asciz "Unable to open file"
     Space: .asciz  " "
     newline: .asciz "\n\n"
     FileName: .asciz "File6.txt "
     FileHandler: .word 0

.align 4

Address1: .skip 400
Address2: .skip 400


.end

  