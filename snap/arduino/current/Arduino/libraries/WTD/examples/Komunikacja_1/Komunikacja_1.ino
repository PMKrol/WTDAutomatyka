int przyciskA = 5;

void setup() {
    Serial.begin(9600);
    pinMode(przyciskA, INPUT);
}

void loop() {
    
    if(digitalRead(przyciskA)){
        Serial.println("Przycisk A jest wcisniety.");
    }else{
        Serial.println("Przycisk A nie jest wcisniety.");
    }

    delay(100);
} 
