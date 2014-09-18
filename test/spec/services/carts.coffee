'use strict'

describe 'Service: Carts', ->

  beforeEach module 'onoffClientApp'

  Carts = {}
  beforeEach inject (_Carts_) ->
    Carts = _Carts_