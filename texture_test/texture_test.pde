PImage[] seq1 = new PImage[60];
int [] frames=new int[8];
boolean [] enable=new boolean[8];

int frame1;
int frame2;
int tick;
float funct;
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
  size(720, 480, P3D);
  colorMode(RGB, 255);
  
  enable[0]=enable[1]=enable[2]=enable[3]=true; // this is a default to enable all channels
  enable[4]=false;
  
  // these are frame offsets for the modulo looping in the draw() function
  for ( int i = 0; i < 4; i++ ) {
    frames[i+1]=i*10;
  }
  
  background(100);
  fill(51, 127, 50);
  stroke(255);
  x = width/2;
  y = height/2;
  z = 0;
}

void draw() {
  
  for ( int i = 1; i < 5; i++ ) {
    frames[i]++;
    frames[i] %= seq1.length-1;
  }
  
  blendMode(BLEND);
  fill(0);
  stroke(0);
  tint(255,100);
  rect(0,0,width,height);
  blendMode(ADD);
  
  // logic to draw layers based on user input
  // why does this shape originate at the corner?
  if (enable[1]) {
    tint(255,200);
    // this translates to originate the shape at 640x360 but it appears to originate at 0,0
    translate(width/2,height/2);
    beginShape();
    texture(seq1[frames[1]]);
    textureMode(NORMAL);
    vertex(-x,-y,0,0,0);
    vertex(x,-y,0,1,0);
    vertex(x,y,0,1,1);  
    vertex(-x,y,0,0,1);
    endShape(CLOSE);
  }
  if (enable[2]) {
    tint(255,200);
    // this translates the original shape to 0,0. WTF?
    translate(0,0);
    beginShape();
    texture(seq1[frames[2]]);
    textureMode(NORMAL);
    vertex(-x,-y,0,0,0);
    vertex(x,-y,0,1,0);
    vertex(x,y,0,1,1);  
    vertex(-x,y,0,0,1);
    endShape(CLOSE);
  }
  if (enable[3]) {
    tint(60, 255, 255, 200);
    // this translates the original shape to 0,0. WTF?
    translate(0,0);
    beginShape();
    texture(seq1[frames[3]]);
    textureMode(NORMAL);
    vertex(-x,-y,0,0,0);
    vertex(x,-y,0,1,0);
    vertex(x,y,0,1,1);  
    vertex(-x,y,0,0,1);
    endShape(CLOSE);
  }
  if (enable[4]) {
    tint(255, 120, 120, 200);
    // this translates the original shape to 0,0. WTF?
    translate(width/2,height/2);
    beginShape();
    texture(seq1[frames[4]]);
    textureMode(NORMAL);
    vertex(-x,-y,0,0,0);
    vertex(x,-y,0,1,0);
    vertex(x,y,0,1,1);  
    vertex(-x,y,0,0,1);
    endShape(CLOSE);
  }
}