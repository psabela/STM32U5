/*
 * gpio_assembly.h
 *
 *  Created on: Feb 26, 2025
 *      Author: peter
 */

#ifndef GPIO_ASSEMBLY_H_
#define GPIO_ASSEMBLY_H_

extern void GPIOA_Set_Clock(void);
extern void GPIOA_Set_Alt_Funtion_Mode(void);
extern void GPIOA_Set_Alt_Function(void);
extern void GPIOH_Set_Clock(void);
extern void GPIOH_Set_Moder_LED_Red(void);
extern void GPIOH_Set_BSRR_LED_Red(void);
extern void GPIOH_Clear_BSRR_LED_Red(void);
extern void GPIOH_Set_Moder_LED_Green(void);
extern void GPIOH_Set_BSRR_LED_Green(void);
extern void GPIOH_Clear_BSRR_LED_Green(void);

#endif /* GPIO_ASSEMBLY_H_ */
