.syntax unified
.cpu cortex-m4
.thumb

.global _estack

.equ SCR, 0xE000E000
.equ STCSR, SCR+0x10
.equ STRVR, SCR+0x14
.equ STCVR, SCR+0x18
.equ STCR, SCR+0x20

ivt:
  .word _estack
  .word int0_reset

int0_reset:
  ldr r0, =_estack
  mov sp, r0

  bl main

  ldr r7, =0xDEADBEEF
  mov r0, #0
  reset_loop:
    add r0, r0, #1
    b reset_loop

.equ CLOCK_1MS, 180000

# r0 - delay
systick_wait:
  push {lr}

  ldr r1, =CLOCK_1MS
  mul r0, r0, r1
  ldr r1, =STCVR
  str r0, [r1]

  mov r0, #0b101
  ldr r1, =STCSR
  str r0, [r1]

  systick_loop:
    ldr r0, [r1]
    ands r0, #0b10000
    beq systick_loop
  
  pop {lr}
  bx lr

main:
  mov r0, #9000
  bl systick_wait

  ldr r6, =0xAABBCCDD
  dbg_loop: b dbg_loop

  mov r0, #9000
  bl systick_wait

  bx lr