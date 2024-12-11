#include <TinyGPSPlus.h>

#include <ESP8266WiFi.h>
#include <SoftwareSerial.h>

// WiFi credentials
const char* ssid = "iPhone11";
const char* password = "Harry12345678";

WiFiServer server(80);
TinyGPSPlus gps;
SoftwareSerial gpsSerial(D1, D2); // RX, TX

void setup() {
  Serial.begin(115200);
  gpsSerial.begin(9600);

  // Connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  while (WiFi.status() == WL_CONNECTED) {
    delay(1000);
    Serial.println("Connected to WiFi");
    Serial.println(WiFi.localIP());
  }
  
  server.begin();
}

void loop() {
  WiFiClient client = server.available();

  while (gpsSerial.available() > 0) {
    gps.encode(gpsSerial.read());
  }

  if (client) {
    if (gps.location.isUpdated()) {
      String response = "{";
      response += "\"latitude\": ";
      response += gps.location.lat(), 6;
      response += ", \"longitude\": ";
      response += gps.location.lng(), 6;
      response += "}";

      client.println("HTTP/1.1 200 OK");
      client.println("Content-Type: application/json");
      client.println("Connection: close");
      client.println();
      client.println(response);

      Serial.println(response);
    }
  }
}
