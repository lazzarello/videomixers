/*

 The a s  d f keys turn on and off the image sequence playbacks
 
 Z csteps through differnt blending modes
 
 playback will be rought the first time around. 
 
 grapincs memory needs to be set at 256
 
 */

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

//PImage[] data = new PImage[12];
PImage[] img_seq1 = new PImage[60];

int [] midipot=new int[8];
int [] midipoti=new int[8];
int [] frames=new int[8];
boolean [] enable=new boolean[8];

int frame1;
int tick;

float fn;
boolean enable1=true;
boolean enable2=true;
int frame2;
int temp1;
int blend_type;

void setup() {
  print("loading images ");
  for ( int i = 0; i < img_seq1.length; i++ ) {
    temp1=i+10;
    img_seq1[i] = loadImage("gib_1" + temp1 + ".png" );
    print(i + " ");
  }

  MidiBus.list();
  noCursor();
  myBus = new MidiBus(this, 0, 0);

  frameRate(30);
  size(720, 480, P3D); //p3d is way slower
  colorMode(RGB, 255);

  enable[0]=enable[1]=enable[2]=enable[3]=true;
  frames[1]=0;
  frames[2]=10;
  frames[3]=20;
  frames[4]=30;
}

void draw() {

  frames[1]++;
  frames[1] %= img_seq1.length-1;

  frames[2]++;
  frames[2] %= img_seq1.length-1;

  frames[3]++;
  frames[3] %= img_seq1.length-1;

  frames[4]++;
  frames[4] %= img_seq1.length-1;

  if (blend_type==0) {

    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint(255, 100);
    rect(0, 0, width, height);

    blendMode(ADD);
  }
  if (blend_type==1) {

    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint(255, 20);
    rect(0, 0, width, height);

    blendMode(ADD);
  }

  if (blend_type==2) {

    blendMode(ADD);

    fill(0);
    stroke(0);
    tint(255, 200);
    rect(0, 0, width, height);
  }

  if (blend_type==3) {

    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint(255, 50);
    rect(0, 0, width, height);

    blendMode(EXCLUSION);
  }

  tint(255, 200);  
  if (enable[1]) {
    //background(0);
    //translate(width/2, height/2);
    //stroke(255);
    //fill(127);
    //beginShape();
    //texture(img_seq1[frames[1]]);
    //vertex(-100, -100, 0, 0,0);
    //vertex( 100, -100, 0,720,0);
    //vertex( 100,  100, 0,720,480);
    //vertex(-100,  100, 0,480);
    //endShape();
    image(img_seq1[frames[1]], 0, 0, 720, 480);
  }
  tint(255, 200);
  if (enable[2]) {
    image(img_seq1[frames[2]], 0, 0, 720, 480);
  }
  tint(60, 255, 255, 200);
  if (enable[3]) {
    image(img_seq1[frames[3]], 0, 0, 720, 480);
  }
  tint(255, 120, 120, 200);
  if (enable[4]) {
    image(img_seq1[frames[4]], 0, 0, 720, 480);
  }
  //fill(0,0,0,midipot[2]);
}



void keyPressed() {
  if (key=='a'|| key=='A') {
    enable[1]=!enable[1];
    // println(dataen);
    frames[1]=0;
  }
  if (key=='s'||key=='S') {
    enable[2]=!enable[2];
    //  println(img_seq1en);
    frames[2]=0;
  }
  if (key=='d'||key=='D') {
    enable[3]=!enable[3];
    //  println(img_seq1en);
    frames[3]=0;
  }
  if (key=='f'||key=='F') {
    enable[4]=!enable[4];
    //  println(img_seq1en);
    frames[4]=0;
  }
  if (key=='z'||key=='Z') {
    blend_type++;

    if (blend_type>3) {
      blend_type=0;
    }
    println(blend_type);
  }
}


void controllerChange(ControlChange change) {
  if (change.number()==41) {
    midipot[0]=change.value()*2;
    // println(midipot[0]);
  }

  if (change.number()==42) {
    midipot[1]=change.value()*2;
    // println(midipot[1]);
  }

  if (change.number()==43) {
    midipot[2]=change.value()*2;
    //println(midipot[2]);
  }

  if (change.number()==21) {
    midipot[3]=change.value()/6;
  }


  if (change.number()==22) {
    midipot[4]=change.value()*2;
  }



  if (change.number()==23) {
    midipot[5]=change.value()/10;
  }
}


void noteOn(Note note) {
  // Receive a noteOn
  if (note.pitch==10) {
    enable1=!enable1;
    // println(dataen);
    frame1=0;
  }
  if (note.pitch==9) {
    enable2=!enable2;
    //  println(img_seq1en);
    frame2=0;
  }
}