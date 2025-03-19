/*
 * gpdma_ch15_assembly.s
 *
 *  Created on: Mar 14, 2025
 *      Author: peter
 */

.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text


.global DMA_SECCFGR_Set_Nonsecure
.global DMA_PRIVCFGR_Set_Unprivileged
.global DMA_C15CR_PRIO_Channel_Priority_0
.global DMA_C15BR1_BNDT
.global	DMA_C15BR1_BRC
.global DMA_C15TR1_SAP_Port_0
.global DMA_C15TR2_SWREQ_Software_Request_0
.global DMA_C15TR2_REQSEL_Hardware_Request_ADC4_DMA
.global DMA_C15TR2_REQSEL_Hardware_Request_ADC1_DMA
.global DMA_C15SAR_Source_Address
.global DMA_C15TR1_SINC_Fixed
.global DMA_C15TR1_SINC_Continuous
.global DMA_C15TR1_SDW_LOG2_Source_Data_Width_16
.global DMA_C15TR1_SBL_1_Burst_Lenght_Single
.global DMA_C15TR1_SBL_1_Burst_Lenght_2
.global DMA_C15TR1_DAP_Port_1
.global DMA_C15DAR_Destination_Address
.global DMA_C15TR1_DINC_Fixed
.global DMA_C15TR1_DINC_Continuous
.global DMA_C15TR1_DDW_LOG2_Source_Data_Width_32
.global DMA_C15TR1_DDW_LOG2_Source_Data_Width_16
.global DMA_C15TR1_DBL_1_Burst_Lenght_Single
.global DMA_C15TR1_DBL_1_Burst_Lenght_N
.global DMA_C15CR_Set_Enable
.global DMA_C15CR_Set_Interrupts
.global DMA_C15SR_Flags
.global DMA_Get_Converted_Value


//Channel 0 source address register
.equ GPDMA_C15SAR,	0x4002081c
//Channel 0 destination address register
.equ GPDMA_C15DAR,	0x40020820
//GPDMA channel 0 linked-list base address register
.equ GPDMA_C15LBAR,	0x400207d0
//GPDMA channel 0 flag clear register
.equ GPDMA_C15FCR,	0x400207dc
//GPDMA channel 0 status register
.equ GPDMA_C15SR,	0x400207e0
//GPDMA channel 0 control register
.equ GPDMA_C15CR,	0x400207e4
//GPDMA channel 0 transfer register 1
.equ GPDMA_C15TR1,	0x40020810
//GPDMA channel 0 transfer register 2
.equ GPDMA_C15TR2,	0x40020814
//GPDMA channel 0 block register 1
.equ GPDMA_C15BR1,	0x40020818
//GPDMA channel 0 linked-list address register
.equ GPDMA_C15LLR,	0x4002084c
//GPDMA secure configuration register--secure or nonsecure depending on the secure state of channel x
.equ GPDMA_SECCFGR,	0x40020000U
//GPDMA privileged configuration register--privileged or unprivileged, depending on the privileged state of channel x
.equ GPDMA_PRIVCFGR, 0x40020004U


.equ DESTINATION,		0x2000001c  //0x20000010U
.equ SOURCE, 			0x42028040	//adc_dr register


DMA_SECCFGR_Set_Nonsecure:
	LDR  R1, =GPDMA_SECCFGR
	LDR  R0, [R1]
	MOVS R2, 0x1
	MVNS R2, R2
	ANDS R0, R2
	STR  R0,[R1]
	BX LR

DMA_PRIVCFGR_Set_Unprivileged:
	LDR  R1, =GPDMA_PRIVCFGR
	LDR  R0, [R1]
	MOVS R2, 0x1
	MVNS R2, R2
	ANDS R0, R2
	STR  R0,[R1]
	BX LR

//GPDMA_CxLLR = 0
DMA_C15BR1_BNDT:
	LDR  R1, =GPDMA_C15BR1
	LDR  R0, [R1]
	MOVS R2, #128//0x8
	ORRS R0, R2
	STR  R0,[R1]
	BX LR


//Bits 26:16 BRC[10:0]: Block repeat counter
DMA_C15BR1_BRC:
	LDR  R1, =GPDMA_C15BR1
	LDR  R0, [R1]
	MOVS R2, 0x7
	LSLS R2, #4
	ORRS R2, 0xf
	LSLS R2, #4
	ORRS R2, 0xf
	LSLS R2, #16
	MVNS R2, R2
	ANDS R0, R2  //clear bits
	MOVS R2, 0x4
	LSLS R2, #16
	ORRS R0, R2
	STR  R0,[R1]
	BX LR


//SOURCE configure
//Note: The ADC4 implementation uses no FIFO for ADC_DR.
//Note: The GPDMA reads 16-bit ADC_DR register

//Channel priority
//GPDMA_CxCR.PRIO = 00 PRIO[1:0]:
DMA_C15CR_PRIO_Channel_Priority_0:
	LDR  R1, =GPDMA_C15CR
	LDR  R0, [R1]
	MOV  R2, 0x3
	LSLS R2, #22
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX LR

//Select port: GPDMA port = 0
//Bit 14 SAP: source allocated port (GPDMA_CxTR1)
DMA_C15TR1_SAP_Port_0:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #14
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX LR

