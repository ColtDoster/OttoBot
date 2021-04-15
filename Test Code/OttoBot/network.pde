import processing.net.*;

Server s;
Client c;
String input;
int data[];

long serverTimer = 0;
long serverInterval = 500;

void initServer(){
  s = new Server(this, 8080); // Start a simple server on a port
}

void getServer(){
  if(millis() - serverTimer > serverInterval){
    c = s.available();
    if (c != null) {
      input = c.readString();
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      data = int(split(input, ' ')); // Split values into an array
      
      // Get Data
      // data[0], etc.
      println(data[0] + " " + data[1] + " " + data[2] + " " + data[3]);
      int speed = data[0];
      int angle = data[1];
      setSpeed(speed);
      setDir(angle);
    }
    serverTimer = millis();
  }
}
