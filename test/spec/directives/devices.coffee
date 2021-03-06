'use strict'

describe 'Directive: devices', ->

  # load the directive's module
  beforeEach module 'onoffClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<devices></devices>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the devices directive'
