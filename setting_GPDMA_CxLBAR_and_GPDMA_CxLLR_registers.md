## Example of creating link list in code and setting GPDMA_CxLBAR and GPDMA_CxLLR registers (explained).
by Peter Sabela

*Dilemma introduced by STM32U series documentation:*  
My linked-list object's base address in memory is 0x200bffa8.   How can I save this address in GPDMA_CxLBAR register (that holds *"the linked-list base address of the memory region, for a given channel x, from which the LLIs describing the programmed sequence of the GPDMA transfers, are conditionally and automatically updated"*)  when GPDMA_CxLBAR designated region for the address (LBA[31:16]) is only 16 bits long?

*What is linked list and its aim, per STMicroelectronics?:*  
> "The STM32 General-Purpose Direct Memory Access (GPDMA) controller supports linked list-based programming, which provides a flexible and efficient way to manage complex data transfers without continuous CPU intervention.  
Key aspects of GPDMA linked lists:  
*Linked List Items (LLIs):*  
Each item in the linked list, known as an LLI, is a data structure residing in memory. It contains the configuration for a specific DMA transfer, including source and destination addresses, transfer size, and other control parameters.  
*Chaining Transfers:*  
LLIs are linked together, with each LLI containing a pointer or offset to the next LLI in the sequence. This allows for the chaining of multiple, potentially different, DMA transfers.  
*Automated Execution:*  
Once the GPDMA channel is configured with the address of the first LLI, the DMA controller can autonomously execute the entire sequence of transfers defined by the linked list. After completing a transfer associated with one LLI, it automatically loads the configuration from the next LLI and continues the operation."


```c   
//Create GPDMA link list in code.  Example:
//1. Link list item:
typedef struct {
  volatile uint32_t CTR1_register; 
  volatile uint32_t CTR2_register; 
  volatile uint32_t CBR1_register; 
  volatile uint32_t CSAR_register; //Source address for the transfer.
  volatile uint32_t CDAR_register; //Destination address for the transfer.
  volatile uint32_t CTR3_register;
  volatile uint32_t CBR2_register;
  volatile uint32_t CLLR_register; 
} LinkListItem_t;

//2. List object with 2 linked list items and their memory address:
typedef struct {
  LinkListItem_t node1;   //node1 address: 0x200bffa8 (same as base address)
  LinkListItem_t node2;   //node2 address: 0x200bffc8
} LinkList_t;             //base address:  0x200bffa8
```
**GPDMA channel x linked-list base address register (GPDMA_CxLBAR):**  
In this example, the address of the link list structure object is **0x200b**ffa8
```c
GPDMA_CxLBAR->LBA = 0x200b
GPDMA_CxLBAR      = 0x200b0000
```

**GPDMA channel x linked-list address register (GPDMA_CxLLR):**  
The address of node1 is 0x200b**ffa8**.  Node 0 (staring value of LLR) points to node 1.  
f      |f      |a      |8  
1111|1111|1010|1000  
11|1111|1110|1010|00    Bits LA[15:2]Bits 1:0 Reserved  
3  |f      |e      |a  
```c
//Bits 15:2 LA[15:2]: pointer (16-bit low-significant address) to the next linked-list data structure
pNode0->CLLR_register.LA = 0x3fea;
pNode0->CLLR_register    = 0xfe01ffa8;
//the last 4 hex values aggree to the last 4 hex of the address,
//the first 4 hex values relate to other settings.
```
The address of node2 is 0x200b**ffc8**.  The node 1 points to node 2.  
f      |f      |c      |8     
1111|1111|1100|1000  
11|1111|1111|0010|00  Bits LA[15:2]Bits 1:0 Reserved  
3 |f       |f      |2  
```c
//Bits 15:2 LA[15:2]: pointer (16-bit low-significant address) to the next linked-list data structure
pNode1->CLLR_register.LA = 0x3ff2;    
pNode1->CLLR_register    = 0xfe01ffc8;
//the last 4 hex values aggree to the last 4 hex of the address,
//the first 4 hex values relate to other settings.
```
The node 2 points back to node 1. (The address of node1 is 0x200b**ffa8**.)  
```
//Bits 15:2 LA[15:2]: pointer (16-bit low-significant address) to the next linked-list data structure
pNode2->CLLR_register.LA = 0x3fea;
pNode2->CLLR_register    = 0xfe01ffa8;
//the last 4 hex values aggree to the last 4 hex of the address,
//the first 4 hex values relate to other settings.
```
