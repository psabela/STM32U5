/*
 * adc_assembly.h
 *
 *  Created on: Dec 23, 2024
 *      Author: peter
 */

#ifndef ADC_ASSEMBLY_H_
#define ADC_ASSEMBLY_H_

extern void ADC4_Set_Clock_Enable(void);
extern void ADC4_Set_Prescaler(void);
extern void ADC4_Set_CHSELR_mode_to_all_bits_input(void);
extern void ADC4_Set_CHSELR_Internal_Temp_Sensor(void);
extern void ADC4_Enable_Interrupts(void);
extern uint32_t ADC4_Get_Interrupt_Adc_Status(void);
extern void ADC4_Clear_VoltageRegulator_ready_flag(void);
extern void ADC4_Enable_VoltageRegulator(void);
extern void ADC4_Calibrate(void);
extern void ADC4_Set_SMPR_SamplingTime(void);
extern void ADC4_Set_SMPR_SamplingTimeSource(void);
extern void ADC4_Set_OVRMOD_Override(void);
extern void ADC4_Set_Single(void);
extern void ADC4_Enable_CCR_TemperatureSensor(void);
extern void ADC4_Enable_CCR_Voltage_Reference(void);
extern void ADC4_Set_EXTSEL_TIM2_ConversionTrigger(void);
extern void ADC4_Set_EXTEN_TriggerPolarity(int x);
extern void ADC4_Enable(void);
extern void ADC4_Start(void);
extern uint32_t ADC4_Get_DR(void);
extern void CreateDelayLoop(int x);
extern void  ADC4_Clear_ADRDYIE_Interrupts(void);
extern void  ADC4_Clear_EOCALIE_Interrupts(void);
extern void  ADC4_Clear_LDORDYIE_Interrupts(void);
extern void  ADC4_DMAEN_Mode_Enable(void);
extern void  ADC4_DMACFG_Circular_Set(void);
extern void  ADC4_DMACFG_OneShot_Set(void);
extern void ADC4_Clear_OVR_flag(void);

#endif /* ADC_ASSEMBLY_H_ */
