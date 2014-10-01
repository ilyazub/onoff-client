'use strict'

describe 'Service: DeviceSeriesStockKeepingUnits', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  DeviceSeriesStockKeepingUnits = {}
  beforeEach inject (_DeviceSeriesStockKeepingUnits_) ->
    DeviceSeriesStockKeepingUnits = _DeviceSeriesStockKeepingUnits_

  it 'should do something', ->
    expect(!!DeviceSeriesStockKeepingUnits).toBe true
