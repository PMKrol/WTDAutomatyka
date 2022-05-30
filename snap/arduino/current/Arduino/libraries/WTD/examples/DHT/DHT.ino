#include <TroykaDHT.h>

int dhtPin = 2;

//Poinformowanie Arduino, przez który pin i z którym DHT ma się komunikować.
// Uwaga, 
// w przypadku DHT11 (niebieski) należy xx zastąpić 11.
// w przypadku DHT22 (biały) xx należy zastąpić 22.
DHT dht(dhtPin, DHTxx);

void setup()
{
  Serial.begin(9600);
  //Uruchomienie komunikacji z DHT
  dht.begin();
}

void loop()
{
  //Poinstruowanie DHT, aby dokonało pomiarów.
  dht.read();

  //Funkcja getState zwraca wartość 0, jeśli udało się dokonać odczytu.
  // inne wartości należy rozumieć jako błąd.
  if(dht.getState() == 0) {
    Serial.print("Temp. = ");
    Serial.print(dht.getTemperatureC());
    Serial.print(" C | Wilg. = ");
    Serial.print(dht.getHumidity());
    Serial.println(" %");
  }else{
    Serial.println("==============");
    Serial.println("Blad odczytu!");
    Serial.println("Sprawdz polaczenie.");
    Serial.println("==============");
  }
  
  delay(2000);
}
