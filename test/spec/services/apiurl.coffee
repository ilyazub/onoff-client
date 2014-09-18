'use strict'

describe 'Service: apiUrl', ->

  beforeEach module 'onoffClientApp'

  apiUrl = {}
  beforeEach inject (_apiUrl_) ->
    apiUrl = _apiUrl_