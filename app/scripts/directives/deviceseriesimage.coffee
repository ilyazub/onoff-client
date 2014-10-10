'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:deviceSeriesImage
 # @description
 # # deviceSeriesImage
###
angular.module('onoffClientApp')
  .directive('deviceSeriesImage', ->
    templateUrl: '/views/deviceseriesimage.html'
    restrict: 'EA'
  )
