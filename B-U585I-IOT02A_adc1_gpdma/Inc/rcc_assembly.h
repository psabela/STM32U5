/*
 * rcc_assembly.h
 *
 *  Created on: Feb 25, 2025
 *      Author: peter
 */

#ifndef RCC_ASSEMBLY_H_
#define RCC_ASSEMBLY_H_

extern void RCC_AHB2ENR1_ADC12EN_Set(void);
extern void RCC_AHB3ENR_PWREN_Set(void);
extern void RCC_AHB3ENR_PWREN_Clear(void);
extern void RCC_APB2ENR_TIM8EN_Set(void);
extern void RCC_AHB2ENR1_GPIOHEN_Set(void);
extern void RCC_AHB2ENR1_GPIOAEN_Set(void);
extern void RCC_APB1ENR1_TIM2EN_Set(void);
extern void  RCC_DMA1_Set_Clock(void);


#endif /* RCC_ASSEMBLY_H_ */
