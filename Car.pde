#define S1trigPin 12 
#define S1echoPin 13
#define S2trigPin 8
#define S2echoPin 7
#define motoPinI 6
#define motoPinG 5
#define wayPinL 4
#define wayPinR 3
 
 
void setup() 
{
  Serial.begin(9600);
  pinMode(S1trigPin, OUTPUT);
  pinMode(S1echoPin, INPUT);
  pinMode(S2trigPin, OUTPUT);
  pinMode(S2echoPin, INPUT);
  pinMode(motoPinI, OUTPUT);
  pinMode(motoPinG, OUTPUT);
  pinMode(wayPinL, OUTPUT);
  pinMode(wayPinR, OUTPUT);
  
}
 
void loop()
{
  // s=süre u=uzaklık
  int S1s, S1u, S2s, S2u;
  
  // S1: 1.Sensör, Sol Taraf
  digitalWrite(S1trigPin, HIGH);
  delayMicroseconds(1000);
  digitalWrite(S1trigPin, LOW);
  
  S1s = pulseIn(S1echoPin, HIGH);
  S1u = (S1s/2)/29.1; // S1uzaklik = (sure/2)/29.1;
 
  // S2: 2.Sensör, Sağ Taraf
  digitalWrite(S2trigPin, HIGH);
  delayMicroseconds(1000);
  digitalWrite(S2trigPin, LOW);
  
  S2s = pulseIn(S2echoPin, HIGH);
  S2u = (S2s/2)/29.1; // uzaklik = (sure/2)/29.1;
 
  String x = " : ";
  Serial.println(S1u+x+S2u);
  
  if ((S1u >= 20) and (S2u >= 20))
  {
        Serial.println("ileri");
	digitalWrite(motoPinI, HIGH);
        digitalWrite(motoPinG, LOW);
	digitalWrite(wayPinR, LOW);
        digitalWrite(wayPinL, LOW);
  }
  else if ((S1u < 20) and (S1u > 10))
  {
        Serial.println("Sağ");
        digitalWrite(motoPinI, HIGH);
	digitalWrite(wayPinR, HIGH);
        digitalWrite(wayPinL, LOW);
        digitalWrite(motoPinG, LOW);
  }
  
  else if ((S2u < 20) and (S2u > 10))
  {
        Serial.println("SOL");
        digitalWrite(motoPinI, HIGH);
        digitalWrite(wayPinL, HIGH);
        digitalWrite(motoPinG, LOW);
        digitalWrite(wayPinR, LOW);
  }
  
  else if ((S1u <= 10) and (S2u <=10))
  {
        Serial.println("geri");
	digitalWrite(motoPinG, HIGH);
	digitalWrite(motoPinI, LOW); 
	digitalWrite(wayPinR, LOW);
        digitalWrite(wayPinL, LOW);
  }
  delay(1000);
}
 
//kırmızı motor geri
//yeşil motor ileri
 
//sarı motor sol
//turuncu motor sağ
