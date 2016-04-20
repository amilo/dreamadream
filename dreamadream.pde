// Alessia Milo
// 20th April 20016
// Per Alice Nebula

//import Minim library into Processing

//import Minim library
  import ddf.minim.*;
  import ddf.minim.UGen;
  

  
//for displaying the sound's frequency
  import ddf.minim.analysis.*;
  import ddf.minim.ugens.*;


//import themidibus.*; //Import the library

//MidiBus myBus; // The MidiBus


  Minim minim;
  
 int count;
  int spacing;
  int string =440;

   int channel = 0;
  int pitch = 64;
  int velocity = 127;
   int number = 0;
  int value = 90;
  int []values;
  
  int startingPointX =0;
    int startingPointY =0;
    float alpha = 0.0;
      float alpha2 = 0.0;
//to make it play song files
  //AudioPlayer song;
   //to make it "hear" audio input
  AudioInput in;
  AudioOutput out;
  //AudioRecorder recorder;
  float sum=0.0;
  int counta;
  String x;
   String a;String b;String c;
//for displaying the sound's frequency
  FFT fft;

// to make an Instrument we must define a class
// that implements the Instrument interface.
class SineInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    
     
    ampEnv.activate( duration, 0.1f, 0 );  //attach velocity
    // start the amplitude envelope
    //ampEnv.activate( duration, 0.1f, 0 );  //attach velocity
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}
void setup() {

  //sketch size
    size(800, 800, P3D); //do the adjustable size

 background(255,0);
  //MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //
  //myBus = new MidiBus(this, 0, 0); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

 //frameRate(fps);
 textureMode(NORMAL);
 
  
  minim = new Minim(this);
 
  in = minim.getLineIn(Minim.STEREO, 2048);

      // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
 
   startingPointX =width/2 - 200;
    startingPointY = height/2 - 200;
    
    
    count=0;
  
    values= new int[16];
   counta=1;  
}
 
 
void draw(){
  
  counta++;
  
  
  
   
background(255,0);
noStroke();
  rectMode(CENTER);
  
fill(counta%255,counta%122, 255);
 alpha = radians(counta*10+90);
  rect(startingPointX+ cos( alpha)*100, startingPointY + sin( alpha)*100  , 10+counta%255 , 10+counta%122);
  println(counta);

  
  
  strokeWeight(3);
    stroke(0,0,0);
    line(startingPointX, startingPointY, startingPointX + cos(alpha)*100, startingPointY + sin( alpha)*100);

    
    
  noStroke();


    //fill(255,0,0, 255);
  
  for (int i =0; i<12; i++){
      for (int j =0; j<12; j++){
        
       // if (counta >40){
          fill(255,map(i,0,12, 0, 50),0, counta%400-50);
            strokeWeight(1);
    //stroke(140,0,0, counta%100+20);
    //ellipse(width/12*i+width/24+sin( alpha)*20, height/12*j+height/24+cos(alpha)*10, counta, counta);
  
   for (int z = 0;z <12; z++){
     
   alpha2 = alpha + map(z, 0, 12,0 , 2*PI);
   
    stroke(map(i,0,12, 180, 255),map(z,0,12, 150, 200),map(j,0,12, 100, 200), counta);
    
    line(width/12*i+width/24+sin( alpha)*20, 
    height/12*j+height/24+cos(alpha)*10, 
    width/12*i+width/24+sin( alpha)*20 + cos(alpha2)*100, 
     height/12*j+height/24+cos(alpha)*10 + sin( alpha2)*100);
   }
     // }
    
        noStroke();
        
    ellipseMode(CENTER);
    if (j%2==0){     
      if(i%2==0){  ellipse(width/12*i+width/24+sin( alpha)*20, height/12*j+height/24+cos(alpha)*10, counta/4, counta/4);
      }
      else if (i%2==1){ellipse(width/12*i+width/24+sin( alpha)*20, height/12*j+height/24-cos(alpha)*10, counta/4, counta/4);
      }
    }
     else if (j%2==1){
       if(i%2==0){
        ellipse(width/12*i+width/24-sin( alpha)*20, height/12*j+height/24-cos(alpha)*10, counta/4, counta/4);
       }
       else if(i%2==1){
        ellipse(width/12*i+width/24-sin( alpha)*20, height/12*j+height/24+cos(alpha)*10, counta/4, counta/4);
       }
     }  
    }
  }
  


     String x = str(counta);
        
     textSize(200);
//text(x, 10, 30);
fill(0, 102, 153, 100-counta%100);
text(x, width/2, height/2, 0);


   if (counta > 40){
  out.playNote( 0.5, 2.0, new SineInstrument( Frequency.ofPitch( "C3" ).asHz() ) );
  delay(800);
 
   out.playNote( 0.2, 0.5, new SineInstrument( Frequency.ofPitch( "C5" ).asHz() ) );
  delay(200);

  
  if (counta > 20){
  out.playNote( 0.5, 2.0, new SineInstrument( Frequency.ofPitch( "C3" ).asHz() ) );
  delay(800);
   out.playNote( 0.6, 1.5, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );
  delay(2000);

  
  }
 
    out.playNote( 3.0, 3.0, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );
     delay(250);
   }
     
   out.playNote( 0.6, 1.5, new SineInstrument( Frequency.ofPitch( "G4" ).asHz() ) );
  delay(1600);


  
  if (counta % 12 == 0)
  {
    
    // background(255,50);
       String a = str(counta);
  rectMode(CENTER);
  textSize(100);
//text(x, 10, 30);
text(a, width/2-200, height/2+200, -30);
fill(240, 0, 153);
    out.playNote( 1.2, 2.0, new SineInstrument( Frequency.ofPitch( "C4" ).asHz() ) );
     delay(100);
 
  out.playNote( 3.0, 6.0, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );
     delay(250);
     
        out.playNote( 1.8, 3.0, new SineInstrument( Frequency.ofPitch( "A4" ).asHz() ) );
     delay(100);
  }
     
     out.playNote( 3.6, 5.0, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );
     delay(200);
     
     
      if (counta > 20 )
  {
    
    if (counta % 12 == 0 ){
       //background(255,10);
    out.playNote( 1.5, 1.0, new SineInstrument( Frequency.ofPitch( "C5" ).asHz() ) );
     delay(100);
 
      String b = str(counta);
  rectMode(CENTER);
  textSize(100);
//text(x, 10, 30);
text(b, width/2-400, height/2+400, -30);
fill(240, 0, 153);
        out.playNote( 1.2, 3.0, new SineInstrument( Frequency.ofPitch( "C4" ).asHz() ) );
     delay(100);}
     
  }
 
   
       if (counta > 8 )
  {
    
   
    if (counta % 10 == 0 ){
      
      fill(255,10);
      
       String c = str(counta);
 ellipse (width/2-400, height/2-100, counta, counta);
 
  fill(240, 50, 153);
  textSize(50);
//text(x, 10, 30);
text(c, width/2-400, height/2-100, -30);

        
        out.playNote( 2.8, 1.0, new SineInstrument( Frequency.ofPitch( "A5" ).asHz() ) );
     delay(200);}
      if (counta % 15 == 0 ){
    out.playNote( 1.8, 3.0, new SineInstrument( Frequency.ofPitch( "G6" ).asHz() ) );
     delay(100);
      }

    
     
  }
 
    if (counta>1000){
  
    minim.stop();
  }
 
  
  if (sum>10000000){
    sum = -sum;
    println("reverse sum");
  }
     
 
}
 
