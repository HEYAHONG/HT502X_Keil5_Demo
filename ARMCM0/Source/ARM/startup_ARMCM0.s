;/**************************************************************************//**
; * @file     startup_ARMCM0.s
; * @brief    CMSIS Core Device Startup File for
; *           ARMCM0 Device
; * @version  V1.0.1
; * @date     23. July 2019
; ******************************************************************************/
;/*
; * Copyright (c) 2009-2019 Arm Limited. All rights reserved.
; *
; * SPDX-License-Identifier: Apache-2.0
; *
; * Licensed under the Apache License, Version 2.0 (the License); you may
; * not use this file except in compliance with the License.
; * You may obtain a copy of the License at
; *
; * www.apache.org/licenses/LICENSE-2.0
; *
; * Unless required by applicable law or agreed to in writing, software
; * distributed under the License is distributed on an AS IS BASIS, WITHOUT
; * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; * See the License for the specific language governing permissions and
; * limitations under the License.
; */

;//-------- <<< Use Configuration Wizard in Context Menu >>> ------------------


;<h> Stack Configuration
;  <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
;</h>

Stack_Size      EQU      0x00000400

                AREA     STACK, NOINIT, READWRITE, ALIGN=3
__stack_limit
Stack_Mem       SPACE    Stack_Size
__initial_sp


;<h> Heap Configuration
;  <o> Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
;</h>

Heap_Size       EQU      0x00000C00

                IF       Heap_Size != 0                      ; Heap is provided
                AREA     HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE    Heap_Size
__heap_limit
                ENDIF


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA     RESET, DATA, READONLY
                EXPORT   __Vectors
                EXPORT   __Vectors_End
                EXPORT   __Vectors_Size

__Vectors       DCD      __initial_sp                        ;     Top of Stack
                DCD      Reset_Handler                       ;     Reset Handler
                DCD      NMI_Handler                         ; -14 NMI Handler
                DCD      HardFault_Handler                   ; -13 Hard Fault Handler
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      SVC_Handler                         ;  -5 SVCall Handler
                DCD      0                                   ;     Reserved
                DCD      0                                   ;     Reserved
                DCD      PendSV_Handler                      ;  -2 PendSV Handler
                DCD      SysTick_Handler                     ;  -1 SysTick Handler

                ; Interrupts
                DCD      PMU_Handler                  ;   0 PMU
                DCD      AES_ECC_RAND_GHASH_Handler   ;   1 AES_ECC_RAND_GHASH
                DCD      EXIT0_Handler                ;   2 EXIT0
                DCD      EXIT1_Handler                ;   3 EXIT1
                DCD      EXIT2_Handler                ;   4 EXIT2
                DCD      EXIT3_Handler                ;   5 EXIT3
                DCD      EXIT4_Handler                ;   6 EXIT4
                DCD      EXIT5_Handler                ;   7 EXIT5
                DCD      EXIT6_Handler                ;   8 EXIT6
                DCD      UART0_Handler                ;   9 UART0
				DCD      UART1_Handler                ;   10 UART1
                DCD      UART2_Handler                ;   11 UART2
                DCD      UART3_Handler                ;   12 UART3
                DCD      UART4_Handler                ;   13 UART4
                DCD      UART5_Handler                ;   14 UART5
                DCD      TMR0_Handler                 ;   15 TMR0
                DCD      TMR1_Handler                 ;   16 TMR1
                DCD      TMR2_Handler                 ;   17 TMR2
                DCD      TMR3_Handler                 ;   18 TMR3
                DCD      TBS_Handler                  ;   19 TBS
				DCD      RTC_Handler                  ;   20 RTC
                DCD      I2C_Handler                  ;   21 I2C
                DCD      SPI_Handler                  ;   22 SPI
                DCD      Resv1_Handler                ;   23 Resv1
                DCD      Resv2_Handler                ;   24 Resv2
                DCD      EMU_Handler                  ;   25 EMU
                DCD      DMA_Handler                  ;   26 DMA
                DCD      KEY_Handler                  ;   27 KEY
                DCD      EXIT7_Handler                ;   28 EXIT7
                DCD      EXIT8_Handler                ;   29 EXIT8
				DCD      EXIT9_Handler                ;   30 EXIT9
                DCD      Resv3_Handler                ;   31 Resv3

__Vectors_End
__Vectors_Size  EQU      __Vectors_End - __Vectors


                AREA     |.text|, CODE, READONLY

; Reset Handler

Reset_Handler   PROC
                EXPORT   Reset_Handler             [WEAK]
                IMPORT   SystemInit
                IMPORT   __main

                LDR      R0, =SystemInit
                BLX      R0
                LDR      R0, =__main
                BX       R0
                ENDP

; The default macro is not used for HardFault_Handler
; because this results in a poor debug illusion.
HardFault_Handler PROC
                EXPORT   HardFault_Handler         [WEAK]
                B        .
                ENDP

; Macro to define default exception/interrupt handlers.
; Default handler are weak symbols with an endless loop.
; They can be overwritten by real handlers.
                MACRO
                Set_Default_Handler  $Handler_Name
$Handler_Name   PROC
                EXPORT   $Handler_Name             [WEAK]
                B        .
                ENDP
                MEND


; Default exception/interrupt handler

                Set_Default_Handler  NMI_Handler
                Set_Default_Handler  SVC_Handler
                Set_Default_Handler  PendSV_Handler
                Set_Default_Handler  SysTick_Handler

                Set_Default_Handler  PMU_Handler
                Set_Default_Handler  AES_ECC_RAND_GHASH_Handler
                Set_Default_Handler  EXIT0_Handler
                Set_Default_Handler  EXIT1_Handler
                Set_Default_Handler  EXIT2_Handler
                Set_Default_Handler  EXIT3_Handler
                Set_Default_Handler  EXIT4_Handler
                Set_Default_Handler  EXIT5_Handler
                Set_Default_Handler  EXIT6_Handler
                Set_Default_Handler  UART0_Handler
				Set_Default_Handler  UART1_Handler
                Set_Default_Handler  UART2_Handler
                Set_Default_Handler  UART3_Handler
                Set_Default_Handler  UART4_Handler
                Set_Default_Handler  UART5_Handler
                Set_Default_Handler  TMR0_Handler
                Set_Default_Handler  TMR1_Handler
                Set_Default_Handler  TMR2_Handler
                Set_Default_Handler  TMR3_Handler
                Set_Default_Handler  TBS_Handler
				Set_Default_Handler  RTC_Handler
                Set_Default_Handler  I2C_Handler
                Set_Default_Handler  SPI_Handler
                Set_Default_Handler  Resv1_Handler
                Set_Default_Handler  Resv2_Handler
                Set_Default_Handler  EMU_Handler
                Set_Default_Handler  DMA_Handler
                Set_Default_Handler  KEY_Handler
                Set_Default_Handler  EXIT7_Handler
                Set_Default_Handler  EXIT8_Handler
				Set_Default_Handler  EXIT9_Handler
                Set_Default_Handler  Resv3_Handler         

                ALIGN


; User setup Stack & Heap

                IF       :LNOT::DEF:__MICROLIB
                IMPORT   __use_two_region_memory
                ENDIF

                EXPORT   __stack_limit
                EXPORT   __initial_sp
                IF       Heap_Size != 0                      ; Heap is provided
                EXPORT   __heap_base
                EXPORT   __heap_limit
                ENDIF

                END
