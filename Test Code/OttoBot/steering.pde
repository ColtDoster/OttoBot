void initSteering(){
  controller.attach(steering, 544, 2400);
  setDir(0);
}

void setDir(int angle){
  float finalDir = map(angle, -100, 100, servoMinAngle, servoMaxAngle);
  controller.write(steering, finalDir); 
}
