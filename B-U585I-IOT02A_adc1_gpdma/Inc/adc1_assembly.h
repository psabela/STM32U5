/*
 * adc1_assembly.h
 *
 *  Created on: Feb 25, 2025
 *      Author: peter
 */

#ifndef ADC1_ASSEMBLY_H_
#define ADC1_ASSEMBLY_H_

#include <stdint.h>

extern void ADC1_DEEPPWD_Clear(void);
extern void ADC1_CR_ADVREGEN_Set(void);
extern uint32_t ADC1_ISR_LDORDY_Get(void);
extern void ADC1_CR_ADCALLIN_Set(void);
extern void ADC1_CALFACT_CAPTURE_COEF_Clear(void);
extern void ADC1_CALFACT_LATCH_COEF_Clear(void);
extern void ADC1_CR_ADCAL_Set(void);
extern uint32_t ADC1_CR_ADCAL_Get(void);
extern void ADC1_PCSEL_PCSEL_Set(uint8_t x);
extern void ADC1_DIFSEL_DIFSEL_SingleEnded(uint8_t x);
extern void ADC1_SQR1_SQ1(uint8_t x);
extern void ADC1_SQR1_SQ2(uint8_t x);
extern void ADC1_SQR1_SQ3(uint8_t x);
extern void ADC1_SQR1_SQ4(uint8_t x);
extern void ADC1_SQR1_L(uint8_t x);
extern void ADC1_SMPR2_SMP18_5CLK(void);
extern void ADC1_SMPR2_SMP19_5CLK(void);
extern void ADC1_SMPR2_SMP19_12CLK(void);
extern void ADC1_SMPR2_SMP19_20CLK(void);
extern void ADC1_SMPR2_SMP18_814CLK(void);
extern void ADC1_SMPR2_SMP19_814CLK(void);
extern void ADC12_CCR_VBATEN_Set(void);
extern void ADC12_CCR_VSENSESEL_Set(void);
extern void ADC12_CCR_VREFEN_Set(void);
extern void ADC12_CCR_PRESC_256(void);
extern void ADC12_CCR_PRESC_4(void);
extern void ADC1_CFGR1_DMNGT_DmaOneShot(void);
extern void ADC1_CFGR1_DMNGT_DmaCircular(void);
extern void ADC1_CFGR1_DMNGT_Regular(void);
extern void ADC1_CFGR1_CONT_Single(void);
extern void ADC1_CFGR1_CONT_Continuos(void);
extern void ADC1_CFGR1_OVRMOD_Overwrite(void);
extern void ADC1_CFGR1_AUTDLY_Set(void);
extern void ADC1_ISR_OVR_Clear(void);
extern void ADC1_CFGR1_EXTEN(int x);
extern void ADC1_CFGR1_EXTSEL(void);
extern uint32_t ADC1_ISR_State(void);
extern void ADC1_IER_ADRDYIE_Clear(void);
extern void ADC1_IER_Set(void);
extern void ADC1_CR_ADEN(void);
extern void ADC1_CR_ADSTART(void);
extern uint32_t ADC1_DR_Get(void);

#endif /* ADC1_ASSEMBLY_H_ */
