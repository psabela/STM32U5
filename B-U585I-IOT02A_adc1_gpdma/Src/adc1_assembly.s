/*
 * adc1_assembly.s
 *
 *  Created on: Feb 25, 2025
 *      Author: peter
 */

.syntax unified
.cpu cortex-m33
.fpu softvfp
.thumb

.text

.global ADC1_DEEPPWD_Clear
.global ADC1_CR_ADVREGEN_Set
.global ADC1_ISR_LDORDY_Get
.global ADC1_CR_ADCALLIN_Set
.global ADC1_CALFACT_CAPTURE_COEF_Clear
.global ADC1_CALFACT_LATCH_COEF_Clear
.global ADC1_CR_ADCAL_Set
.global ADC1_CR_ADCAL_Get
.global ADC1_PCSEL_PCSEL_Set
.global ADC1_DIFSEL_DIFSEL_SingleEnded
.global ADC1_SQR1_SQ1
.global ADC1_SQR1_SQ2
.global ADC1_SQR1_SQ3
.global ADC1_SQR1_SQ4
.global ADC1_SQR1_L
.global	ADC1_SMPR2_SMP18_5CLK
.global ADC1_SMPR2_SMP19_5CLK
.global ADC1_SMPR2_SMP19_12CLK
.global ADC1_SMPR2_SMP19_20CLK
.global ADC1_SMPR2_SMP18_814CLK
.global ADC1_SMPR2_SMP19_814CLK
.global ADC12_CCR_VBATEN_Set
.global ADC12_CCR_VSENSESEL_Set
.global ADC12_CCR_VREFEN_Set
.global ADC12_CCR_PRESC_256
.global ADC12_CCR_PRESC_4
.global ADC1_CFGR1_DMNGT_DmaOneShot
.global ADC1_CFGR1_DMNGT_DmaCircular
.global ADC1_CFGR1_DMNGT_Regular
.global ADC1_CFGR1_CONT_Single
.global ADC1_CFGR1_CONT_Continuos
.global ADC1_CFGR1_OVRMOD_Overwrite
.global ADC1_CFGR1_AUTDLY_Set
.global ADC1_ISR_OVR_Clear
.global ADC1_CFGR1_EXTEN
.global ADC1_CFGR1_EXTSEL
.global ADC1_DR_Get
.global ADC1_ISR_State
.global ADC1_IER_ADRDYIE_Clear
.global ADC1_IER_Set
.global ADC1_CR_ADEN
.global ADC1_CR_ADSTART




//.thumb_func

//ADC1

.equ ADC_BASE_ADDR, 		0x42028000U
.equ ADC_ISR_OFFSET,    	0x00U
.equ ADC_IER_OFFSET, 		0x04U
.equ ADC_CR_OFFSET, 		0x08U
.equ ADC_CFGR1_OFFSET, 		0x0CU
.equ ADC_CFGR2_OFFSET,		0x10U
.equ ADC_SMPR1_OFFSET,   	0x14U
.equ ADC_SMPR2_OFFSET,   	0x18U
.equ ADC_PCSET_OFFSET,   	0x1CU
.equ ADC_SQR1_OFFSET,	 	0x30U
.equ ADC_SQR2_OFFSET,	 	0x34U
.equ ADC_SQR3_OFFSET,	 	0x38U
.equ ADC_SQR4_OFFSET,	 	0x3CU
.equ ADC_DR_OFFSET,			0x40U
.equ ADC_JSQR_OFFSET,		0x4CU
.equ ADC_OFR1_OFFSET,		0x60U
.equ ADC_OFR2_OFFSET,		0x64U
.equ ADC_OFR3_OFFSET,		0x68U
.equ ADC_OFR4_OFFSET,		0x6CU
.equ ADC_GCOMPR_OFFSET,		0x70U
.equ ADC_JDR1_OFFSET,		0x80U
.equ ADC_JDR2_OFFSET,		0x84U
.equ ADC_JDR3_OFFSET,		0x88U
.equ ADC_JDR4_OFFSET,		0x8CU
.equ ADC_AWD2CR_OFFSET,		0xA0U
.equ ADC_AWD3CR_OFFSET,		0xA4U
.equ ADC_LTR1_OFFSET,		0xA8U
.equ ADC_HTR1_OFFSET,		0xACU
.equ ADC_LTR2_OFFSET,		0xB0U
.equ ADC_HTR2_OFFSET,		0xB4U
.equ ADC_LTR3_OFFSET,		0xB8U
.equ ADC_HTR3_OFFSET,		0xBCU
.equ ADC_DIFSEL_OFFSET,		0xC0U
.equ ADC_CALFACT_OFFSET,	0xC4U
.equ ADC_CALFACT2_OFFSET,	0xC8U




