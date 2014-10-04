'use strict'

describe 'Service: DeviceSeriesParametersSvc', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  DeviceSeriesParametersSvc = {}
  beforeEach inject (_DeviceSeriesParametersSvc_) ->
    DeviceSeriesParametersSvc = _DeviceSeriesParametersSvc_

  it 'should do something', ->
    expect(!!DeviceSeriesParametersSvc).toBe true
