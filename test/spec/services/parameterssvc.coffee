'use strict'

describe 'Service: ParametersSvc', ->

  beforeEach module 'onoffClientApp'

  ParametersSvc = {}
  beforeEach inject (_ParametersSvc_) ->
    ParametersSvc = _ParametersSvc_

  it 'should do something', ->
    expect(!!ParametersSvc).toBe true
