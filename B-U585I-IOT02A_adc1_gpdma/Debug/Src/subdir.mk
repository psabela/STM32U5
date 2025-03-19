################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/adc1_assembly.s \
../Src/gpdma_assembly.s \
../Src/gpdma_ch15_assembly.s \
../Src/gpio_assembly.s \
../Src/nvic_assembly.s \
../Src/pwd_assembly.s \
../Src/rcc_assembly.s \
../Src/tim2_assembly.s \
../Src/tim8_assembly.s 

C_SRCS += \
../Src/main.c \
../Src/syscalls.c \
../Src/sysmem.c 

OBJS += \
./Src/adc1_assembly.o \
./Src/gpdma_assembly.o \
./Src/gpdma_ch15_assembly.o \
./Src/gpio_assembly.o \
./Src/main.o \
./Src/nvic_assembly.o \
./Src/pwd_assembly.o \
./Src/rcc_assembly.o \
./Src/syscalls.o \
./Src/sysmem.o \
./Src/tim2_assembly.o \
./Src/tim8_assembly.o 

S_DEPS += \
./Src/adc1_assembly.d \
./Src/gpdma_assembly.d \
./Src/gpdma_ch15_assembly.d \
./Src/gpio_assembly.d \
./Src/nvic_assembly.d \
./Src/pwd_assembly.d \
./Src/rcc_assembly.d \
./Src/tim2_assembly.d \
./Src/tim8_assembly.d 

C_DEPS += \
./Src/main.d \
./Src/syscalls.d \
./Src/sysmem.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m33 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@" "$<"
Src/%.o Src/%.su Src/%.cyclo: ../Src/%.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m33 -std=gnu11 -g3 -DDEBUG -DSTM32 -DB_U585I_IOT02A -DSTM32U585AIIxQ -DSTM32U5 -c -I../Inc -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/adc1_assembly.d ./Src/adc1_assembly.o ./Src/gpdma_assembly.d ./Src/gpdma_assembly.o ./Src/gpdma_ch15_assembly.d ./Src/gpdma_ch15_assembly.o ./Src/gpio_assembly.d ./Src/gpio_assembly.o ./Src/main.cyclo ./Src/main.d ./Src/main.o ./Src/main.su ./Src/nvic_assembly.d ./Src/nvic_assembly.o ./Src/pwd_assembly.d ./Src/pwd_assembly.o ./Src/rcc_assembly.d ./Src/rcc_assembly.o ./Src/syscalls.cyclo ./Src/syscalls.d ./Src/syscalls.o ./Src/syscalls.su ./Src/sysmem.cyclo ./Src/sysmem.d ./Src/sysmem.o ./Src/sysmem.su ./Src/tim2_assembly.d ./Src/tim2_assembly.o ./Src/tim8_assembly.d ./Src/tim8_assembly.o

.PHONY: clean-Src

