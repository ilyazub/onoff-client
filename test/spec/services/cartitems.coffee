'use strict'

describe 'Service: CartItems', ->

  beforeEach module 'onoffClientApp'

  CartItems = {}
  beforeEach inject (_CartItems_) ->
    CartItems = _CartItems_