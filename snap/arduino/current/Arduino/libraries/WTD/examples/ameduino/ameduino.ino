void setup() {
  ADMUX =  B01100111;           // set internal aref and port A7
  ADCSRA = B10101100;           // ADC enable, interrupt enable, 16 prescaler
  ADCSRB = B00000000;           // free running mode
  sei();            // enable interrupts
  ADCSRA |=B01000000;           // start first conversion
  Serial.begin(1000000);
}

void loop() {
    delay(10);
}

ISR(ADC_vect) {
    Serial.write(ADCH);
}
