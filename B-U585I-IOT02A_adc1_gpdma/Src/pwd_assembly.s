/*
 * pwd_assembly.s
 *
 *  Created on: Feb 25, 2025
 *      Author: peter
 */

.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

.global PWD_SVMCR_AVM1EN_Vdda_Set
.global PWD_SVMCR_ASV_Vdda_Set
.global PWD_SVMSR_VDDA1RDY_Get


.equ	PWD_BASE_OFFSET,	0x46020800U
.equ	PWD_SVMCR_OFFSET,	0x10U
.equ	PWD_SVMSR_OFFSET,	0x3cU

//VDDA independent analog supply voltage monitor 1 enable
PWD_SVMCR_AVM1EN_Vdda_Set:
	LDR		R1, =PWD_BASE_OFFSET
	LDR		R2, =PWD_SVMCR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #26
	ORRS	R0, R2
	STR		R0,	[R1]
	BX LR

PWD_SVMCR_ASV_Vdda_Set:
	LDR		R1, =PWD_BASE_OFFSET
	LDR		R2, =PWD_SVMCR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #30
	ORRS	R0, R2
	STR		R0,	[R1]
	BX LR

PWD_SVMSR_VDDA1RDY_Get:
	LDR		R1, =PWD_BASE_OFFSET
	LDR		R2, =PWD_SVMSR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #26
	ANDS	R0, R2
	BX LR

