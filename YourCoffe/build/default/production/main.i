# 1 "main.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "main.c" 2
# 1 "./config.h" 1
# 38 "./config.h"
#pragma config OSC=HS
#pragma config WDT=OFF
#pragma config LVP=OFF
#pragma config DEBUG = OFF
#pragma config WDTPS = 1
# 1 "main.c" 2

# 1 "./pic18f4520.h" 1
# 2 "main.c" 2

# 1 "./delay.h" 1



void atraso_ms(int t);
# 3 "main.c" 2

# 1 "./lcd.h" 1
# 14 "./lcd.h"
void lcd_init(void);
void lcd_cmd(unsigned char val);
void lcd_dat(unsigned char val);
void lcd_str(const char* str);
# 4 "main.c" 2

# 1 "./teclado.h" 1







    unsigned char tc_tecla(unsigned int timeout);
# 5 "main.c" 2

# 1 "./yourcoffe.h" 1



void tempoPreparo(int segundos);
char opcaoDesejada(char tipo);
void scrollDisplay(char *linha1, char *linha2);
# 6 "main.c" 2

# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\string.h" 1 3



# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\musl_xc8.h" 1 3
# 4 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\string.h" 2 3






# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\features.h" 1 3
# 10 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\string.h" 2 3
# 25 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\string.h" 3
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\bits/alltypes.h" 1 3
# 122 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\bits/alltypes.h" 3
typedef unsigned size_t;
# 168 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\bits/alltypes.h" 3
typedef __int24 int24_t;
# 204 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\bits/alltypes.h" 3
typedef __uint24 uint24_t;
# 411 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\bits/alltypes.h" 3
typedef struct __locale_struct * locale_t;
# 25 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\string.h" 2 3


void *memcpy (void *restrict, const void *restrict, size_t);
void *memmove (void *, const void *, size_t);
void *memset (void *, int, size_t);
int memcmp (const void *, const void *, size_t);
void *memchr (const void *, int, size_t);

char *strcpy (char *restrict, const char *restrict);
char *strncpy (char *restrict, const char *restrict, size_t);

char *strcat (char *restrict, const char *restrict);
char *strncat (char *restrict, const char *restrict, size_t);

int strcmp (const char *, const char *);
int strncmp (const char *, const char *, size_t);

int strcoll (const char *, const char *);
size_t strxfrm (char *restrict, const char *restrict, size_t);

char *strchr (const char *, int);
char *strrchr (const char *, int);

size_t strcspn (const char *, const char *);
size_t strspn (const char *, const char *);
char *strpbrk (const char *, const char *);
char *strstr (const char *, const char *);
char *strtok (char *restrict, const char *restrict);

size_t strlen (const char *);

char *strerror (int);
# 65 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.10\\pic\\include\\c99\\string.h" 3
char *strtok_r (char *restrict, const char *restrict, char **restrict);
int strerror_r (int, char *, size_t);
char *stpcpy(char *restrict, const char *restrict);
char *stpncpy(char *restrict, const char *restrict, size_t);
size_t strnlen (const char *, size_t);
char *strdup (const char *);
char *strndup (const char *, size_t);
char *strsignal(int);
char *strerror_l (int, locale_t);
int strcoll_l (const char *, const char *, locale_t);
size_t strxfrm_l (char *restrict, const char *restrict, size_t, locale_t);




void *memccpy (void *restrict, const void *restrict, int, size_t);
# 7 "main.c" 2


void main(void)
{
    unsigned char i, tempo;
    unsigned char cafe, tamanho, corfirmar;
    unsigned char cafes[5][10] = {"EXPRESSO", "AMERICANO", "CAPUCCINO", "LATTE"};
    unsigned char tamanhos[2][8] = {"90ml" , "150ml"};


    (*(volatile __near unsigned char*)0xFC1) = 0x06;
    (*(volatile __near unsigned char*)0xF95) = 0x00;
    (*(volatile __near unsigned char*)0xF96) = 0x00;
    (*(volatile __near unsigned char*)0xF93) = 0x01;


    (*(volatile __near unsigned char*)0xF93) = 0xF8;

    lcd_init();

    for(;;)
    {
        (*(volatile __near unsigned char*)0xFC1) = 0x06;
        (*(volatile __near unsigned char*)0xF95) = 0x00;
        (*(volatile __near unsigned char*)0xF96) = 0x00;
        (*(volatile __near unsigned char*)0xF93) = 0x01;

        (*(volatile __near unsigned char*)0xF93) = 0xF8;

        lcd_cmd(0x01);
        lcd_cmd(0x80);
        lcd_str("   Y0URC0FF3 ");
        lcd_cmd(0xC0);
        lcd_str("ESCOLHA SEU CAFE");
        atraso_ms(2000);

        do
        {
            scrollDisplay("(1) expresso  (2) americano", "(3) capuccino (4) latte       ");
            cafe = opcaoDesejada('1');

            char frase[50];

            switch (cafe)
            {
                case '1':
                    strcpy(frase, "TAMANHO DO EXPRESSO");
                    tempo = 30;
                    break;
                case '2':
                    strcpy(frase, "TAMANHO DO AMERICANO");
                    tempo = 50;
                    break;
                case '3':
                    strcpy(frase, "TAMANHO DO CAPUCCINO");
                    tempo = 60;
                    break;
                case '4':
                    strcpy(frase, "TAMANHO DO LATTE");
                    tempo = 40;
                    break;
            }

            scrollDisplay(frase, "(1)90 ml (2)150 ml            ");

            tamanho = opcaoDesejada('2');





            strcpy(frase,cafes[(cafe - '0') - 1]);
            strcat(frase," ");
            strcat(frase, tamanhos[(tamanho - '0')- 1]);

            lcd_cmd(0x01);
            lcd_cmd(0x80);
            lcd_str(frase);
            lcd_cmd(0xC0);
            lcd_str("(1)OK (2)CANCEL ");


            corfirmar = opcaoDesejada('3');

        }while(corfirmar == '2');


        if(tamanho == '2')
        tempo *= 1.2;


        lcd_cmd(0x01);
        lcd_cmd(0x80);
        lcd_str("PREPARANDO O ");
        lcd_cmd(0xC0);
        lcd_str("CAFE DESEJADO    ");

        tempoPreparo(tempo);

        scrollDisplay("SEU CAFE ESTA PRONTO", "Mais delicioso impossivel      ");

    }
}
