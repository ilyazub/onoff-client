'use strict'

describe 'Directive: selectedSkus', ->

  # load the directive's module
  beforeEach module 'onoffClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<selected-skus></selected-skus>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the selectedSkus directive'
