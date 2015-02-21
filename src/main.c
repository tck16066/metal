#include "test.h"

#define GPIO_16_FSEL_PIN_LOW 18
#define GPIO_16_OUTP_REG_PIN 16 // (duh)

int nonmain(void)
{
  unsigned int ra;
  volatile unsigned int *GPIO_FSEL_REG_1 = (unsigned int *)0x20200004;
  volatile unsigned int *GPIO_SET_OUTP_REG_0 = (unsigned int *)0x2020001C;
  volatile unsigned int *GPIO_CLEAR_OUTP_REG_0 = (unsigned int *)0x20200028;

  ra = *GPIO_FSEL_REG_1;
  ra= 1 << GPIO_16_FSEL_PIN_LOW;
  *GPIO_FSEL_REG_1 = ra;

  while(1)
  {
    *GPIO_SET_OUTP_REG_0 = 1 << GPIO_16_OUTP_REG_PIN;
    for(ra = 0; ra < 0x100000; ) inc(&ra);
    *GPIO_CLEAR_OUTP_REG_0 = 1 << GPIO_16_OUTP_REG_PIN;
    for(ra = 0; ra < 0x100000; ) inc(&ra);
  }

  return 0;
}

void exit(int code)
{
  while(1);
}
