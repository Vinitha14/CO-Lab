.equ SEG_A,0x80 
.equ SEG_B,0x40 
.equ SEG_C,0x20 
.equ SEG_D,0x08 
.equ SEG_E,0x04 
.equ SEG_F,0x02 
.equ SEG_G,0x01 
.equ SEG_P,0x10

LB1:
swi 0x202 @get button press into R0 
cmp r0,#0 
beq LB1 @ if zero, no button pressed 
cmp r0,#0x01
bne LD1 
ldr r0,=SEG_B|SEG_C|SEG_F  @right button, show -| 
swi 0x200 
mov r0,#0x01 @turn on right led 
swi 0x201
bal NextButtons 

LD1: @left black pressed 
ldr r0,=SEG_G|SEG_E|SEG_F @display |- on 8segment 
swi 0x200
mov r0,#0x02 @turn on LEFT led 
swi 0x201 

NextButtons: @Wait for 3 second 
ldr r3,=3000 
BL Wait 

Exit:
swi 0X11

Wait: 
stmfd sp!,{r0-r5,lr} 
ldr r4,=0x00007FFF @mask for 15-bit timer 
swi 0x6d @Get start time 
and r1,r0,r4 @adjusted time to 15-bit 

Digits: 
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G @0 
.word SEG_B|SEG_C @1 .word SEG_A|SEG_B|SEG_F|SEG_E|SEG_D @2 
.word SEG_A|SEG_B|SEG_F|SEG_C|SEG_D @3 
.word SEG_G|SEG_F|SEG_B|SEG_C @4 
.word SEG_A|SEG_G|SEG_F|SEG_C|SEG_D @5 
.word SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C @6 
.word SEG_A|SEG_B|SEG_C @7 
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G @8 
.word SEG_A|SEG_B|SEG_F|SEG_G|SEG_C @9 
.word 0 @Blank display 
 