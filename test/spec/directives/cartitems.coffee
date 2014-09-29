'use strict'

describe 'Directive: cartItems', ->

  # load the directive's module
  beforeEach module 'onoffClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<cart-items></cart-items>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the cartItems directive'
