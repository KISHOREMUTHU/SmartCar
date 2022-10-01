int leftA = 9; 
int leftB = 10; 
int rightA = 11; 
int rightB = 12; 
int vel = 255; // Speed of motor (0-255)
int initialState = 0; // initialState

void setup() { 
Serial.begin(9600); // initiates the serial port for communication with Bluetooth
pinMode(rightA, OUTPUT);
pinMode(rightB, OUTPUT);
pinMode(leftA, OUTPUT);
pinMode(leftB, OUTPUT);
} 

void loop() { 

if(Serial.available()>0){ // read bluetooth and store in state
initialState = Serial.read();
}
if(initialState=='1'){ // Forward
  Serial.println(initialState);
analogWrite(rightB, 0); 
analogWrite(leftB, 0); 
analogWrite(rightA, vel); 
analogWrite(leftA, vel); 
}
if(initialState=='2'){ // right
    Serial.println(initialState);
analogWrite(rightB, 0); 
analogWrite(leftB, 0); 
analogWrite(rightA, 200);
analogWrite(leftA, 200); 
}
if(initialState=='3'){ // Stop
    Serial.println(initialState);
analogWrite(rightB, 0); 
analogWrite(leftB, 0); 
analogWrite(rightA, 0); 
analogWrite(leftA, 0); 
}
if(initialState=='4'){ // left
    Serial.println(initialState);
analogWrite(rightB, 0); 
analogWrite(leftB, 0);
analogWrite(leftA, 200);
analogWrite(rightA, 200); 
} 

if(initialState=='5'){ // Reverse
    Serial.println(initialState);

analogWrite(rightA, -vel);
analogWrite(leftA, -vel);
}
if(initialState=='6'){ // left
    Serial.println(initialState);
analogWrite(rightB, 0); 
analogWrite(leftB, vel);
analogWrite(leftA, 0);
analogWrite(rightA, vel); 
} 

}
