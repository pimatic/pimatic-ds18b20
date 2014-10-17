module.exports = (env) ->

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  sense = require 'ds18b20'
  Promise.promisifyAll(sense)


  class DS18B20Plugin extends env.plugins.Plugin

    init: (app, @framework, @config) =>

      deviceConfigDef = require("./device-config-schema")

      @framework.deviceManager.registerDeviceClass("DS18B20Sensor", {
        configDef: deviceConfigDef.DS18B20Sensor, 
        createCallback: (config, lastState) => 
          device = new DS18B20Sensor(config, lastState)
          return device
      })


  class DS18B20Sensor extends env.devices.TemperatureSensor
    _temperature: null

    constructor: (@config, lastState) ->
      @id = config.id
      @name = config.name
      @_temperature = lastState?.temperature?.value
      super()

      @requestValue()
      setInterval( ( => @requestValue() ), @config.interval)


    requestValue: ->
      sense.temperatureAsync(@config.hardwareId).then( (value) =>
        @_temperature = value
        @emit 'temperature', value
      ).catch( (error) =>
        env.logger.error(
          "Error reading DS18B20Sensor with hardwareId #{@config.hardwareId}: #{error.message}"
        )
        env.logger.debug(error.stack)
      )

    getTemperature: -> Promise.resolve(@_temperature)

  # ###Finally
  # Create a instance of my plugin
  plugin = new DS18B20Plugin
  # and return it to the framework.
  return plugin