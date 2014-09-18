'use strict'

describe 'Service: Devices', ->

  beforeEach module 'onoffClientApp'

  Devices = {}
  beforeEach inject (_Devices_) ->
    Devices = _Devices_