/*
Single-ended and differential input channels
ADC channels can be configured either as single-ended input or as differential input. This is
done by writing DIFSEL[19:0] bits in the ADC_DIFSEL register.

A regular group is composed of up to 16 conversions. The regular channels and their
order in the conversion sequence must be selected in the ADC_SQRy registers. The
total number of conversions in the regular group must be written in the L[3:0] bits in the
ADC_SQR1 register.

To convert one of the internal analog channels, the corresponding analog sources must first
be enabled by programming VBATEN, VSENSESEL, or VREFEN bits in the ADC12_CCR
registers.

For each channel selected through SQRx or JSQRx bits, the corresponding ADC_PCSEL
bit must be configured in advance.
This ADC_PCSEL bit controls the analog switch integrated in the I/O level. The ADC input
multiplexer selects the ADC input according to SQRx and JSQRx configuration with very
high speed and the analog switch integrated in the I/O cannot react as fast as the ADC
multiplexer does. To avoid the delay due to on analog switch control on the I/O, it is
necessary to preselect the input channels that are selected through the SQRx and JSQRx.
The selection is based on the VINP[i] of each ADC input. For example, if the ADC converts
ADC_IN1, the PCSEL1 bit must also be set in ADC_PCSEL.

Channel-wise programmable sampling time (SMPR1, SMPR2)
*/


//1.First exit Deep-power-down mode by clearing the DEEPPWD bit in the ADC_CR register.
ADC1_DEEPPWD_Clear:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CR_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	MOVS 	R2, 0x01
	LSLS 	R2, #29
	MVNS	R2, R2
	ANDS 	R0, R2
	STR		R0, [R1]
	BX LR

//2.Then, enable the ADC internal voltage regulator by setting the ADVREGEN bit in the
//ADC_CR register. The software must wait for the startup time of the ADC voltage
//regulator (TADCVREG_STUP) before launching a calibration or enabling the ADC. This
//can be done by software by polling the LDORDY bit of the ADC_ISR register.
ADC1_CR_ADVREGEN_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R3, R2, #28
	ORRS R0, R3 //set bit 28 ADVREGEN
	STR	 R0, [R1]
	BX   LR

ADC1_ISR_LDORDY_Get:
	LDR		R1, =ADC_BASE_ADDR
	LDR		R2, =ADC_ISR_OFFSET
	ADDS	R1,	R2
	LDR		R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #12
	ANDS	R0, R2
	BX LR

//3.Make sure ADEN = 0.
ADC1_ADEN_Clear:
	BX	LR


/*4.The linearity correction must be done only once, regardless of single / differential
configuration:
•Set ADCALLIN in ADC_CR before launching a calibration that runs the linearity
calibration simultaneously with the offset calibration or
•Clear ADCALLIN in ADC_CR before launching a calibration that does not run the
linearity calibration but only the offset calibration.*/
ADC1_CR_ADCALLIN_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #16
	ORRS R0, R2
	STR  R0, [R1]
	BX	LR

//4.Make sure CAPTURE_COEF and LATCH_COEF in ADC_CALFACT are cleared in the ADC_CALFAC register.
//Calibration factor capture enable bit
ADC1_CALFACT_CAPTURE_COEF_Clear:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CALFACT_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #25
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX	LR

//Calibration factor latch enable bit
ADC1_CALFACT_LATCH_COEF_Clear:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CALFACT_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #24
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX	LR

ADC1_CR_ADCAL_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #31
	ORRS R0, R2
	STR  R0, [R1]
	BX	LR

ADC1_CR_ADCAL_Get:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #31
	ANDS R0, R2
	BX	LR



/*For each channel selected through SQRx or JSQRx bits, the corresponding ADC_PCSEL
bit must be configured in advance.
This ADC_PCSEL bit controls the analog switch integrated in the I/O level. The ADC input
multiplexer selects the ADC input according to SQRx and JSQRx configuration with very
high speed and the analog switch integrated in the I/O cannot react as fast as the ADC
multiplexer does. To avoid the delay due to on analog switch control on the I/O, it is
necessary to preselect the input channels that are selected through the SQRx and JSQRx.
The selection is based on the VINP[i] of each ADC input. For example, if the ADC converts
ADC_IN1, the PCSEL1 bit must also be set in ADC_PCSEL.*/
ADC1_PCSEL_PCSEL_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_PCSET_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x1
	LSLS R2, R0
	ORRS R3, R2
	STR	 R3, [R1]
	BX LR

//Single-ended and differential input channels
//ADC channels can be configured either as single-ended input or as differential input. This is
//done by writing DIFSEL[19:0] bits in the ADC_DIFSEL register.
ADC1_DIFSEL_DIFSEL_SingleEnded:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_DIFSEL_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x1
	LSLS R2, R0
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	STR	 R3, [R1]
	BX LR

