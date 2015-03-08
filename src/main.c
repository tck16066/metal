#include "gpio.h"

#include "test.h"

int nonmain(void)
{
  unsigned int ra;

  ra= 1 << GPIO_16_FSEL_PIN_LOW;
  SET_REG_32(GPIO_FSEL_REG_1, ra);

  while(1)
  {
    SET_REG_32(GPIO_SET_OUTP_REG_0, 1 << GPIO_16_OUTP_REG_PIN);
    for(ra = 0; ra < 0x100000; ) inc(&ra);
    SET_REG_32(GPIO_CLEAR_OUTP_REG_0,1 << GPIO_16_OUTP_REG_PIN);
    for(ra = 0; ra < 0x100000; ) inc(&ra);
  }

  return 0;
}

void exit(int code)
{
  while(1);
}
