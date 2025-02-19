/*
 * rcc_assembly.s
 *
 *  Created on: Dec 27, 2024
 *      Author: peter
 */

.syntax unified

.text
.global RCC_GPIOA_Set_Clock
.global RCC_GPIOH_Set_Clock
.global RCC_TIM2_Set_Clock
.global RCC_ADC4_Set_Clock
.global RCC_PWR_Set_Clock
.global	RCC_PWR_Clear_Clock
.global	RCC_DMA1_Set_Clock

.thumb_func

.equ RCC_BASE_ADDR, 		0x46020C00U
.equ RCC_AHB2ENR1_OFFSET, 	0x8CU		//GPIO clock
.equ RCC_APB1ENR1_OFFSET,	0x09CU		//TIM3 clock
.equ RCC_AHB3ENR_OFFSET,	0x94U		//ADC4
.equ RCC_AHB1ENR,			0x46020c88U


RCC_DMA1_Set_Clock:
	LDR 	R1, =RCC_AHB1ENR
	LDR 	R0, [R1]
	MOVS	R2, 0x1
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

RCC_GPIOA_Set_Clock:
	//enable clock on GPIOA
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB2ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #0 //set GPIOA bit 0 clock enable
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

RCC_GPIOH_Set_Clock:
	//enable clock on GPIOH
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB2ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #7 //set GPIOH bit 7 clock enable
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

RCC_TIM2_Set_Clock:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_APB1ENR1_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x01
	LSLS	R2, #0
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


RCC_ADC4_Set_Clock:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB3ENR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #5
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


RCC_PWR_Set_Clock:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB3ENR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #2
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

RCC_PWR_Clear_Clock:
	LDR		R1, =RCC_BASE_ADDR
	LDR		R2, =RCC_AHB3ENR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #2
	MVNS	R2, R2
	ANDS	R0, R2
	STR		R0, [R1]
	BX LR
