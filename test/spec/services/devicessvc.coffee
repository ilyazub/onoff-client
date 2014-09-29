'use strict'

describe 'Service: DevicesSvc', ->

  beforeEach module 'onoffClientApp'

  DevicesSvc = {}
  beforeEach inject (_DevicesSvc_) ->
    DevicesSvc = _DevicesSvc_