/*
 * nvic_assembly.s
 *
 *  Created on: Feb 26, 2025
 *      Author: peter
 */



.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

.global NVIC_ADC12_Enable_Interupt
.global NVIC_TIM8_Enable_Interupt
.global NVIC_DMA1_Enable_Interupt
.global NVIC_TIM2_Enable_Interupt


//0xE000E100 NVIC_ISER RW 0x00000000 Interrupt Set-Enable Register
.equ NVIC_ISER_BASE,		0xE000E100U
.equ NVIC_ADC12,			0xE000E104U //37
.equ NVIC_ADC12_OFFSET, 	5			//37-32
.equ NVIC_TIM8,				0xE000E104U //52
.equ NVIC_TIM8_OFFSET, 		20			//52-32
.equ NVIC_TIM2,				0xE000E104U	//45
.equ NVIC_TIM2_OFFSET, 		13			//45-32
.equ NVIC_DMA1,				0xE000E100U
.equ NVIC_DMA1_OFFSET,		29


//positon 37  ADC12 (14 bits) global interrupt0x0000 00D4
NVIC_ADC12_Enable_Interupt:
	LDR		R1, =NVIC_ADC12
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_ADC12_OFFSET
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

//position 52 TIM8 update  0x00000110
NVIC_TIM8_Enable_Interupt:
	LDR		R1, =NVIC_TIM8
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, NVIC_TIM8_OFFSET
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

//position 45 TIM2
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