//A regular group is composed of up to 16 conversions. The regular channels and their
//order in the conversion sequence must be selected in the ADC_SQRy registers. The
//total number of conversions in the regular group must be written in the L[3:0] bits in the
//ADC_SQR1 register.
ADC1_SQR1_SQ1:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SQR1_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x1
	LSLS R2, #4
	MOVS R4, 0xf
	ORRS R2, R4
	LSLS R2, #6
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	LSLS R0, #6
	ORRS R3, R0
	STR	 R3, [R1]
	BX LR
ADC1_SQR1_SQ2:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SQR1_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x1
	LSLS R2, #4
	MOVS R4, 0xf
	ORRS R2, R4
	LSLS R2, #12
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	LSLS R0, #12
	ORRS R3, R0
	STR	 R3, [R1]
	BX LR
ADC1_SQR1_SQ3:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SQR1_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x1
	LSLS R2, #4
	MOVS R4, 0xf
	ORRS R2, R4
	LSLS R2, #18
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	LSLS R0, #18
	ORRS R3, R0
	STR	 R3, [R1]
	BX LR
ADC1_SQR1_SQ4:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SQR1_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x1
	LSLS R2, #4
	MOVS R4, 0xf
	ORRS R2, R4
	LSLS R2, #24
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	LSLS R0, #24
	ORRS R3, R0
	STR	 R3, [R1]
	BX LR

ADC1_SQR1_L:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SQR1_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0xf
	MVNS R2, R2
	ANDS R3, R2  //clear bits
	ORRS R3, R0	 //set from param value
	STR	 R3, [R1]
	BX LR

//Channel-wise programmable sampling time (SMPR1, SMPR2)
ADC1_SMPR2_SMP18_5CLK:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR2_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x7
	MVNS R2, R2
	LSLS R2, #24
	ANDS R3, R2  //clear bits
	STR	 R3, [R1]
	BX LR

ADC1_SMPR2_SMP19_5CLK:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR2_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x7
	MVNS R2, R2
	LSLS R2, #27
	ANDS R3, R2  //clear bits
	STR	 R3, [R1]
	BX LR

ADC1_SMPR2_SMP18_814CLK:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR2_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x7
	LSLS R2, #24
	ORRS R3, R2  //clear bits
	STR	 R3, [R1]
	BX LR

ADC1_SMPR2_SMP19_814CLK:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR2_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x7
	LSLS R2, #27
	ORRS R3, R2
	STR	 R3, [R1]
	BX LR


ADC1_SMPR2_SMP19_12CLK:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR2_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x7
	MVNS R2, R2
	LSLS R2, #27
	ANDS R3, R2  //clear bits
	MOVS R2, 0x2
	LSLS R2, #27
	ORRS R3, R2
	STR	 R3, [R1]
	BX LR

//011: 20 ADC clock cycles
ADC1_SMPR2_SMP19_20CLK:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR2_OFFSET
	ADDS R1, R2
	LDR	 R3, [R1]
	MOVS R2, 0x7
	MVNS R2, R2
	LSLS R2, #27
	ANDS R3, R2  //clear bits
	MOVS R2, 0x3
	LSLS R2, #27
	ORRS R3, R2
	STR	 R3, [R1]
	BX LR

ADC1_CFGR1_DMNGT_DmaOneShot:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CFGR1_OFFSET
	ADDS 	R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 	R0, [R1]
	MOVS	R2, 0x3
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x1
	ORRS	R0, R2
	STR		R0, [R1]
	BX	LR

ADC1_CFGR1_DMNGT_DmaCircular:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CFGR1_OFFSET
	ADDS 	R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 	R0, [R1]
	MOVS	R2, 0x3
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	MOVS	R2, 0x3
	ORRS	R0, R2
	STR		R0, [R1]
	BX	LR

ADC1_CFGR1_DMNGT_Regular:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CFGR1_OFFSET
	ADDS 	R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 	R0, [R1]
	MOVS	R2, 0x3
	MVNS	R2, R2
	ANDS	R0, R2	//clear bits
	STR		R0, [R1]
	BX	LR

//Bits 9:5 EXTSEL[4:0]: External trigger selection
//00111:  adc_ext_trg7 => tim8_trgo
ADC1_CFGR1_EXTSEL:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CFGR1_OFFSET
	ADDS 	R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 	R0, [R1]	//R2 - content of ADC_CFGR1 register
	MOVS 	R2, 0x1
	LSLS 	R2, #4
	MOVS	R3, 0xf
	ORRS 	R2, R3
	LSLS	R2, #5
	MVNS	R2, R2
	ANDS 	R0, R2	//clear bits
	MOVS	R2, #7
	LSLS	R2, #5
	ORRS	R0, R2
	STR		R0, [R1]
	BX	LR

