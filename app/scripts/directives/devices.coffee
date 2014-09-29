'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:devices
 # @description
 # # devices
###
angular.module('onoffClientApp')
  .directive('devices', ->
    templateUrl: '/views/devices.html'
    restrict: 'EA'
    link: (scope, element, attrs) ->
  )
