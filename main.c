#include "ARMCM0.h"
#include "stdbool.h"
#include "stdint.h"
#include "FreeRTOS.h"
#include "task.h"

#define M8(adr) (*(( volatile uint8_t *) (adr))) //���迼�Ƕ�������
#define M16(adr) (*(( volatile uint16_t *) (adr))) //����ֶ��룬�� adr �� bit0 ����Ϊ 0
#define M32(adr) (*(( volatile uint32_t *) (adr))) //���ֶ��룬�� adr �� bit0 �� bit1 ������Ϊ 0

#define WATCHDOG_BASE 0x40010000
#define WATCHDOG_WDTCLR (WATCHDOG_BASE+0x04)
#define WATCHDOG_CLR() M16(WATCHDOG_WDTCLR)=0xAAFF;



/*
Flash������ѡ��
*/
const uint32_t __attribute__((at(0xFC0))) __attribute__((unused)) FlashReadProtect=0xFFFFFFFF;


/*
��������
*/
void vApplicationIdleHook( void )
{
  //ι��
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
	
	/*��������*/
  xTaskCreate( main_task1, "main_task1",128, NULL, 1, NULL );
  xTaskCreate( main_task2, "main_task2",128, NULL, 1, NULL );
  
  /* Start the scheduler so the tasks start executing. */
  vTaskStartScheduler();

	while(true);
}

