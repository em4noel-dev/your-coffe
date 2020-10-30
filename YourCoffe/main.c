#include "config.h"
#include "pic18f4520.h"
#include "delay.h"
#include "lcd.h"
#include "teclado.h"
#include "yourcoffe.h"
#include <string.h>

void main(void) 
{
    unsigned char i, tempo;
    unsigned char cafe, tamanho, corfirmar;
    unsigned char cafes[5][10] = {"EXPRESSO", "AMERICANO", "CAPUCCINO", "LATTE"};
    unsigned char tamanhos[2][8] = {"90ml" , "150ml"};
    
    //comfiguração das entradas
    ADCON1 = 0x06;
    TRISD = 0x00;
    TRISE = 0x00;
    TRISB = 0x01;

    //Teclado numérico
    TRISB = 0xF8;
    
    lcd_init();
    
    for(;;)
    { 
        ADCON1 = 0x06;
        TRISD = 0x00;
        TRISE = 0x00;
        TRISB = 0x01;
        
        TRISB = 0xF8;
        
        lcd_cmd(L_CLR);
        lcd_cmd(L_L1);
        lcd_str("   Y0URC0FF3 ");
        lcd_cmd(L_L2);
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
            
            //strcpy(frase,cafes[(cafe - '0') - 1]);
            //strcat(frase,"-");
            //strcat(frase, tamanhos[(tamanho - '0')- 1]);
            //scrollDisplay(frase, "(1)OK (2)Cancel");
            strcpy(frase,cafes[(cafe - '0') - 1]);
            strcat(frase," ");
            strcat(frase, tamanhos[(tamanho - '0')- 1]);
            
            lcd_cmd(L_CLR);
            lcd_cmd(L_L1);
            lcd_str(frase);
            lcd_cmd(L_L2);
            lcd_str("(1)OK (2)CANCEL ");
            //atraso_ms(6000);
            
            corfirmar = opcaoDesejada('3');
            
        }while(corfirmar == '2');    
            
        
        if(tamanho == '2') // se a opcao escolhido for 150 ml o tempo demora + 20%
        tempo *= 1.2;


        lcd_cmd(L_CLR);
        lcd_cmd(L_L1);
        lcd_str("PREPARANDO O ");
        lcd_cmd(L_L2);
        lcd_str("CAFE DESEJADO    ");

        tempoPreparo(tempo);

        scrollDisplay("SEU CAFE ESTA PRONTO", "Mais delicioso impossivel      ");
            
    }
}