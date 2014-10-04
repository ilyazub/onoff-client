'use strict'

describe 'Service: DeviceSeriesParameterValuesSvc', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  DeviceSeriesParameterValuesSvc = {}
  beforeEach inject (_DeviceSeriesParameterValuesSvc_) ->
    DeviceSeriesParameterValuesSvc = _DeviceSeriesParameterValuesSvc_

  it 'should do something', ->
    expect(!!DeviceSeriesParameterValuesSvc).toBe true
