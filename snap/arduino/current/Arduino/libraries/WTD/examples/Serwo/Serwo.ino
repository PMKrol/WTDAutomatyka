/*
 Controlling a servo position using a potentiometer (variable resistor)
 by Michal Rinott <http://people.interaction-ivrea.it/m.rinott>

 modified on 8 Nov 2013
 by Scott Fitzgerald
 http://www.arduino.cc/en/Tutorial/Knob
*/

#include <Servo.h>

//EN: Servo myservo; Creates an object related to seromechanism control.
// All functions responsible for control will be
// hidden under the name 'my servo'. It is in the (very large)
// to simplify, the variable to which the functions are assigned,
// which can be referenced after a dot.

//PL: Tworzy obiekt związany ze sterowaniem seromechanizmu.
// Wszystkie funkcje odpowiedzialne za sterowanie będą
// ukryte pod nazwą 'my servo'. Jest to w (bardzo dużym)
// uproszczeniu zmienna, do której przypisane są funkcje,
// do których można się odwołać po kropce.
Servo myservo;

//EN: The pin number through which Arduino will communicate
//    with servo.
//PL: Numer pinu, przez który arduino będzie komunikowało się
//    z serwomechanizmem.
int servoPin = 4;

//EN: potPin - Pin to which the potentiometer is connected.
//PL: potPin - Pin, do którego podłączony jest potencjometr.
int potPin = A7;

//EN: The variable in which value read from the potentiometer
//    will be stored.
//PL: Zmienna, w której będzie przechowywana wartość
//    podczytana z potencjometru.
int potVal;

//EN: The servomechanism takes values in degrees.
//    degVal will store the rotation value after conversion
//    from the value read from the potentiometer.
//PL: Serwomechanizm przyjmuje wartości w stopniach.
//    degVal będzie przechowywało wartość obrotu po
//    przeliczeniu z wartości odczytanej z potencjometru.
int degVal;

void setup() {
  //EN: Telling the arduino which pin the servo is connected to.
  //PL: Poinformowanie arduino, do którego pinu podłączone jest serwo.
  myservo.attach(servoPin);
}

void loop() {

  //EN: Reading the value from the potentiometer (between 0 and 1023).
  //PL: Odczytanie wartości z potencjometru (między 0 a 1023).
  potVal = analogRead(potPin);
  

  //EN: The map() function scales (linearly) the given value from a certain range
  // (the domains, marked below as values from min_x to max_x),
  // to a different value from a different range (counter-domain, min_y to max_y).
  //
  // map(value, min_x, max_x, min_y, max_y)
  //
  // which means we want to scale the value that takes values in range
  // min_x to maximum max_x, to a value from the range min_y to max_y.
  // In this example, the value read by analogRead will be recalculated
  // (that is, values from 0 to 1023) to a value in degrees (from 0 to 180).

  //PL: Funkcja map () przeskalowywuje (liniowo) podaną wartość z pewnego zakresu
  // (dziedziny, poniżej oznaczonej jako wartości od min_x do max_x), 
  // na inną wartość z innego zakresu (przeciwdziedzina, od min_y do max_y). 
  //
  // map(wartosc,  min_x, max_x,  min_y, max_y)
  //
  // co oznacza, że chcemy przeskalować wartość, która przyjmuje minimalną 
  // wartosc min_x i maksymalnie max_x, na wartość z przedziału min_y do max_y. 
  // W tym przykładzie przeliczana będzie wartość odczytywana przez analogRead 
  // (czyli wartości od 0 do 1023) na wartość w stipniach (od 0 do 180).

  degVal = map(potVal, 0, 1023, 0, 180);
  
  //EN: Sets the servo to an angle.
  //PL: Ustawia serwo na kąt.
  myservo.write(degVal);
  delay(15);                           
}
