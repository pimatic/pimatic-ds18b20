pimatic-ds18b20
================

Support for the ds18b20 temperature sensor.

### Drivers

1-Wire drivers need to be loaded in order to create the connection between the physical sensor and the rPI.
You can load them from the terminal (or from the bin/modules.sh script).

    sudo modprobe wire
    sudo modprobe w1-gpio
    sudo modprobe w1-therm


### Example config

Add the plugin to the plugin section:

```json
{ 
  "plugin": "ds18b20"
}
```

Then add a sensor for your device to the devices section:

```json
{
  "id": "my-sensor",
  "name": "ds18b20 example",
  "class": "DS18B20Sensor",
  "hardwareId": "10-00080283a977",
  "interval": 10000
}
```
