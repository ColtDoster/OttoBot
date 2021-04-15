// Set GPIO Pins for Motor Controller
int IN1 = 18;  int IN2 = 17;
int IN3 = 27;  int IN4 = 22;

// Initialize Motors
void initMotors() {
  controller.attach(motorR, motorLowPulse, motorHighPulse);
  controller.attach(motorL, motorLowPulse, motorHighPulse);
  
  GPIO.pinMode(IN1, GPIO.OUTPUT);
  GPIO.pinMode(IN2, GPIO.OUTPUT);
  GPIO.pinMode(IN3, GPIO.OUTPUT);
  GPIO.pinMode(IN4, GPIO.OUTPUT);
}

// Set Motor Speed
void setSpeed(int thisSpeed){
  // Stop Motors
  if(thisSpeed == 0){
    GPIO.digitalWrite(IN1, GPIO.LOW);  GPIO.digitalWrite(IN2, GPIO.LOW);
    GPIO.digitalWrite(IN3, GPIO.LOW);  GPIO.digitalWrite(IN4, GPIO.LOW);
  }
  else{
    // Reverse Motors
    if(thisSpeed < 0){
      GPIO.digitalWrite(IN1, GPIO.HIGH);  GPIO.digitalWrite(IN2, GPIO.LOW);
      GPIO.digitalWrite(IN3, GPIO.LOW);  GPIO.digitalWrite(IN4, GPIO.HIGH);
    }
    // Forward Motors
    if(thisSpeed > 0){
      GPIO.digitalWrite(IN1, GPIO.LOW);  GPIO.digitalWrite(IN2, GPIO.HIGH);
      GPIO.digitalWrite(IN3, GPIO.HIGH);  GPIO.digitalWrite(IN4, GPIO.LOW);
    }
    //Set Final Speed
    float finalSpeed = map(abs(thisSpeed), 0, 100, 0, 180);
    controller.write(motorL, finalSpeed); 
    controller.write(motorR, finalSpeed); 
  }
  
  mode = 0;  // Return to Neutral State
}
