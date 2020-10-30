# 1 "yourcoffe.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "yourcoffe.c" 2
# 1 "./config.h" 1
# 38 "./config.h"
#pragma config OSC=HS
#pragma config WDT=OFF
#pragma config LVP=OFF
#pragma config DEBUG = OFF
#pragma config WDTPS = 1
# 1 "yourcoffe.c" 2

# 1 "./pic18f4520.h" 1
# 2 "yourcoffe.c" 2

# 1 "./delay.h" 1



void atraso_ms(int t);
# 3 "yourcoffe.c" 2

# 1 "./lcd.h" 1
# 14 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 4 "yourcoffe.c" 2

# 1 "./teclado.h" 1







    unsigned char tc_tecla(unsigned int timeout);
# 5 "yourcoffe.c" 2

# 1 "./yourcoffe.h" 1



void tempoPreparo(int segundos);
char opcaoDesejada(char tipo);
void scrollDisplay(char *linha1, char *linha2);
# 6 "yourcoffe.c" 2


unsigned int atrasoMin = 20;
unsigned int atrasoMed = 150;
unsigned int atrasoMax = 1000;


char opcaoDesejada(char menu)
{
# 24 "yourcoffe.c"
    char tmp;
    if(menu != '3'){
        lcd_cmd(0x01);
        lcd_cmd(0x80);
        lcd_str("  PRESSIONE A");
        lcd_cmd(0xC0);
        lcd_str(" OPCAO DESEJADA ");
    }

    while(1)
    {
        (*(volatile __near unsigned char*)0xF95) = 0x0F;
        tmp = tc_tecla(0) + 0x30;
        (*(volatile __near unsigned char*)0xF95) = 0x00;
        if(menu == '1' && (tmp == '1' || tmp == '2' || tmp == '3' || tmp == '4'))
            break;
        else if((tmp == '1' || tmp == '2'))
            break;

    }

    return tmp;
}

void scrollDisplay(char *linha1, char *linha2)
{





    int i;
    lcd_cmd(0x01);
    lcd_cmd(0x80);
    lcd_str(linha1);
    lcd_cmd(0xC0);
    lcd_str(linha2);
    atraso_ms(atrasoMax);

    for (i = 0; i < 14; i++) {
        atraso_ms(atrasoMed);
        lcd_cmd(0x18);
    }

    for (i = 0; i < 22; i++) {
        atraso_ms(atrasoMed);
        lcd_cmd(0x1C);
    }

    for (i = 0; i < 15; i++) {
        atraso_ms(atrasoMed);
        lcd_cmd(0x18);
    }

    atraso_ms(atrasoMax);
}

void tempoPreparo(int segundos)
{







    (((*(volatile __near unsigned char*)0xFF1)) &= ~(1<<7));
    (*(volatile __near unsigned char*)0xFC1) = 0x0E;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF92) = 0x00;
    (*(volatile __near unsigned char*)0xF93) = 0x00;
    (*(volatile __near unsigned char*)0xF81) = 0x00;
    const char valor[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
    const char leds[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
    char aux = 0;
    unsigned int k, delay = 1000, i;
    while(1)
    {
        (*(volatile __near unsigned char*)0xF81) = leds[aux++]; if(aux == 8) aux = 0;
        for(i = 0; i < 50; i++)
        {
            (*(volatile __near unsigned char*)0xF83) = valor[(segundos / 1) % 10];
            (((*(volatile __near unsigned char*)0xF80)) |= (1<<5));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<2));
            for(k = 0; k < delay; k++);
            (*(volatile __near unsigned char*)0xF83) = valor[(segundos / 10) % 10];
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
            (((*(volatile __near unsigned char*)0xF80)) |= (1<<4));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<2));
            for(k = 0; k < delay; k++);
            (*(volatile __near unsigned char*)0xF83) = valor[(segundos / 100) % 10];
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
            (((*(volatile __near unsigned char*)0xF80)) |= (1<<3));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<2));
            for(k = 0; k < delay; k++);
            (*(volatile __near unsigned char*)0xF83) = valor[(segundos / 1000) % 10];
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
            (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
            (((*(volatile __near unsigned char*)0xF80)) |= (1<<2));
            for(k = 0; k < delay; k++);

        }

        segundos--;

        if(segundos == -1) break;
    }

    (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<5));
    (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<4));
    (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<3));
    (((*(volatile __near unsigned char*)0xF80)) &= ~(1<<2));
    (*(volatile __near unsigned char*)0xF81) = 0x00;

}
