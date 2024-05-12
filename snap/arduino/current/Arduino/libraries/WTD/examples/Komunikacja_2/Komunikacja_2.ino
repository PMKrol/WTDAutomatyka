//EN: The place where the received character will be remembered.
//PL: Miejsce gdzie zapamiętywany będzie odebrany znak.
int znak = 0;

//EN: Pin number where diode is connected
//PL: Numer pinu do którego podłączona jest dioda.
int dioda1 = 8;

void setup() {
  //EN: Starting the serial port
  //    at a speed of 9600 bits per second.
  //PL: Uruchomienie portu szeregowego
  //    z prędkością 9600 bitów na sekundę.
  Serial.begin(9600);

  pinMode(dioda1, OUTPUT);
}

void loop() {
  //EN: If a new character is received...
  //PL: Jeżeli otrzymany nowy znak...
  if (Serial.available() > 0) {
    
    //EN: Remember what character was read
    //    but only one - the rest are 'waiting'.
    //PL: Zapamiętaj jaki znak został odczytany
    //    ale tylko jeden - pozostałe 'czekają'.
    znak = Serial.read();

    //EN: Attention!
    //    Single characters MUST be between single quotes:
    //    "1" will be understood as something other than '1'.
    //PL: Uwaga!
    //    Pojedyncze znaki MUSZĄ być pomiędzy apostrofami:
    //    "1" będzie rozumiane jako co innego niż '1'.
    if(znak == '1'){
      digitalWrite(dioda1, HIGH);
      //EN: Message: Turning on diode 1.
      Serial.println("Zapalam diodę 1.");
    }
  }
}
