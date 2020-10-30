#include "config.h"
#include "pic18f4520.h"
#include "delay.h"
#include "lcd.h"
#include "teclado.h"
#include "yourcoffe.h"

unsigned int atrasoMin = 20;
unsigned int atrasoMed = 150;
unsigned int atrasoMax = 1000;


char opcaoDesejada(char menu)
{
    /* esta função é responsável pela leitura do teclado e
     * retorno do valor como char para o programa principal
     * recebe como parãmetro um char que representa o menu
     * para o qual a opção será usada
     *  "1" -> Tipo de café
     *  "2" -> Tamanho do café
     *  "3" -> Confirmação
     */
    
    char tmp;
    if(menu != '3'){
        lcd_cmd(L_CLR);
        lcd_cmd(L_L1);
        lcd_str("  PRESSIONE A");
        lcd_cmd(L_L2);
        lcd_str(" OPCAO DESEJADA ");
    }

    while(1) // ler
    {
        TRISD = 0x0F;
        tmp = tc_tecla(0) + 0x30;
        TRISD = 0x00;
        if(menu == '1' && (tmp == '1' || tmp == '2' || tmp == '3' || tmp == '4')) // cafes
            break;
        else if((tmp == '1' || tmp == '2')) // tamanhos e confirmacao
            break;

    }
    
    return tmp;
}

void scrollDisplay(char *linha1, char *linha2)
{
    /* esta função é responsável pelo movimento da mensagem
     * no display LCD a fim de uma melhor visualização.
     * recebe dois ponteiros tipo char para as duas linhas.
     */
    
    int i;
    lcd_cmd(L_CLR);
    lcd_cmd(L_L1);
    lcd_str(linha1);
    lcd_cmd(L_L2);
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
        lcd_cmd(0x18); //display shift left
    }

    atraso_ms(atrasoMax);
}

void tempoPreparo(int segundos)
{
    /* esta função é responsável por mostrar o valor restante
     * (em segundos)do tempo de preparo no display 7-SEGMENTOS
     * e também realiza a animção dos led's do PORTB simulando 
     * um carregamento.
     * recebe como parametro um int com o tempo em segundos
     */
    
    BitClr(INTCON2, 7); //liga pull up
    ADCON1 = 0x0E;      //config AD
    TRISD = 0x00;       //config. a porta D
    TRISA = 0x00;       //config. a porta A
    TRISB = 0x00;
    PORTB = 0x00;
    const char valor[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
    const char leds[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
    char aux = 0;
    unsigned int k, delay = 1000, i;
    while(1)
    {
        PORTB = leds[aux++]; if(aux == 8) aux = 0;
        for(i = 0; i < 50; i++) // for para ficar um pouco mais lento a aparição do número
        {
            PORTD = valor[(segundos / 1) % 10];
            BitSet(PORTA, 5);
            BitClr(PORTA, 4);
            BitClr(PORTA, 3);
            BitClr(PORTA, 2);
            for(k = 0; k < delay; k++);
            PORTD = valor[(segundos / 10) % 10];
            BitClr(PORTA, 5);
            BitSet(PORTA, 4);
            BitClr(PORTA, 3);
            BitClr(PORTA, 2);
            for(k = 0; k < delay; k++);
            PORTD = valor[(segundos / 100) % 10];
            BitClr(PORTA, 5);
            BitClr(PORTA, 4);
            BitSet(PORTA, 3);
            BitClr(PORTA, 2);
            for(k = 0; k < delay; k++);
            PORTD = valor[(segundos / 1000) % 10];
            BitClr(PORTA, 5);
            BitClr(PORTA, 4);
            BitClr(PORTA, 3);
            BitSet(PORTA, 2);
            for(k = 0; k < delay; k++);
       
        }
        
        segundos--;
        
        if(segundos == -1) break;
    }   
    
    BitClr(PORTA, 5);
    BitClr(PORTA, 4);
    BitClr(PORTA, 3);
    BitClr(PORTA, 2);
    PORTB = 0x00;
    
}