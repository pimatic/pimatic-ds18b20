module.exports = {
  title: "pimatic-ping device config schemas"
  DS18B20Sensor: {
    title: "DS18B20Sensor config options"
    type: "object"
    extensions: ["xLink"]
    properties:
      hardwareId:
        description: "the id of the sensor"
        type: "string"
      interval:
        interval: "Interval in ms so read the sensor"
        type: "integer"
        default: 10000
  }
}