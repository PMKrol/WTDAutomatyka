//EN: Using a library that supports stepper motors.
//PL: Użycie biblioteki obsługującej silniki krokowe.
#include <Stepper.h>

int pinLaser = 11;

//EN: Number of steps per revolution
//PL: Ilość kroków na obrót
int stepsPerRevolution = 48;

/* EN: Inform the Arduino which pins the stepper motor coils
       are connected to. The motor pins are set as outputs
       by the library. You don't have to define them yourself
       as outputs.  */
/* PL: Poinformowanie arduino do których pinów podłączone są
       które cewki silników krokowych. Piny silników jako wyjścia
       ustawiane są przez bibliotekę. Nie trzeba ich definiować
       samodzielnie jako wyjścia. */
Stepper stepperX(stepsPerRevolution, 2, 3, 4, 5);
Stepper stepperY(stepsPerRevolution, 6, 7, 8, 10);

void setup() {
  pinMode(pinLaser, OUTPUT);

  //EN: Setting the speed of stepper motors in revolutions per minute.
  //PL: Ustawianie prędkości silników krokowych w obrotach na minutę.
  stepperX.setSpeed(60);
  stepperY.setSpeed(60);
}

void loop() {
  digitalWrite(pinLaser, HIGH);   

  //EN: take the number of steps in "one" direction
  //PL: wykonaj ilość kroków w "jedną" stronę
  stepperX.step(stepsPerRevolution);
  digitalWrite(pinLaser, LOW);

  //EN: take the number of steps to the "other" side
  //PL: wykonaj ilość kroków w "drugą" stronę
  stepperX.step(-stepsPerRevolution);
  digitalWrite(pinLaser, HIGH);   
  stepperY.step(stepsPerRevolution);
  digitalWrite(pinLaser, LOW);
  stepperY.step(-stepsPerRevolution);
}
