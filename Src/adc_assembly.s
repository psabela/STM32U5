/*
 * adc_assembly.s
 *
 *  Created on: Jun 4, 2024
 *      Author: peter
 */


.syntax unified

.text


.global ADC4_Set_Prescaler
.global ADC4_Set_CHSELR_mode_to_all_bits_input
.global ADC4_Set_CHSELR_Internal_Temp_Sensor
.global ADC4_Enable_Interrupts
.global ADC4_Get_Interrupt_Adc_Status
.global ADC4_Clear_VoltageRegulator_ready_flag
.global ADC4_Enable_VoltageRegulator
.global ADC4_Calibrate
.global ADC4_Set_SMPR_SamplingTime
.global ADC4_Set_SMPR_SamplingTimeSource
.global ADC4_Set_Single
.global ADC4_Enable_CCR_TemperatureSensor
.global ADC4_Enable_CCR_Voltage_Reference
.global ADC4_Set_EXTSEL_TIM2_ConversionTrigger
.global ADC4_Set_EXTEN_TriggerPolarity
.global ADC4_Set_OVRMOD_Override
.global ADC4_Enable
.global ADC4_Start
.global ADC4_Get_DR
.global CreateDelayLoop
.global ADC4_Clear_ADRDYIE_Interrupts
.global ADC4_Clear_EOCALIE_Interrupts
.global ADC4_Clear_LDORDYIE_Interrupts
.global ADC4_DMAEN_Mode_Enable
.global ADC4_DMACFG_Circular_Set
.global ADC4_DMACFG_OneShot_Set
.global ADC4_Clear_OVR_flag


.thumb_func

//ADC4
.equ ADC_BASE_ADDR, 		0x46021000U
.equ ADC_ISR_OFFSET,    	0x00U
.equ ADC_IER_OFFSET, 		0x04U
.equ ADC_CR_OFFSET, 		0x08U
.equ ADC_CFGR1_OFFSET, 		0x0CU
.equ ADC_CFGR2_OFFSET,		0x10U
.equ ADC_SMPR_OFFSET,   	0x14U
.equ ADC_CHSEL_OFFSET,	 	0x28U
.equ ADC_DR_OFFSET,			0x40U
.equ ADC_PWR_OFFSET,		0x44U
.equ ADC_CALFACT_OFFSET,	0xc4U
.equ ADC_OR_OFFSET,			0xd0U
.equ ADC_CCR_OFFSET,		0x308U



//1011: input ADC clock divided by 256
ADC4_Set_Prescaler:
	LDR		R1, =ADC_BASE_ADDR
	LDR		R2, =ADC_CCR_OFFSET
	ADDS	R1, R2   	//R1 - address of ADC_CFGR2 register
	LDR		R2, [R1] 	//R2 - content of ADC_CFGR2 register
	MOVS	R3, 0xf
	LSLS	R3, #18
	MVNS	R3, R3
	ANDS	R2, R3		//clear bits
	MOVS	R3, 0xb
	LSLS	R3, #18
	ORRS    R2, R3

//select channel sequence mode Bit 21 CHSELRMOD = 0 in ADC_CFGR1
//Each bit of the ADC_CHSELR register enables an input
ADC4_Set_CHSELR_mode_to_all_bits_input:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #21
	MVNS R2, R2
	ANDS R0, R2		//CLEAR bit 21
	STR	 R0, [R1]
	BX   LR

//ADC4 VIN[13] VSENSE (internal temperature sensor output voltage)
ADC4_Set_CHSELR_Internal_Temp_Sensor:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CHSEL_OFFSET
	ADDS R1, R2 	//add offset to base address
	LDR	 R0, [R1]	//load content of register
	MOVS R2, 0x1
	LSLS R2, #13
	ORRS R0, R2
	STR	 R0, [R1]
	BX   LR

ADC4_Enable_Interrupts:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_IER_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	//MOVS	R2, 0x1805 //0b1100000000101
	MOVS	R2, 0x5
	ORRS	R0, R2
	MOVS	R2, #3
	LSLS	R2, #11
	ORRS	R0, R2
	MOVS	R2, 0x1
	LSLS    R2, #4
	ORRS	R0, R2
	STR		R0, [R1]
	BX LR

ADC4_Clear_LDORDYIE_Interrupts:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_IER_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #12
	MVNS	R2, R2
	ANDS	R0, R2
	STR		R0, [R1]
	BX LR

ADC4_Clear_EOCALIE_Interrupts:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_IER_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	MOVS	R2, 0x1
	LSLS	R2, #11
	MVNS	R2, R2
	ANDS	R0, R2
	STR		R0, [R1]
	BX LR

ADC4_Clear_ADRDYIE_Interrupts:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_IER_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	MOVS	R2, 0x1
	MVNS	R2, R2
	ANDS	R0, R2
	STR		R0, [R1]
	BX LR

ADC4_Get_Interrupt_Adc_Status:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_ISR_OFFSET
	ADDS 	R1, R2
	LDR	 	R0, [R1]
	BX LR

//Clear the LDORDY bit in ADC_ISR register by programming this bit to 1.
ADC4_Clear_VoltageRegulator_ready_flag:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_ISR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R3, R2, #12
	ORRS R0, R3  //set bit to 1 to reset
	STR	 R0, [R1]
	BX   LR

//delay must follow this setting
ADC4_Enable_VoltageRegulator:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R3, R2, #28
	ORRS R0, R3 //set bit 28 ADVREGEN
	STR	 R0, [R1]
	BX   LR

ADC4_Calibrate:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, R2, #31
	ORRS R0, R2 //set bit 31 ADCAL
	STR	 R0, [R1]
	BX   LR
