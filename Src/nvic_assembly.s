/*
 * nvic_assembly.s
 *
 *  Created on: Dec 29, 2024
 *      Author: peter
 */

.syntax unified

.text

.global NVIC_ADC4_Enable_Interupt
.global NVIC_TIM2_Enable_Interupt
.global NVIC_DMA1_Enable_Interupt

.thumb_func

//0xE000E100 NVIC_ISER RW 0x00000000 Interrupt Set-Enable Register
.equ NVIC_ADC4,				0xE000E10cU
.equ NVIC_ADC4_OFFSET, 		17    //113
.equ NVIC_TIM2,				0xE000E104U
.equ NVIC_TIM2_OFFSET, 		13
.equ NVIC_DMA1,				0xE000E100U
.equ NVIC_DMA1_OFFSET,		29


//positon 113  ADC4ADC4 (12 bits) global interrupt0x0000 0204
NVIC_ADC4_Enable_Interupt:
	LDR		R1, =NVIC_ADC4
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_ADC4_OFFSET
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

NVIC_TIM2_Enable_Interupt:
	LDR		R1, =NVIC_TIM2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_TIM2_OFFSET
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

NVIC_DMA1_Enable_Interupt:
	LDR		R1, =NVIC_DMA1
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_DMA1_OFFSET
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR
