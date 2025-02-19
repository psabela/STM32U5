/*
 * pwd_assembly.s
 *
 *  Created on: Dec 27, 2024
 *      Author: peter
 */

.syntax unified

.text

.global PWD_Set_VDDA_AVM1EN
.global PWD_Set_VDDA_ASV
.global PWD_Get_VDDA1RDY


.thumb_func

.equ	PWD_BASE_OFFSET,	0x46020800U
.equ	PWD_SVMCR_OFFSET,	0x10U
.equ	PWD_SVMSR_OFFSET,	0x3cU

//VDDA independent analog supply voltage monitor 1 enable
PWD_Set_VDDA_AVM1EN:
	LDR		R1, =PWD_BASE_OFFSET
	LDR		R2, =PWD_SVMCR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #26
	ORRS	R0, R2
	STR		R0,	[R1]
	BX LR

PWD_Set_VDDA_ASV:
	LDR		R1, =PWD_BASE_OFFSET
	LDR		R2, =PWD_SVMCR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #30
	ORRS	R0, R2
	STR		R0,	[R1]
	BX LR

PWD_Get_VDDA1RDY:
	LDR		R1, =PWD_BASE_OFFSET
	LDR		R2, =PWD_SVMSR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #26
	ANDS	R0, R2
	BX LR









