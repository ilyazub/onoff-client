'use strict'

describe 'Service: DeviceSeriesMarkings', ->

  beforeEach module 'onoffClientApp'

  DeviceSeriesMarkings = {}
  beforeEach inject (_DeviceSeriesMarkings_) ->
    DeviceSeriesMarkings = _DeviceSeriesMarkings_

  it 'should do something', ->
    expect(!!DeviceSeriesMarkings).toBe true
