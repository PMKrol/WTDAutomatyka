//Użycie biblioteki obsługującej silniki krokowe.
#include <Stepper.h>

int pinLaser = 11;
int stepsPerRevolution = 48;  //Ilość kroków na obrót

//Poinformowanie arduino do których pinów podłączone są
// które cewki silników krokowych. Piny silników jako wyjścia
// ustawiane są przez bibliotekę. Nie trzeba ich definiować
// samodzielnie jako wyjścia.
Stepper stepperX(stepsPerRevolution, 2, 3, 4, 5);
Stepper stepperY(stepsPerRevolution, 6, 7, 8, 10);

void setup() {
  pinMode(pinLaser, OUTPUT);

  //Ustawianie prędkości silników krokowych
  // w obrotach na minutę.
  stepperX.setSpeed(60);
  stepperY.setSpeed(60);
}

void loop() {
  digitalWrite(pinLaser, HIGH);   
  stepperX.step(stepsPerRevolution);  //wykonaj ilość kroków w "jedną" stronę
  digitalWrite(pinLaser, LOW);
  stepperX.step(-stepsPerRevolution); //wykonaj ilość kroków w "drugą" stronę
  digitalWrite(pinLaser, HIGH);   
  stepperY.step(stepsPerRevolution);
  digitalWrite(pinLaser, LOW);
  stepperY.step(-stepsPerRevolution);
}
