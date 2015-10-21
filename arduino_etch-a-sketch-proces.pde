const int analogIn = A0;
const int analogIn2 = A1;


int sensorValue = 0;
int sensorValue2 = 0;

void setup() {

  Serial.begin(9600);

}

void loop() {
  sensorValue = analogRead(analogIn);

  sensorValue2 = analogRead(analogIn2);


  // print the results to the serial monitor:
  Serial.print(sensorValue);

  Serial.print("," );
  Serial.println(sensorValue2);


  // wait 2 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(100);
}










import processing.serial.*;

Serial port;
int oldX = -1;
int oldY = -1;

void setup() {
 size(512, 512);
 background(255);
 port = new Serial(this, Serial.list()[Serial.list().length-1], 9600);  
}

void drawNextLine(int x, int y) {
 if (oldX >= 0 && oldY >= 0) {
   // draw a line from the old x,y coordinates to the new x,y coordinates
   line(x, y, oldX, oldY);
 }

 // update the "old" x,y coordinates for the next frame
 oldX = x;
 oldY = y;
}  

void draw() {
 int[] values = readSerial(2);
 if (values != null) {
   drawNextLine(values[0], values[1]);
 }
}

void mouseClicked() {
 background(255);
}

int[] readSerial(int minValues) {  
 String s = port.readStringUntil('\n');
 if (s != null) {
   String[] parts = s.substring(0, s.length()-2).split(",");
   int[] values = new int[parts.length];
   for (int i = 0; i < parts.length; i++) {
     values[i] = int(parts[i]);
   }
   if (values.length < minValues) {
     return null;
   } else {
     return values;
   } 
 } else {
   return null;
 }
}
