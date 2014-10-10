'use strict'

describe 'Service: ParameterValuesSvc', ->

  beforeEach module 'onoffClientApp'

  ParameterValuesSvc = {}
  beforeEach inject (_ParameterValuesSvc_) ->
    ParameterValuesSvc = _ParameterValuesSvc_

  it 'should do something', ->
    expect(!!ParameterValuesSvc).toBe true
