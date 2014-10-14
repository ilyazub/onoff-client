'use strict'

describe 'Service: ValuesSvc', ->

  beforeEach module 'onoffClientApp'

  ValuesSvc = {}
  beforeEach inject (_ValuesSvc_) ->
    ValuesSvc = _ValuesSvc_

  it 'should do something', ->
    expect(!!ValuesSvc).toBe true
