.equ SWI_SETSEG8, 0x200 @display on 8 Segment 
.equ SWI_SETLED, 0x201 @LEDs on/off 
.equ SWI_CheckBlack, 0x202 @check Black button 
.equ SWI_CheckBlue, 0x203 @check press Blue button 
.equ SWI_DRAW_STRING, 0x204 @display a string on LCD 
.equ SWI_DRAW_INT, 0x205 @display an int on LCD 
.equ SWI_CLEAR_DISPLAY,0x206 @clear LCD 
.equ SWI_DRAW_CHAR, 0x207 @display a char on LCD 
.equ SWI_CLEAR_LINE, 0x208 @clear a line on LCD 
.equ SWI_EXIT, 0x11 @terminate program 
.equ SWI_GetTicks, 0x6d @get current time 

Wait: 
stmfd sp!, {r0-r1,lr} 
swi SWI_GetTicks 
mov r1, r0 @ R1: start time 

WaitLoop: 
swi SWI_GetTicks 
subs r0, r0, r1 @ R0: time since start 
rsblt r0, r0, #0 @ fix unsigned subtract 
cmp r0, r2 
blt WaitLoop 

WaitDone: 
ldmfd sp!, {r0-r1,pc}

Exit:
swi SWI_EXIT
