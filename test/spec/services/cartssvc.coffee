'use strict'

describe 'Service: CartsSvc', ->

  beforeEach module 'onoffClientApp'

  CartsSvc = {}
  beforeEach inject (_CartsSvc_) ->
    CartsSvc = _CartsSvc_