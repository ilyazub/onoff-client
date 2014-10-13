'use strict'

describe 'Directive: parameters', ->

  beforeEach module 'onoffClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<parameters></parameters>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the parameters directive'
