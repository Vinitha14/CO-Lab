.equ SEG_A,0x80 
.equ SEG_B,0x40 
.equ SEG_C,0x20 
.equ SEG_D,0x08 
.equ SEG_E,0x04 
.equ SEG_F,0x02 
.equ SEG_G,0x01 
.equ SEG_P,0x10 
mov r0,#0
b loop
loop:
b Display8Segment
Display8Segment:
mov r0,r5 
 ldr r2,=Digits 
 ldr r0,[r2,r0,lsl#2]  
 swi 0x200 
add r5,r5,#1
mov r4,#0
b delay


delay:


 add r4,r4,#1
mov r3,#0
b delay1
delay1:
  add r3,r3,#1
  cmp r3,#100
  blt delay1


 cmp r4,#1000
 blt delay
   
add r7,r7,#1
cmp r7,#10
 
blt loop
b Exit
Exit: 
swi 0X11

Digits: 
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G @0 
.word SEG_B|SEG_C @1 
.word SEG_A|SEG_B|SEG_F|SEG_E|SEG_D @2 
.word SEG_A|SEG_B|SEG_F|SEG_C|SEG_D @3 
.word SEG_G|SEG_F|SEG_B|SEG_C @4 
.word SEG_A|SEG_G|SEG_F|SEG_C|SEG_D @5 
.word SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C @6 
.word SEG_A|SEG_B|SEG_C @7 
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G @8 
.word SEG_A|SEG_B|SEG_F|SEG_G|SEG_C @9 
.word 0 
