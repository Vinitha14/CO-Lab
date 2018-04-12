mov r0,#11
mov r1,#0

ltimer:
mov r2,#0
add r1,r1,#1
cmp r0,r1
bne stimer
b end

stimer:
mov r3,#2000
add r2,r2,#1
cmp r3,r2
bne stimer
b ltimer

end:
swi 0x11
