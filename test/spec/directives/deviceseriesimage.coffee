'use strict'

describe 'Directive: deviceSeriesImage', ->

  beforeEach module 'onoffClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<device-series-image></device-series-image>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the deviceSeriesImage directive'
