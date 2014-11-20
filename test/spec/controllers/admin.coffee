'use strict'

describe 'Controller: AdminCtrl', ->

  beforeEach module 'onoffClientApp'

  AdminCtrl = {}
  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AdminCtrl = $controller 'AdminCtrl', {
      $scope: scope
    }