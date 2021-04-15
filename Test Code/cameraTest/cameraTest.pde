// Camera Test
// Zane Cochran

import gohai.glvideo.*;
import processing.net.*;

GLCapture video;
Server s;

PImage downSample;
int downSampleW = 80;
int downSampleH = 64;

long frameTimer = 0;
long frameInterval = 200;

byte vidStream[];

void setup() {
  s = new Server(this, 8080);
  size(320, 120, P2D);

  String[] devices = GLCapture.list();
  printArray(devices);
  video = new GLCapture(this, devices[2], 160, 120);
  video.start();
  
  downSample = createImage(downSampleW, downSampleH, RGB);
  vidStream = new byte[(downSampleW * downSampleH) / 8];
}

void draw() {
  background(0);
  if (video.available()){
    video.read(); 
    downSample.copy(video, 0, 0, video.width, video.height, 0, 0, downSample.width, downSample.height);   
    colorConvert(128);
  }
  sendVideo();
  image(video, 0, 0, video.width, video.height);
  image(downSample, video.width, 0, video.width, video.height);
}

void colorConvert(int thresh){
  downSample.loadPixels();
 
  for (int i = 0; i < downSample.width * downSample.height; i++){
    color rawColor = downSample.pixels[i];
    float bright = brightness(rawColor);
    if(thresh < 0){downSample.pixels[i] = color(bright);}
    else{
      if(bright < thresh){downSample.pixels[i] = color(0);}
      else{downSample.pixels[i] = color(255);}
    }
  }
  downSample.updatePixels();
}

void sendVideo(){
  byte buffer = 0;
  int place = 0;
  int counter = 0;
  
  if(millis() - frameTimer > frameInterval){    
    downSample.loadPixels();
    for (int i = 0; i < downSample.pixels.length; i++){
      int thisBit = (int)brightness(downSample.pixels[i]);
      if(thisBit != 0){thisBit = 1;}
      buffer = byte(buffer << 1);
      buffer += thisBit;
      place = (place + 1) % 8;
      if(place == 0){
        vidStream[counter] = buffer;
        counter++;
        buffer = 0;
      }
    }
    s.write(vidStream);
  }
}
