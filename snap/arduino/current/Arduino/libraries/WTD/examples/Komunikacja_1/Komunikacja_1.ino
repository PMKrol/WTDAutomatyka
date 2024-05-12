int przyciskA = 5;

void setup() {
    Serial.begin(9600);
    pinMode(przyciskA, INPUT);
}

void loop() {
    
    if(digitalRead(przyciskA)){
        //EN: Button A is pressed.
        Serial.println("Przycisk A jest wcisniety.");
    }else{
        //EN: Button A is not pressed.
        Serial.println("Przycisk A nie jest wcisniety.");
    }

    delay(100);
} 
