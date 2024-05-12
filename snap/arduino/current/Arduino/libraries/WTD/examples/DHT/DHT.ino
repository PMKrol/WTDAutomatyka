//EN: Loading the library that deals with communication with DHT.
//PL: Wczytanie biblioteki, która zajmuje się komunikacją z DHT.

#include <dhtnew.h>
int dhtPin = 2;

//EN: Telling the Arduino which pin to communicate through.
//PL: Poinformowanie Arduino, przez który pin ma się komunikować.
DHTNEW dht(dhtPin);

//EN: Variables storing readings
//PL: Zmienne zapamiętujące odczyty
float temp = 0;
float hum = 0;

void setup(){
  Serial.begin(9600);
}

void loop(){
  //EN: Instructing the DHT to take measurements.
  //PL: Poinstruowanie DHT, aby dokonało pomiarów.
  dht.read();

  //EN: Memorizing readings
  //PL: Zapamiętanie odczytów
  temp = dht.getTemperature();
  hum = dht.getHumidity();
  
  Serial.print("Temp. = ");
  Serial.print(temp);

  //EN: Message: "C | Hum. = "
  Serial.print(" C | Wilg. = ");
  Serial.print(hum);
  Serial.println(" %");
  
  delay(1500);
}
