'use strict'

describe 'Service: SeriesSvc', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  SeriesSvc = {}
  beforeEach inject (_SeriesSvc_) ->
    SeriesSvc = _SeriesSvc_

  it 'should do something', ->
    expect(!!SeriesSvc).toBe true
