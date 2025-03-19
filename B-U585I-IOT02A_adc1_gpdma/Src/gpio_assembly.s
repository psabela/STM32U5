/*
 * gpio_assembly.s
 *
 *  Created on: Feb 26, 2025
 *      Author: peter
 */

.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

.global GPIOA_Set_Alt_Funtion_Mode
.global GPIOA_Set_Alt_Function
.global	GPIOH_Set_Moder_LED_Red
.global	GPIOH_Set_BSRR_LED_Red
.global GPIOH_Clear_BSRR_LED_Red
.global GPIOH_Set_Moder_LED_Green
.global GPIOH_Set_BSRR_LED_Green
.global GPIOH_Clear_BSRR_LED_Green
.thumb_func

// Define global variables

.equ GPIOA_BASE_ADDR,		0x42020000U
.equ GPIOH_BASE_ADDR, 		0x42021C00U
.equ GPIOx_MODER_OFFSET,	0x00U
.equ GPIOx_OTYPER_OFFSET, 	0x04U
.equ GPIOx_OSPEEDR_OFFSET,  0x08U
.equ GPIOx_PUPDR_OFFSET, 	0x0CU
.equ GPIOx_ODR_OFFSET,		0x14U
.equ GPIOx_BSRR_OFFSET,		0x18U
.equ GPIOx_AFRL_OFFSET,		0x20U

GPIOA_Set_Alt_Funtion_Mode:
	//PA6 = AF2
	//MODER bits = 10: Alternate function mode
	LDR		R1, =GPIOA_BASE_ADDR
	LDR		R2, =GPIOx_MODER_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R3, R2, #13
	ORRS	R0, R3	//set bit 13
	LSLS	R3, R2, #12
	MVNS	R3,	R3
	ANDS	R0, R3	//clear bit 12
	STR		R0,	[R1]
	BX LR

GPIOA_Set_Alt_Function:
	//PA6 = AF2
	//AFRL 0010: AF2
	LDR		R1, =GPIOA_BASE_ADDR
	LDR		R2, =GPIOx_AFRL_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0xF
	LSLS	R2, #24
	MVNS	R2,	R2
	ANDS	R0, R2	//clear bits 24,25,26,27
	MOVS	R2, 0x1
	LSLS	R2, #25
	ORRS	R0, R2
	STR		R0,	[R1]
	BX LR



//01: General purpose output mode
//PH6 bit(s) 12,13
GPIOH_Set_Moder_LED_Red:
	LDR		R1, =GPIOH_BASE_ADDR
	LDR 	R2, =GPIOx_MODER_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #12
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x1
	LSLS	R2, #12
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


//PH7LD7GreenLD7User LED lights up when PH7 is set to 0.
//PH6LD6RedLD6User LED lights up when PH6 is set to 0.
GPIOH_Set_BSRR_LED_Red:
	LDR		R1, =GPIOH_BASE_ADDR
	LDR 	R2, =GPIOx_BSRR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #6
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

GPIOH_Clear_BSRR_LED_Red:
	LDR		R1, =GPIOH_BASE_ADDR
	LDR 	R2, =GPIOx_BSRR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #22
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR





	//01: General purpose output mode
//PH7 bit(s) 14,15
GPIOH_Set_Moder_LED_Green:
	LDR		R1, =GPIOH_BASE_ADDR
	LDR 	R2, =GPIOx_MODER_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x3
	LSLS	R2, #14
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x1
	LSLS	R2, #14
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR


//PH7LD7GreenLD7User LED lights up when PH7 is set to 0.
//PH6LD6RedLD6User LED lights up when PH6 is set to 0.
GPIOH_Set_BSRR_LED_Green:
	LDR		R1, =GPIOH_BASE_ADDR
	LDR 	R2, =GPIOx_BSRR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #7
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

GPIOH_Clear_BSRR_LED_Green:
	LDR		R1, =GPIOH_BASE_ADDR
	LDR 	R2, =GPIOx_BSRR_OFFSET
	ADDS	R1, R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #23
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR
