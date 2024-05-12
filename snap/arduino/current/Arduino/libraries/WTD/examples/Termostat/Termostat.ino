//EN: Thermometer libraries (installation required if not available)
//PL: Biblioteki od termometru (konieczna instalacja, jeśli brak)
#include <DallasTemperature.h>
#include <OneWire.h>

//EN: Thermometer pin declaration.
//PL: Pin od termometru.
int ONE_WIRE_BUS = A3;

int wentylator = A0;  //fan
int grzalka = A1;     //heat

//EN: Starting OneWire communication on port A3
//PL: Uruchomienie komunikacji OneWire na porcie A3
OneWire onewire(A3);

//EN: Inform the arduino that the thermometer has been connected via OneWire (A3)
//PL: Poinformowanie arduino, że termometr został podłączony przez OneWire (A3)
DallasTemperature sensors(&onewire);

//EN: A variable storing the temperature with an accuracy
//    of several decimal places.
//PL: Zmienna przechowująca temperaturę z dokładnością
//    do kilku miejsc po przecinku.
float temperatura;

void setup() {
  //EN: Starting communication via the serial port
  //PL: Uruchomienie komunikacji przez port szeregowy
  Serial.begin(9600);

  //EN: Starting communication with the thermometer:
  //PL: Uruchomienie komunikacji z termometrem:
  sensors.begin();

  pinMode(wentylator, OUTPUT);
  pinMode(grzalka, OUTPUT);
}

void loop() {
  //EN: Sending the temperature reading to the computer
  //PL: Wysłanie do komputera odczytu temperatury
  Serial.print("Sprawdzam temperaturę: ");
  
  //EN: Call up a measurement
  //PL: Wywołanie pomiaru
  sensors.requestTemperatures();

  //EN: Temperature reading
  //PL: Odczyt temperatury
  temperatura = sensors.getTempCByIndex(0);
  
  Serial.print(temperatura);
  Serial.println(F(" 'C "));

  //EN: Message: I turn on the heating for 5 seconds.
  Serial.println("Wlaczam grzanie na 5 s.");
  digitalWrite(grzalka, HIGH);
  delay(5000);

  //EN: Message: I turn on the cooling for 5 seconds.
  Serial.println("Wlaczam chłodzenie na 5 s.");
  digitalWrite(grzalka, LOW);
  digitalWrite(wentylator, HIGH);
  delay(5000);
  digitalWrite(wentylator, LOW);
}
