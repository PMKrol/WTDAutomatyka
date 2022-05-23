#include <HCSR04.h>

//Do których pinów podłączony jest czujnik.
int distanceSensorTrigPin = 4;
int distanceSensorEchoPin = 3;

//Przygotowanie czujnika do pracy
UltraSonicDistanceSensor distanceSensor(distanceSensorTrigPin, distanceSensorEchoPin); 

//Zmienna przechowująca odczytaną odległość.
// Tym razem zmienna jest typu float, a nie int. 
// Zmienne typu float mogą przechowywać wartości z ułamkami,
// natomiast int tylko wartości całkowite.
float distance;

void setup () {
    Serial.begin(9600);  // Uruchomienie komunikacji z komputerem
}

void loop () {
    //Co 0.5s program odczytuje odległość i wysyła ją do komputera
    distance = distanceSensor.measureDistanceCm();
    Serial.println(distance);
    delay(500);
}
