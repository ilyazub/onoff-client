'use strict'

describe 'Service: CartItemsSvc', ->

  beforeEach module 'onoffClientApp'

  CartItemsSvc = {}
  beforeEach inject (_CartItemsSvc_) ->
    CartItemsSvc = _CartItemsSvc_