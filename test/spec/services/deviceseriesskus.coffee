'use strict'

describe 'Service: DeviceSeriesSKUsSvc', ->

  beforeEach module 'onoffClientApp'

  DeviceSeriesSKUsSvc = {}
  beforeEach inject (_DeviceSeriesSKUsSvc_) ->
    DeviceSeriesSKUsSvc = _DeviceSeriesSKUsSvc_

  it 'should do something', ->
    expect(!!DeviceSeriesSKUsSvc).toBe true
