//Biblioteki od termometru (konieczna instalacja, jeśli brak)
#include <DallasTemperature.h>
#include <OneWire.h>

// Pin od termometru
int ONE_WIRE_BUS = A3;

int wentylator = A0;  //cool
int grzalka = A1;     //heat

//Uruchomienie komunikacji OneWire na porcie A3
OneWire onewire(A3);

//Poinformowanie arduino, że termometr został podłączony przez OneWire (A3)
DallasTemperature sensors(&onewire);

//Zmienna przechowująca temperaturę z dokładnością 
// do kilku miejsc po przecinku.
float temperatura;

void setup() {
  //Uruchomienie komunikacji przez port szeregowy
  Serial.begin(9600);

  //Uruchomienie komunikacji z termometrem:
  sensors.begin();

  pinMode(wentylator, OUTPUT);
  pinMode(grzalka, OUTPUT);
}

void loop() {
  //Wysłanie do komputera odczytu temperatury
  Serial.print("Sprawdzam temperaturę: ");
  
  sensors.requestTemperatures();            //Wywołanie pomiaru
  temperatura = sensors.getTempCByIndex(0); //Odczyt temperatury
  
  Serial.print(temperatura);
  Serial.println(F(" 'C "));

  Serial.println("Włączam grzanie na 5 s.");
  digitalWrite(grzalka, HIGH);
  delay(5000);
  Serial.println("Włączam chłodzenie na 5 s.");
  digitalWrite(grzalka, LOW);
  digitalWrite(wentylator, HIGH);
  delay(5000);
  digitalWrite(wentylator, LOW);
}
