

## Timing and delays
`millis()` and `micros()` return the number of milliseconds and microseconds elapsed after reset, respectively.

`delay(ms)` pauses the sketch for a given number of milliseconds and allows WiFi and TCP/IP tasks to run.
`delayMicroseconds(us)` pauses for a given number of microseconds.

Remember that there is a lot of code that needs to run on the chip besides the sketch
when WiFi is connected. WiFi and TCP/IP libraries get a chance to handle any pending
events each time the `loop()` function completes, OR when `delay` is called.
If you have a loop somewhere in your sketch that takes a lot of time (>50ms) without
calling `delay`, you might consider adding a call to `delay` function to keep the WiFi
stack running smoothly.

There is also a `yield()` function which is equivalent to `delay(0)`. The `delayMicroseconds`
function, on the other hand, does not yield to other tasks, so using it for delays
more than 20 milliseconds is not recommended.
