/*
 * gpdma_assembly.h
 *
 *  Created on: Mar 12, 2025
 *      Author: peter
 */

#ifndef GPDMA_ASSEMBLY_H_
#define GPDMA_ASSEMBLY_H_

extern void  DMA_SECCFGR_Set_Nonsecure(void);
extern void  DMA_PRIVCFGR_Set_Unprivileged(void);
extern void  DMA_C0CR_PRIO_Channel_Priority_0(void);
extern void  DMA_C0BR1_BNDT(void);
extern void  DMA_C0BR1_BRC(void);
extern void  DMA_C0TR1_SAP_Port_0(void);
extern void  DMA_C0TR2_SWREQ_Software_Request_0(void);
extern void  DMA_C0TR2_REQSEL_Hardware_Request_ADC4_DMA(void);
extern void  DMA_C0TR2_REQSEL_Hardware_Request_ADC1_DMA(void);
extern void  DMA_C0SAR_Source_Address(void);
extern void  DMA_C0TR1_SINC_Fixed(void);
extern void  DMA_C0TR1_SINC_Continuous(void);
extern void  DMA_C0TR1_SDW_LOG2_Source_Data_Width_16(void);
extern void  DMA_C0TR1_SBL_1_Burst_Lenght_Single(void);
extern void  DMA_C0TR1_DAP_Port_1(void);
extern void  DMA_C0DAR_Destination_Address(void);
extern void  DMA_C0TR1_DINC_Fixed(void);
extern void  DMA_C0TR1_DINC_Continuous(void);
extern void  DMA_C0TR1_DDW_LOG2_Source_Data_Width_32(void);
extern void  DMA_C0TR1_DDW_LOG2_Source_Data_Width_16(void);
extern void  DMA_C0TR1_DBL_1_Burst_Lenght_Single(void);
extern void  DMA_C0TR1_DBL_1_Burst_Lenght_N(void);
extern void  DMA_C0CR_Set_Enable(void);
extern void  DMA_C0CR_Set_Interrupts(void);
extern uint32_t DMA_C0SR_Flags(void);
extern uint16_t DMA_Get_Converted_Value(void);

#endif /* GPDMA_ASSEMBLY_H_ */
