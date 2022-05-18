/*
 Controlling a servo position using a potentiometer (variable resistor)
 by Michal Rinott <http://people.interaction-ivrea.it/m.rinott>

 modified on 8 Nov 2013
 by Scott Fitzgerald
 http://www.arduino.cc/en/Tutorial/Knob
*/

#include <Servo.h>

Servo myservo;    //Tworzy obiekt związany ze sterowaniem seromechanizmu.
                  // Wszystkie funkcje odpowiedzialne za sterowanie będą 
                  // ukryte pod nazwą 'my servo'. Jest to w (bardzo dużym)
                  // uproszczeniu zmienna, do której przypisane są funkcje,
                  // do których można się odwołać po kropce.

int servoPin = 4; //Numer pinu, przez który arduino będzie komunikowało się
                  // z serwomechanizmem.

int potPin = A7;  //Pin, do którego podłączony jest potencjometr.
int potVal;       //Zmienna, w której będzie przechowywana wartość 
                  // podczytana z potencjometru.

int degVal;       //Serwomechanizm przyjmuje wartości w stopniach.
                  // degVal będzie przechowywało wartość obrotu po 
                  // przeliczeniu z wartości odczytanej z potencjometru.

void setup() {
  myservo.attach(servoPin);  //Poinformowanie arduino, do którego pinu 
                             // podłączone jest serwo.
}

void loop() {
  potVal = analogRead(potPin);  //Odczytanie wartości z potencjometru (między 0 a 1023)
  
  // Funkcja map () przeskalowywuje (liniowo) podaną wartość z pewnego zakresu 
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
  
  myservo.write(degVal);        //Ustawia serwo na kąt.
  delay(15);                           
}
