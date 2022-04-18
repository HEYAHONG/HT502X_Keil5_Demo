#include "ARMCM0.h"
#include "stdbool.h"
#include "stdint.h"
#include "FreeRTOS.h"
#include "task.h"

#define M8(adr) (*(( volatile uint8_t *) (adr))) //无需考虑对齐问题
#define M16(adr) (*(( volatile uint16_t *) (adr))) //需半字对齐，即 adr 的 bit0 必须为 0
#define M32(adr) (*(( volatile uint32_t *) (adr))) //需字对齐，即 adr 的 bit0 与 bit1 都必须为 0

#define WATCHDOG_BASE 0x40010000
#define WATCHDOG_WDTCLR (WATCHDOG_BASE+0x04)
#define WATCHDOG_CLR() M16(WATCHDOG_WDTCLR)=0xAAFF;



/*
Flash读保护选项
*/
const uint32_t __attribute__((at(0xFC0))) __attribute__((unused)) FlashReadProtect=0xFFFFFFFF;


/*
空闲任务
*/
void vApplicationIdleHook( void )
{
  //喂狗
  WATCHDOG_CLR();
}

void main_task1(void *arg)
{
  while(1)
  {
    vTaskDelay(5);
  }
}

void main_task2(void *arg)
{
 
  while(1)
  {
     vTaskDelay(5);
  }
}



int main()
{
	
	/*创建任务*/
  xTaskCreate( main_task1, "main_task1",128, NULL, 1, NULL );
  xTaskCreate( main_task2, "main_task2",128, NULL, 1, NULL );
  
  /* Start the scheduler so the tasks start executing. */
  vTaskStartScheduler();

	while(true);
}

