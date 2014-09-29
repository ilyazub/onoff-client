'use strict'

describe 'Service: DeviceModel', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  DeviceModel = {}
  beforeEach inject (_DeviceModel_) ->
    DeviceModel = _DeviceModel_

  it 'should do something', ->
    expect(!!DeviceModel).toBe true
