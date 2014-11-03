'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:deviceSeries
 # @description
 # # deviceSeries
###
angular.module('onoffClientApp')
  .directive('deviceSeries', ->
    templateUrl: 'views/deviceseries.html'
    restrict: 'EA'
  )
