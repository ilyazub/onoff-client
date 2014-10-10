'use strict'

describe 'Service: SKUsSvc', ->

  beforeEach module 'onoffClientApp'

  SKUsSvc = {}
  beforeEach inject (_SKUsSvc_) ->
    SKUsSvc = _SKUsSvc_

  it 'should do something', ->
    expect(!!SKUsSvc).toBe true