/*
WaitForCalibationComplete:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2
	LOOP1:
		LDR	 R0, [R1]
		LSRS R0, R0, #31
		CMP R0, #1
		BEQ LOOP1
		BX   LR
*/

ADC4_Set_OVRMOD_Override:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R2, #12
	ORRS R0, R2
	STR	 R0, [R1]
	BX   LR

ADC4_Set_SMPR_SamplingTime:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR_OFFSET
	ADDS R1, R2   	//R1 - address of ADC_SMPR register
	LDR	 R2, [R1] 	//R2 - content of ADC_SMPR register
	MOVS R3, 0x7
	MVNS R3, R3
	ANDS R2, R3		//clear first 3 bits
	MOVS R3, 0x7    //111: 814.5 ADC clock cycles  ;011: 12.5 ADC clock cycles
	ORRS R2, R3     //set SMP1[2:0] bits 0, 1, 2
	STR	 R2, [R1]
	BX   LR

ADC4_Set_SMPR_SamplingTimeSource:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_SMPR_OFFSET
	ADDS R1, R2   	//R1 - address of ADC_SMPR register
	LDR	 R2, [R1] 	//R2 - content of ADC_SMPR register
	MOVS R3, 0x1
	LSLS R3, #21
	MVNS R3, R3
	ANDS R2, R3		//set SMP1[2:0] as source
	STR	 R2, [R1]
	BX   LR

ADC4_Set_Single:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 R0, [R1]	//R0 - content of ADC_CFGR1 register
	MOVS R2, 0x1
	LSLS R2, #13
	MVNS R2, R2
	ANDS R0, R2
	STR	 R0, [R1]
	BX   LR

ADC4_Enable:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CRregister
	LDR	 R0, [R1]	//R0 - content of ADC_CR register
	MOVS R2, 0x1
	ORRS R0, R2 //set bit 0 ADEN
	STR	 R0, [R1]
	BX   LR

ADC4_Start:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CR_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CRregister
	LDR	 R0, [R1]	//R0 - content of ADC_CR register
	MOVS R2, 0x1
	LSLS R2, #2
	ORRS R0, R2 //set bit 2 ADSTART
	STR	 R0, [R1]
	BX   LR

ADC4_Get_DR:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_DR_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CRregister
	LDR	 R0, [R1]	//R0 - content of ADC_CR register
	BX   LR

ADC4_Enable_CCR_TemperatureSensor:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CCR_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CCR register
	LDR	 R0, [R1]	//R0 - content of ADC_CCR register
	MOVS R2, 0x1
	LSLS R2, #23
	ORRS R0, R2
	STR  R0, [R1]
	BX   LR

ADC4_Enable_CCR_Voltage_Reference:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CCR_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CCR register
	LDR	 R0, [R1]	//R0 - content of ADC_CCR register
	MOVS R2, 0x1
	LSLS R2, #22
	ORRS R0, R2
	STR  R0, [R1]
	BX   LR

//Bits 8:6 EXTSEL[2:0]: External trigger selection
//010: adc_trg2 -> tim2_trgo
ADC4_Set_EXTSEL_TIM2_ConversionTrigger:
	LDR	 	R1, =ADC_BASE_ADDR
	LDR  	R2, =ADC_CFGR1_OFFSET
	ADDS 	R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 	R2, [R1]	//R2 - content of ADC_CFGR1 register
	MOVS 	R3, 0x7
	LSLS 	R3, #6
	MVNS	R3, R3
	ANDS 	R2, R3
	MOVS 	R3, 0x2
	LSLS 	R3, #6
	ORRS	R2, R3
	STR		R2, [R1]
	BX LR

//Bits 11:10 EXTEN[1:0]: External trigger enable and polarity selection
//These bits are set and cleared by software to select the external trigger polarity and enable
//the trigger.
//00: Hardware trigger detection disabled (conversions can be started by software)
//01: Hardware trigger detection on the rising edge
//10: Hardware trigger detection on the falling edge
//11: Hardware trigger detection on both the rising and falling edges
ADC4_Set_EXTEN_TriggerPolarity:
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




//DMA mode is enabled (DMAEN bit set in the ADC_CFGR1 register)
ADC4_DMAEN_Mode_Enable:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 R0, [R1]	//R0 - content of ADC_CFGR1 register
	MOVS R2, 0x1
	ORRS R0, R2		//set bit 0 (DMAEN)
	STR  R0, [R1]
	BX   LR

ADC4_DMACFG_OneShot_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 R0, [R1]	//R0 - content of ADC_CFGR1 register
	MOVS R2, 0x1
	LSLS R2, #1
	MVNS R2, R2
	ANDS R0, R2
	STR  R0, [R1]
	BX   LR

ADC4_DMACFG_Circular_Set:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_CFGR1_OFFSET
	ADDS R1, R2		//R1 - address of ADC_CFGR1 register
	LDR	 R0, [R1]	//R0 - content of ADC_CFGR1 register
	LSLS R2, #1
	ORRS R0, R2
	STR  R0, [R1]
	BX   LR

ADC4_Clear_OVR_flag:
	LDR	 R1, =ADC_BASE_ADDR
	LDR  R2, =ADC_ISR_OFFSET
	ADDS R1, R2
	LDR	 R0, [R1]
	MOVS R2, 0x1
	LSLS R3, R2, #4
	ORRS R0, R3  //set bit to 1 to reset
	STR	 R0, [R1]
	BX   LR








CreateDelayLoop:
	LOOP:
		SUBS R0, R0, #1  //R0 contains passed parameter
		BNE  LOOP
		BX   LR

