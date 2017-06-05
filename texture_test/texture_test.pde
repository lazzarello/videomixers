PImage[] seq1 = new PImage[60];
int [] frames=new int[8];
boolean [] enable=new boolean[8];

int frame1;
int frame2;
int tick;
float funct;
boolean enable1=true;
boolean enable2=true;
int padding;
int blend_type;

float x,y,z;

void setup() {
  print("loading images ");
  for ( int i =0; i < seq1.length; i++ ) {
    padding = i+10; // this is a hack in place of a left padding function
    seq1[i] = loadImage("gib_1" + padding + ".png");
    print(i + " ");
  }
  
  frameRate(30);
  size(1280, 720, P3D);
  colorMode(RGB, 255);
  
  enable[0]=enable[1]=enable[2]=enable[3]=true; // this is a default to enable all channels
  
  for ( int i = 0; i < 4; i++ ) {
    frames[i+1]=i*10;
  }
  //frames[1]=0;
  //frames[2]=10;
  //frames[3]=20;
  //frames[4]=30;
  
  background(100);
  rectMode(CENTER); // this sets 3D coordinates to originate from the center of the window
  fill(51, 127, 50);
  stroke(255);
  x = width/2;
  y = height/2;
  z = 0;
}

void draw() {
  translate(x,y,z);
  //rotateZ(PI/8);
  //rect(0,0,y,y);
  beginShape();
  texture(img);
  // color the texture
  tint(0,127,255);
  vertex(-x,-y,0,0,0);
  vertex(x,-y,0,x*2,0);
  vertex(x,y,0,x*2,y*2);  
  vertex(-x,y,0,0,y*2);
  endShape(CLOSE);
  //z++;
}