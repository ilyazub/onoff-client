'use strict'

describe 'Service: MarkingsSvc', ->

  # load the service's module
  beforeEach module 'onoffClientApp'

  # instantiate service
  MarkingsSvc = {}
  beforeEach inject (_MarkingsSvc_) ->
    MarkingsSvc = _MarkingsSvc_

  it 'should do something', ->
    expect(!!MarkingsSvc).toBe true
