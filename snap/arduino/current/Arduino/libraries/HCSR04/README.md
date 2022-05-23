# Arduino library for HC-SR04 ultrasonic distance sensor.

HC-SR04 is an ultrasonic sensor that measures distances from 2 to 400cm.

![HC-SR04](/hcsr04.jpg)

This is a simple library for it!

## Usage
Sensor is initialized by creating instance of class UltraSonicDistanceSensor and providing trigger and echo pins.
```c
UltraSonicDistanceSensor sensor(triggerPin, echoPin);
```

Default value for maximum measurement distance is 4m, since HC-SR04 sensor can't measure reliably beyond that.
However, if you are using another sensor or if you you don't care about distances larger than some value, you can set a maximum distance in cm yourself.
```c
UltraSonicDistanceSensor sensor(triggerPin, echoPin, maxDistanceCm);
```

Besides defining max distance, you can also define max time of measurement (in micro seconds). This is important when you want to ensure your program does not block for longer than specific period of time.
```c
UltraSonicDistanceSensor sensor(triggerPin, echoPin, maxDistanceCm, absoluteTimeout);
```

Then, to measure the distance, you just call `measureDistanceCm()`, which will return distance in centimeters (double). If distance is larger than 400cm, it will return negative value.

The calculation assumes a temperature of around 20°C. For improved accuracy you may also provide a temperature yourself, either an average for your location or directly measured from another sensor. The call for a temperature of 3.5°C would as such look like this: `measureDistanceCm(3.5)`.
