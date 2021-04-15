import processing.io.*;
PCA9685 controller;

int wait = 5;

// PWM Pin Assignments
int steering = 0;  // Steering Servo
int motorR = 1;    // Right Motor
int motorL = 2;    // Left Motor

// Motor Pulses to Control Speed
int motorHighPulse = 10000;
int motorLowPulse = 2000;

// Servo Steering Limits
int servoMinAngle = 10;
int servoMaxAngle = 170;

// Speed/Dir Variables
int whichSpeed = 0;  // -100 - 100% (Reverse -- Stop -- Forward)
int whichDir = 0;    // -100 - 100% (Left to Right)

// Current Control Mode
int mode = 0;

void setup() {
  size(400, 300);
  controller = new PCA9685("i2c-1", 0x40);  // Connect to I2C Controller
  initSteering();                           // Intitialize Steering
  initMotors();                             // Intitialize Motors
  initServer();                             // Intitialize Server
}

void draw() {
  getServer();  // Get Incoming Values from Server
  switch(mode){
    case 0: break;                        // Neutral State (Do Nothing)
    case 1: setSpeed(whichDir); break;    // Set Motor Speed
    case 2: setDir(whichDir); break;      // Set Steering Direction
  }
}

// Listen to Keypresses
void keyPressed(){
  switch(key){
    case '1': setSpeed(-100); break;
    case '2': setSpeed(-50); break;
    case '3': setSpeed(0); break;
    case '4': setSpeed(50); break;
    case '5': setSpeed(100); break;
    
    case '7': setDir(-100); break;
    case '8': setDir(0); break;
    case '9': setDir(100); break;
    
    case 'q': shutDown(); break; 
  }
}

// Shut Down
void shutDown(){
  println("Shutting Down"); 
  controller.detach(steering);
  controller.detach(motorR);
  controller.detach(motorL);
  exit();
}
