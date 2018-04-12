mov R1,#11
mov R4,#0

b lwaitloop

lwaitloop:
add R0,R0,#1
cmp R0,R1
blt stimer
b end

stimer:
mov R2,#1000
mov R3,#0
b swaitloop

swaitloop:
add R4,R4,#1
add R3,R3,#1
cmp R3,R2
blt swaitloop

cmp R0,R1
blt lwaitloop

end:
swi 0x11
b end