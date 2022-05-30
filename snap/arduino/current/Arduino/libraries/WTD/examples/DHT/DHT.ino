//Wczytanie biblioteki, która zajmuje się komunikacją z DHT.
#include <dhtnew.h>
int dhtPin = 2;

//Poinformowanie Arduino, przez który pin ma się komunikować.
DHTNEW dht(dhtPin);

//Zmienne zapamiętujące odczyty
float temp = 0;
float hum = 0;

void setup(){
  Serial.begin(9600);
}

void loop(){
  //Poinstruowanie DHT, aby dokonało pomiarów.
  dht.read();

  //Zapamiętanie odczytów
  temp = dht.getTemperature();
  hum = dht.getHumidity();
  
  Serial.print("Temp. = ");
  Serial.print(temp);
  Serial.print(" C | Wilg. = ");
  Serial.print(hum);
  Serial.println(" %");
  
  delay(1500);
}
