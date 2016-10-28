## Progmem

The Program memory features work much the same way as on a regular Arduino; placing read only data and strings in read only memory and freeing heap for your application.
The important difference is that on the ESP8266 the literal strings are not pooled.  This means that the same literal string defined inside a `F("")` and/or `PSTR("")` will take up space for each instance in the code. So you will need to manage the duplicate strings yourself.

There is one additional helper macro to make it easier to pass ```const PROGMEM``` strings to methods that take a ```__FlashStringHelper``` called ```FPSTR()```.  The use of this will help make it easier to pool strings.
Not pooling strings...

```c++
String response1;
response1 += F("http:");
...
String response2;
response2 += F("http:");
```

using FPSTR would become...

```c++
const char HTTP[] PROGMEM = "http:";
...
{
    String response1;
    response1 += FPSTR(HTTP);
    ...
    String response2;
    response2 += FPSTR(HTTP);
}
```
