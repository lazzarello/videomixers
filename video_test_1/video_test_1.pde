/*

 the a and s keys turn on and off the two image sequence playbacks
 
 Z csteps through differnt blending modes
 
 playback will be rough for a few loops 
 
 grapincs memory needs to be set at 256
 
 */


import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

float [] midipot=new float[8];
int [] midipoti=new int[8];
int [] ven=new int[8];
int [] vt=new int[8];
int blend_type;


import gohai.glvideo.*;
GLMovie video1;
GLMovie video2;

void setup() {
  delay(200);
  MidiBus.list();
  noCursor();

  myBus = new MidiBus(this, 0, 0);
  delay(200);

  size(640, 480, P2D);
  video2 = new GLMovie(this, "gib.mp4");
  video1 = new GLMovie(this, "gib.mp4");

  delay(200);
  println("!");
  video1.speed(1.25);

  video2.speed(.75);
  background(0);

  ven[0]=1;
  ven[1]=1;
}

void draw() {
  if (blend_type==3) {

    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint (255, 50);

    rect(0, 0, width, height);
    blendMode(EXCLUSION);
  }

  if (blend_type==0) {

    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint (255, 255);

    rect(0, 0, width, height);
  }

  if (blend_type==1) {
    
    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint (255, 255);

    rect(0, 0, width, height);
    blendMode(EXCLUSION);
  }

  if (blend_type==2) {
    
    blendMode(BLEND);

    fill(0);
    stroke(0);
    tint (255, 255);

    rect(0, 0, width, height);
    blendMode(ADD);
  }

  if (video1.available() ) {
    if (ven[1]==1) {
      video1.play();
      video1.read();
      //video1.speed(midipot[1]);
    }
    if (ven[1]==0 && vt[1]==1) {
      video1.pause();
      video1.jump(200);
      vt[1]=0;
      // println("vt1 " + vt[1]);
    }
  }
  if (ven[1]==1) {
    tint (255, 200);
    image(video1, 0, 0, width, height);
  }

  if (video2.available() ) {
    if (ven[2]==1) {
      video2.play();
      video2.read();
      // video2.speed(midipot[1]);
    }

    if (ven[2]==0 && vt[2]==1) {
      video2.pause();
      video2.jump(40);
      vt[2]=0;
      // println("vt2 " + vt[2]);
    }
  }




  if (ven[2]==1) {
    tint (255, 200);

    image(video2, 0, 0, width, height);
  }
}

void keyPressed() {
  if (key=='a'|| key=='A') {
    ven[1]++;
    if (ven[1]>1) {
      ven[1]=0;
      vt[1]=1;
    }
  }
  if (key=='s'||key=='S') {
    ven[2]++;

    if (ven[2]>1) {
      ven[2]=0;
      vt[2]=1;
    };
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
    midipot[1]=change.value()/50.00;
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
  if (note.pitch==9) {
    ven[1]++;
    if (ven[1]>1) {
      ven[1]=0;
      vt[1]=1;
    };
    //  println("e1 " + ven[1]);
  }
  if (note.pitch==10) {
    ven[2]++;

    if (ven[2]>1) {
      ven[2]=0;
      vt[2]=1;
    };
    // println("e2 " + ven[2]);
  }
}