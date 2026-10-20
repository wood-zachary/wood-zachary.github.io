// lab6_zw.c
// The Internet of Things and Serial Peripheral Interface, E155 Lab 6

#include "main.h"
#include <string.h>

/////////////////////////////////////////////////////////////////
// Constants and Functions
/////////////////////////////////////////////////////////////////

char* webpageStart = "<!DOCTYPE html><html><head><title>E155 Lab 6: The Internet of Things and Serial Peripheral Interface</title>\
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
	</head>\
	<body><h1>E155 Lab 6: The Internet of Things and Serial Peripheral Interface</h1>";
char* ledStr = "<p>LED Control:</p><form action=\""REQ_LED_ON"\"><input type=\"submit\" value=\"Turn the LED on!\"></form>\
	<form action=\""REQ_LED_OFF"\"><input type=\"submit\" value=\"Turn the LED off!\"></form>";
char* resStr = "<p>Resolution Control:</p><form action=\""REQ_RES_8"\"><input type=\"submit\" value=\"8-bit\"></form>\
    <form action=\""REQ_RES_9"\"><input type=\"submit\" value=\"9-bit\"></form>\
    <form action=\""REQ_RES_10"\"><input type=\"submit\" value=\"10-bit\"></form>\
    <form action=\""REQ_RES_11"\"><input type=\"submit\" value=\"11-bit\"></form>\
    <form action=\""REQ_RES_12"\"><input type=\"submit\" value=\"12-bit\"></form>";
char* webpageEnd   = "</body></html>";

// Determines whether a given character sequence is in a char array request, returning 1 if present, -1 if not present
int inString(char request[], char des[]) {
	if (strstr(request, des) != NULL) {return 1;}
	return -1;
}

int updateLEDStatus(char request[], int led_status)
{
	if (inString(request, REQ_LED_OFF) == 1) {
		digitalWrite(LED_PIN, PIO_LOW);
		led_status = 0;
	}
	else if (inString(request, REQ_LED_ON) == 1) {
		digitalWrite(LED_PIN, PIO_HIGH);
		led_status = 1;
	}

	return led_status;
}

int updateTempResolution(char request[], int temp_resolution)
{
    // setResolution is in each branch to prevent unnecessary updating
	if (inString(request, REQ_RES_8) == 1) {
		temp_resolution = 8;
        setResolution(temp_resolution);
	} else if (inString(request, REQ_RES_9) == 1) {
		temp_resolution = 9;
        setResolution(temp_resolution);
	} else if (inString(request, REQ_RES_10) == 1) {
		temp_resolution = 10;
        setResolution(temp_resolution);
	} else if (inString(request, REQ_RES_11) == 1) {
		temp_resolution = 11;
        setResolution(temp_resolution);
	} else if (inString(request, REQ_RES_12) == 1) {
		temp_resolution = 12;
        setResolution(temp_resolution);
	}

	return temp_resolution;
}

int main(void) {
    configureFlash();
    configureClock();

    int led_status = 1;
    int temp_resolution = 8;

    gpioEnable(gpioPinToPort(LED_PIN));
    pinMode(LED_PIN, GPIO_OUTPUT);
    digitalWrite(LED_PIN, led_status);

    USART_TypeDef* USART = initUSART(USART1_ID, 125000);

    initSPI(SPI_BR, SPI_CPOL, SPI_CPHA);

    initDS1722();
    setResolution(temp_resolution);

    while (1) {
        /* Wait for ESP8266 to send a request.
        Requests take the form of '/REQ:<tag>\n', with TAG begin <= 10 characters.
        Therefore the request[] array must be able to contain 18 characters.
        */

        // Receive web request from the ESP
        char request[BUFF_LEN] = "                  "; // initialize to known value
        int charIndex = 0;

        // Keep going until you get end of line character
        while(inString(request, "\n") == -1) {
            // Wait for a complete request to be transmitted before processing
            while(!(USART->ISR & USART_ISR_RXNE));
            request[charIndex++] = readChar(USART);
        }

        // Read temperature over SPI
        char tempStr[100];
        temp_resolution = updateTempResolution(request, temp_resolution);
        sprintf(tempStr, "The temperature is %.4f degrees Celsius with %d-bit resolution",
                readTemperature(), getResolution());
        
        // Update string with current LED state
        led_status = updateLEDStatus(request, led_status);

        char ledStatusStr[20];
        if (led_status == 1)
            sprintf(ledStatusStr,"LED is on!");
        else if (led_status == 0)
            sprintf(ledStatusStr,"LED is off!");

        // Transmit the webpage over UART
        sendString(USART, webpageStart);  // webpage header code

        sendString(USART, "<h2>LED Status</h2>");
        sendString(USART, ledStr);  // button for controlling LED
        sendString(USART, "<p>");
        sendString(USART, ledStatusStr);
        sendString(USART, "</p>");

        sendString(USART, "<h2>Temperature</h2>");
        sendString(USART, resStr);  // button for controlling resolution
        sendString(USART, "<p>");
        sendString(USART, tempStr);
        sendString(USART, "</p>");

        sendString(USART, webpageEnd);
    }
}
