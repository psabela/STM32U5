/*
 * tim4_assembly.h
 *
 *  Created on: Feb 27, 2025
 *      Author: peter
 */

#ifndef TIM2_ASSEMBLY_H_
#define TIM2_ASSEMBLY_H_

extern void TIM2_Set_PSC_Value(void);
extern void TIM2_Set_ARR_Value(void);
extern void TIM2_Clear_UIF_Flag(void);
extern void TIM2_Set_CCnS_To_Channel_Output(void);
extern void TIM2_Set_DITHEN_False(void);
extern void TIM2_Set_CCRn_WaveGen_Value(void);
extern void TIM2_Clear_CC1IF_Flag(void);
extern void TIM2_Set_DIR_UpCounter(void);
extern void TIM2_Set_OCnM_To_Toggle_Mode(void);
extern void TIM2_Set_CC1P_Polarity_ActiveHigh(void);
extern void TIM2_Set_CCnE_Output_Enable_To_GPIO(void);
extern void TIM2_Set_CEN_Counter_Enable(void);
extern void TIM2_Set_UIF_Update_Interrupt_Enable(void);
extern void TIM2_Set_CC1IE_Update_Interrupt_Enable(void);
extern uint16_t TIM2_Get_SR_Status(void);
extern void TIM2_Set_MMS_Update_Trigger_Output(void);

#endif /* TIM2_ASSEMBLY_H_ */
