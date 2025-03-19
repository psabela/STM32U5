/*
 * tim8_assembly.h
 *
 *  Created on: Feb 26, 2025
 *      Author: peter
 */

#ifndef TIM8_ASSEMBLY_H_
#define TIM8_ASSEMBLY_H_

extern void TIM8_Set_PSC_Value(void);
extern void TIM8_Set_ARR_Value(void);
extern void TIM8_Clear_UIF_Flag(void);
extern void TIM8_Set_CCnS_To_Channel_Output(void);
extern void TIM8_Set_DITHEN_False(void);
extern void TIM8_Set_CCRn_WaveGen_Value(void);
extern void TIM8_Clear_CC1IF_Flag(void);
extern void TIM8_Set_DIR_UpCounter(void);
extern void TIM8_Set_OCnM_To_Toggle_Mode(void);
extern void TIM8_Set_CC1P_Polarity_ActiveHigh(void);
extern void TIM8_Set_CCnE_Output_Enable_To_GPIO(void);
extern void TIM8_Set_CEN_Counter_Enable(void);
extern void TIM8_Set_UIF_Update_Interrupt_Enable(void);
extern void TIM8_Set_CC1IE_Update_Interrupt_Enable(void);
extern uint16_t TIM8_Get_SR_Status(void);
extern void TIM8_Set_MMS_Update_Trigger_Output(void);
extern void TIM8_RCR_Set(void);

#endif /* TIM8_ASSEMBLY_H_ */
