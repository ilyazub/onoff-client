'use strict'

describe 'Directive: series', ->

  # load the directive's module
  beforeEach module 'onoffClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<series></series>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the series directive'
