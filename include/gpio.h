#ifndef __GPIO_H__
#define __GPIO_H__

#define GPIO_16_FSEL_PIN_LOW 18
#define GPIO_16_OUTP_REG_PIN 16 // (duh)

#define GPIO_FSEL_REG_1        0x20200004
#define GPIO_SET_OUTP_REG_0    0x2020001C
#define GPIO_CLEAR_OUTP_REG_0  0x20200028

#define VAL_REG_32(__reg_addr__) *((unsigned int*)__reg_addr__)
#define SET_REG_32(__reg_addr__, __val__) *((unsigned int*)__reg_addr__) = __val__

#endif