//Peripheral request to GPDMA = adc4_dma
//SWREQ = 0 and REQSEL[6:0] in GPDMA_CxTR2
DMA_C15TR2_SWREQ_Software_Request_0:
	LDR  R1, =GPDMA_C15TR2
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #9
	MVNS R2, R2
	ANDS R0, R2
	STR	 R0, [R1]
	BX LR

DMA_C15TR2_REQSEL_Hardware_Request_ADC4_DMA:  //1
	LDR  R1, =GPDMA_C15TR2
	LDR  R0, [R1]
	MOVS R2, 0xF //11
	LSLS R2, #4	 //110000
	MOVS R3, 0xF //001111
	ORRS R2, R3  //111111
	MVNS R2, R2
	ANDS R0, R2  //clear bits 0-6
	MOVS R2, #1	 //adc4_dma = 1
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

DMA_C15TR2_REQSEL_Hardware_Request_ADC1_DMA:  //0
	LDR  R1, =GPDMA_C15TR2
	LDR  R0, [R1]
	MOVS R2, 0xF //11
	LSLS R2, #4	 //110000
	MOVS R3, 0xF //001111
	ORRS R2, R3  //111111
	MVNS R2, R2
	ANDS R0, R2  //clear bits 0-6
	MOVS R2, #0	 //adc4_dma = 1
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

//Select source register
DMA_C15SAR_Source_Address:
	LDR R1, =GPDMA_C15SAR
	LDR R2, =SOURCE
	STR R2, [R1]
	BX LR

DMA_C15TR1_SINC_Fixed:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #3
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX LR

DMA_C15TR1_SINC_Continuous:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #3
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

//GPDMA data width = 16 bit
//Bits 1:0 = 01: half-word (2 bytes)
DMA_C15TR1_SDW_LOG2_Source_Data_Width_16:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	MVNS R2, R2
	ANDS R0, R2		//clear bits
	MOVS R2, 0x1
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

//Bits 9:4 SBL_1[5:0]: source burst length minus 1
//The burst length unit is one data named beat within a burst.
//If SBL_1[5:0] = 0, the burst can be named as single.
DMA_C15TR1_SBL_1_Burst_Lenght_Single:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	LSLS R2, #4
	MOVS R3, 0xF
    ORRS R2, R3
    LSLS R2, #4
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX LR

DMA_C15TR1_SBL_1_Burst_Lenght_2:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	LSLS R2, #4
	MOVS R3, 0xF
    ORRS R2, R3
    LSLS R2, #4
	MVNS R2, R2
	ANDS R0, R2  //clear bits
	MOVS R2, 0x1
	LSLS R2, #4
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

//DESTINATION configure
//GPDMA port = 1 Bit 30 DAP: destination allocated port
DMA_C15TR1_DAP_Port_1:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #30
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

//Select destination register
DMA_C15DAR_Destination_Address:
	LDR R1, =GPDMA_C15DAR
	LDR R2, =DESTINATION
	STR R2, [R1]
	BX LR

//fixed burst
DMA_C15TR1_DINC_Fixed:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #19
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX LR

//fixed burst
DMA_C15TR1_DINC_Continuous:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #19
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

//GPDMA data width = 32 bit
//Bits 17:16 = 10: word (4 bytes)
DMA_C15TR1_DDW_LOG2_Source_Data_Width_32:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	LSLS R2, #16
	MVNS R2, R2
	ANDS R0, R2		//clear bits
	MOVS R2, 0x1
	LSLS R2, #17
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

//GPDMA data width = 16 bit
//Bits 17:16 = 01: half-word (2 bytes)
DMA_C15TR1_DDW_LOG2_Source_Data_Width_16:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	LSLS R2, #16
	MVNS R2, R2
	ANDS R0, R2		//clear bits
	MOVS R2, 0x1
	LSLS R2, #16
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

//DBL_1[5:0]: destination burst length minus 1,
//Bits 25:20 DBL_1[5:0]: source burst length minus 1
//The burst length unit is one data named beat within a burst.
//If SBL_1[5:0] = 0, the burst can be named as single.
DMA_C15TR1_DBL_1_Burst_Lenght_Single:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	LSLS R2, #4
	MOVS R3, 0xF
    ORRS R2, R3
    LSLS R2, #20
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX LR

DMA_C15TR1_DBL_1_Burst_Lenght_N:
	LDR  R1, =GPDMA_C15TR1
	LDR  R0, [R1]
	MOVS R2, 0x3
	LSLS R2, #4
	MOVS R3, 0xF
    ORRS R2, R3
    LSLS R2, #20
	MVNS R2, R2
	ANDS R0, R2
	MOVS R2, 0x7
	LSLS R2, #20
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

DMA_C15CR_Set_Enable:
	LDR  R1, =GPDMA_C15CR
	LDR  R0, [R1]
	MOVS R2, 0x1
	ORRS R0, R2
	STR  R0, [R1]
	BX LR

DMA_C15CR_Set_Interrupts:
	LDR R1, =GPDMA_C15CR
	LDR R0, [R1]
	MOVS R2, 0x1
	LSLS R3, R2, #8
	ORRS R0, R3
	LSLS R3, R2, #10
	ORRS R0, R3
	LSLS R3, R2, #12
	ORRS R0, R3
	STR  R0, [R1]
	BX LR

DMA_C15SR_Flags:
	LDR R1, =GPDMA_C15SR
	LDR R0, [R1]
	BX LR

DMA_Get_Converted_Value:
	LDR R1, =DESTINATION
	LDR R0, [R1]
	BX LR



















