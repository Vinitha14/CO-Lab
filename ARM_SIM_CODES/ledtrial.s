
ledon:
mov r2,#0
mov r3,#0

mov r0,#0x02
swi 0x201
b delay

delay:
add r2,r2,#1
cmp r2,#100
mov r3,#0
bne delay1
b ledoff

delay1:
add r3,r3,#1
cmp r3,#1000
bne delay1
b delay

ledoff:
mov r2,#0
mov r3,#0

mov r0,#0x01
swi 0x201
b d1

d1:
add r2,r2,#1
cmp r2,#100
mov r3,#0
bne d2
b ledon

d2:
add r3,r3,#1
cmp r3,#1000
bne d2
b d1


exit:
swi 0x11

.end