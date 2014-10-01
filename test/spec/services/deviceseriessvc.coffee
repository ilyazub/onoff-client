'use strict'

describe 'Service: DeviceSeriesSvc', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  DeviceSeriesSvc = {}
  beforeEach inject (_DeviceSeriesSvc_) ->
    DeviceSeriesSvc = _DeviceSeriesSvc_

  it 'should do something', ->
    expect(!!DeviceSeriesSvc).toBe true
