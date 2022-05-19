int znak = 0;   //Miejsce gdzie zapamiętywany będzie 
                // odebrany znak.        
int dioda1 = 8;

void setup() {
  Serial.begin(9600); //Uruchomienie portu szeregowego 
                      // z prędkością 9600 bitów na sekundę.

  pinMode(dioda1, OUTPUT);
}

void loop() {
  //Jeżeli otrzymany nowy znak...
  if (Serial.available() > 0) {
    
    //Zapamiętaj jaki znak został odczytany 
    // ale tylko jeden - pozostałe 'czekają'.
    znak = Serial.read();

    //Uwaga!
    // Pojedyncze znaki MUSZĄ być pomiędzy apostrofami:
    // "1" będzie rozumiane jako co innego niż '1'.
    
    if(znak == '1'){
      digitalWrite(dioda1, HIGH);
      Serial.println("Zapalam diodę 1.");
    }
  }
}
