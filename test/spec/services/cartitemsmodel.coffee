'use strict'

describe 'Service: CartItemsModel', ->

  beforeEach module 'onoffClientApp'

  CartItemsModel = {}
  beforeEach inject (_CartItemsModel_) ->
    CartItemsModel = _CartItemsModel_