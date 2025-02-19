/*
 * rcc_assembly.h
 *
 *  Created on: Dec 27, 2024
 *      Author: peter
 */

#ifndef RCC_ASSEMBLY_H_
#define RCC_ASSEMBLY_H_

extern void RCC_GPIOA_Set_Clock(void);
extern void RCC_GPIOH_Set_Clock(void);
extern void RCC_TIM2_Set_Clock(void);
extern void RCC_ADC4_Set_Clock(void);
extern void RCC_PWR_Set_Clock(void);
extern void RCC_PWR_Clear_Clock(void);
extern void RCC_DMA1_Set_Clock(void);

#endif /* RCC_ASSEMBLY_H_ */
