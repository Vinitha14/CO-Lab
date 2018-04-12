b ltimerloop
ltimerloop:
add r1,r1,#1
mov r2,#0
mov r3,#0

b timerloop
timerloop:
cmp r2,#200
add r2,r2,#1

mov r0,#0x02
swi 0x201


blt timerloop


b stimerloop

stimerloop:

cmp r3,#200
add r3,r3,#1

mov r0,#0x01
swi 0x201

blt stimerloop


cmp r1,#20
blt ltimerloop
end:swi 0x11

b end


