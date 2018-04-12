ldr r0,=FileName
mov r1,#1
swi 0x66
bcs OutFileError
ldr r1,=InFileHandle
str r0,[r1]
mov r3,#100
ldr r1,=Input
ldr r2,=Memory

CreateLoop:
str r3,[r1]
sub r3,r3,#1
ldr r0,[r1]
add r0,r0,#1
str r0,[r1],#4
str r0,[r2],#4
cmp r3,#0
bne CreateLoop

ldr r1,=Input
ldr r2,=Memory
mov r3,#100
AddLoop:
sub r3,r3,#1
ldr r0,[r1]
ldr r4,[r2],#4
add r0,r0,r4
str r0,[r1],#4
cmp r3,#0
bne AddLoop

ldr r1,=Input
mov r3,#100
mov r4,#5
MultiplyLoop:
sub r3,r3,#1
ldr r0,[r1]
mul r5,r0,r4
str r5,[r1],#4
cmp r3,#0
bne MultiplyLoop

ldr r1,=Input
mov r3,#100
mov r5,#0
DivideLoop:
sub r3,r3,#1
ldr r0,[r1]
add r0,r5,r0, LSL #2
str r0,[r1],#4
cmp r3,#0
bne DivideLoop

ldr r1,=Input
mov r3,#100
mov r4,#1
AddBigLoop:
sub r3,r3,#1
ldr r0,[r1]
add r0, r0, r4, LSL #14
str r0,[r1],#4
cmp r3,#0
bne AddBigLoop

ldr r5,=Input
ldr r0,=InFileHandle
ldr r0,[r0]
mov r3,#100
StoreLoop:
sub r3,r3,#1
ldr r1,[r5],#4
swi 0x6b
ldr r1,=NewLine
swi 0x69
cmp r3,#0
bne StoreLoop
swi 0x68
ldr r1,=FileSuccess
mov r0,#1
swi 0x69
swi 0x11

OutFileError:
ldr r0,=FileError
swi 0x02
swi 0x11


FileName: .asciz "Text2.txt"
FileError: .asciz "Unable to Open Given File\n"
FileSuccess: .asciz "Entry into File Successfull. Closed File\n"
NewLine: .asciz "\n"
InFileHandle: .word 0
Input: .skip 400
Memory: .skip 400
