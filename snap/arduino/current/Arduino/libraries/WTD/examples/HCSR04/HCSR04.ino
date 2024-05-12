#include <HCSR04.h>

//EN: Which pins is the sensor connected to?
//PL: Do których pinów podłączony jest czujnik.
int distanceSensorTrigPin = 4;
int distanceSensorEchoPin = 3;

//EN: Preparing the sensor for operation
//PL: Przygotowanie czujnika do pracy
UltraSonicDistanceSensor distanceSensor(distanceSensorTrigPin, distanceSensorEchoPin); 

//EN: Variable storing the read distance.
//    This time the variable is of type float, not int.
//    Float variables can store values with fractions,
//    while int only integer values.
//PL: Zmienna przechowująca odczytaną odległość.
//    Tym razem zmienna jest typu float, a nie int.
//    Zmienne typu float mogą przechowywać wartości z ułamkami,
//    natomiast int tylko wartości całkowite.
float distance;

void setup () {
    //EN: Start communication with the computer
    //PL: Uruchomienie komunikacji z komputerem
    Serial.begin(9600);
}

void loop () {
    //EN: Reads and remembers the distance value
    //PL: Odczytuje i zapamiętuje wartość odległości
    distance = distanceSensor.measureDistanceCm();
    
    //EN: Message: Distance is
    Serial.print("Odleglosc wynosi: ");
    Serial.print(distance);
    Serial.println(" cm.");
    
    delay(500);
}