void stop()
{
  //close the AudioPlayer you got from Minim.loadFile()
    in.close();
  
  if (counta>1000){
  
    minim.stop();
  }
    //mm.finish();
 
  //this calls the stop method that 
  //you are overriding by defining your own
  //it must be called so that your application 
  //can do all the cleanup it would normally do
    super.stop();
}




void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void keyReleased()
{
 
  
  
}

void keyPressed() {

   if (keyPressed) {
     if (key == 'a' || key == 'A') {
       string=500;
      out.playNote( 0.1, 0.5, new SineInstrument( Frequency.ofPitch( "A3" ).asHz() ) );
      //out.playNote( 0.2, 0.5, new SineInstrument( Frequency.ofPitch( "E4" ).asHz() ) );
      //out.playNote( 0.4, 0.5, new SineInstrument( Frequency.ofPitch( "A4" ).asHz() ) );
      text("A",210,30); 
    }else if (key == 'b' || key == 'B') {
      string=600;
      out.playNote( 0.1, 0.5, new SineInstrument( Frequency.ofPitch( "B3" ).asHz() ) );
    text("B",220,30);
    }else if (key == 'c' || key == 'C') {
      string=700;
      out.playNote( 0.1, 0.5, new SineInstrument( Frequency.ofPitch( "C4" ).asHz() ) );
      text("C",230,30); 
    }
    else if (key == 'd' || key == 'D') {
      string=800;
      out.playNote( 0.1, 0.5, new SineInstrument( Frequency.ofPitch( "D4" ).asHz() ) );
      text("D",240,30);
    }
    else if  (key == 'e' || key == 'E'){
      string=800;
      out.playNote( 0, 0.5, new SineInstrument( Frequency.ofPitch( "E4" ).asHz() ) );
      text("E",250,30);
}
   else if  (key == 'f' || key == 'F'){
     string=800;
      out.playNote( 0, 0.5, new SineInstrument( Frequency.ofPitch( "F4" ).asHz() ) );
      text("E",260,30);
}
  else if  (key == 'g' || key == 'G'){
    string=800;
      out.playNote( 0, 0.5, new SineInstrument( Frequency.ofPitch( "G4" ).asHz() ) );
      text("E",270,30);
}
  
  }
}

