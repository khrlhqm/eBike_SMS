#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

SoftwareSerial sim800(9, 10); // RX, TX
const char* ssid = "iPhone11";
const char* password = "Harry12345678";
 
String latitude = "2.55";
String longitude = "6.55";

void setup() {
  Serial.begin(115200);
  sim800.begin(9600);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  while (WiFi.status() == WL_CONNECTED) {
    delay(8000);
    Serial.println("Connected");
    Serial.println("Latitude: " + latitude);
    Serial.println("Longitude: " + longitude);
  }
  //Serial.println("Connected!");
  


  sendATCommand("AT");  // Check module
  sendATCommand("AT+CGNSPWR=1");  // Enable GPS
}

void loop() {
  sendATCommand("AT+CGNSINF");
  delay(5000);  // Check every 5 seconds
}

void sendATCommand(String command) {
  sim800.println(command);
  delay(1000);
  while (sim800.available()) {
    String response = sim800.readString();
    Serial.println(response);
    if (response.indexOf("+CGNSINF:") > -1) {
      extractGPSData(response);
      sendToServer();
    }
  }
}

void extractGPSData(String data) {
  int comma1 = data.indexOf(",") + 1;
  int comma2 = data.indexOf(",", comma1);
  latitude = data.substring(comma1, comma2);

  int comma3 = data.indexOf(",", comma2 + 1);
  longitude = data.substring(comma2 + 1, comma3);
}

void sendToServer() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    WiFiClient client;

    String serverUrl = "http://192.168.0.243/location?lat=" + latitude + "&lng=" + longitude;
    http.begin(client, serverUrl);

    int httpResponseCode = http.GET();
    Serial.print("Server Response: ");
    Serial.println(httpResponseCode);

    http.end(); // End the connection
  } else {
    Serial.println("WiFi not connected");
  }
}