//Bits 11:10 EXTEN[1:0]: External trigger enable and polarity selection
//These bits are set and cleared by software to select the external trigger polarity and enable
//the trigger.
//00: Hardware trigger detection disabled (conversions can be started by software)
//01: Hardware trigger detection on the rising edge
//10: Hardware trigger detection on the falling edge
//11: Hardware trigger detection on both the rising and falling edges
ADC1_CFGR1_EXTEN:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CFGR1_OFFSET
	ADDS 	R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 	R2, [R1]	//R2 - content of ADC_CFGR1 register
	MOVS 	R3, 0x3
	LSLS	R3, #10
	MVNS	R3, R3
	ANDS	R2, R3		//clear bits
	SUBS	R3, R0, #1
	BEQ		RISING_EDGE
	SUBS	R3, R0, #2
	BEQ		FALLING_EDGE
	SUBS	R3, R0, #3
	BEQ		RISING_AND_FALLING_EDGE
	BX LR
	RISING_EDGE:	//01
		MOVS	R3, #1
		LSLS	R3, #10
		ORRS	R2, R3
		STR		R2, [R1]
		BX LR
	FALLING_EDGE:	//10
		MOVS	R3, #1
		LSLS	R3, #11
		ORRS	R2, R3
		STR		R2, [R1]
		BX LR
	RISING_AND_FALLING_EDGE:	//11
		MOVS	R3, #3
		LSLS	R3, #10
		ORRS	R2, R3
		STR		R2, [R1]
		BX LR

ADC1_CFGR1_OVRMOD_Overwrite:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #12
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

ADC1_CFGR1_CONT_Single:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #13
	MVNS R2, R2
	ANDS R0, R2
	STR	 R0, [R1]
	BX LR

ADC1_CFGR1_CONT_Continuos:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #13
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

ADC1_CFGR1_AUTDLY_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #14
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR


ADC1_CR_ADEN:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR


ADC1_CR_ADSTART:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #2
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR






/*To convert one of the internal analog channels, the corresponding analog sources must first
be enabled by programming VBATEN, VSENSESEL, or VREFEN bits in the ADC12_CCR
registers.*/
.equ ADC12_CCR_ADDR,		0x42028308U
ADC12_CCR_VBATEN_Set:
	LDR	 R1, =ADC12_CCR_ADDR
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #24
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

ADC12_CCR_VSENSESEL_Set:
	LDR	 R1, =ADC12_CCR_ADDR
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #23
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

ADC12_CCR_VREFEN_Set:
	LDR	 R1, =ADC12_CCR_ADDR
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #22
	ORRS R0, R2
	STR	 R0, [R1]
	BX LR

//1011: input ADC clock divided by 256
ADC12_CCR_PRESC_256:
	LDR		R1, =ADC12_CCR_ADDR
	LDR		R2, [R1] 	//R2 - content of ADC_CFGR2 register
	MOVS	R3, 0xf
	LSLS	R3, #18
	MVNS	R3, R3
	ANDS	R2, R3		//clear bits
	MOVS	R3, 0xb
	LSLS	R3, #18
	ORRS    R2, R3
	STR 	R2, [R1]
	BX 	LR


//0010: input ADC clock divided by 4
ADC12_CCR_PRESC_4:
	LDR		R1, =ADC12_CCR_ADDR
	LDR		R2, [R1] 	//R2 - content of ADC_CFGR2 register
	MOVS	R3, 0xf
	LSLS	R3, #18
	MVNS	R3, R3
	ANDS	R2, R3		//clear bits
	MOVS	R3, 0x2
	LSLS	R3, #18
	ORRS    R2, R3
	STR 	R2, [R1]
	BX 	LR



//Set interrupts
ADC1_IER_Set:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_IER_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	MOVS	R2, 0x1   //0b11101
	LSLS	R2, 0x4
	MOVS	R3, 0xD
	ORRS	R2, R3
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ADC1_IER_ADRDYIE_Clear:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_IER_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	MOVS	R2, 0x1
	MVNS	R2, R2
	ANDS	R0, R2
	STR		R0, [R1]
	BX LR

ADC1_ISR_State:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_ISR_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	BX LR

ADC1_ISR_OVR_Clear:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_ISR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R3, R2, #4
	ORRS R0, R3  //set bit to 1 to reset
	STR	 R0, [R1]
	BX   LR

ADC1_DR_Get:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_DR_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CRregister
	LDR	 R0, [R1]	//R0 - content of ADC_CR register
	BX   LR



