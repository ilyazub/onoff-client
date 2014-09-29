'use strict'

describe 'Service: CartsModel', ->

  beforeEach module 'onoffClientApp'

  CartsModel = {}
  beforeEach inject (_CartsModel_) ->
    CartsModel = _CartsModel_