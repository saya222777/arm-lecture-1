	.syntax unified
	.arch armv7-a
	.text
	.align 2
	.thumb
	.thumb_func

	.global fibonacci
	.type fibonacci, function

fibonacci:
	@ ADD/MODIFY CODE BELOW
	@ PROLOG
	push {r4, r5, lr}

	@ R4 = R0 - 0 (update flags)
	subs r4, r0, #0

	@ if(R4 <= 0) goto .L3 (which returns 0)
	cmp  r4, #0
	it le
	bl .L3

	@ If R4 == 1 goto .L4 (which returns 1)
	cmp r4, #1
	it eq
	bl .L4

	@ if R4 > 1 , set R0=0, R5=1, then goto .loop 
	cmp r4,#1
	it gt
	mov r0, #0
	mov r5, #1
	bl .loop

	pop {r4, r5, pc}		@EPILOG

	@ END CODE MODIFICATION
.loop:
	
	@ R0 = R0 + R5
	add r0, r0, r5
	@ swap the value of R0 and R5
	swp r0, r0, [r5]
	@ counter(R4) -1
	sub r4, #1

	@ if R4 == 2, R5 is the answer
	cmp r4, #2
	it eq
	pop {r4, r5, pc}	

	@ if R4 > 1, goto .loop
	cmp r4, #1
	it gt
	b .loop

.L3:
	mov r0, #0			@ R0 = 0
	pop {r4, r5, pc}		@ EPILOG

.L4:
	mov r0, #1			@ R0 = 1
	pop {r4, r5, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
