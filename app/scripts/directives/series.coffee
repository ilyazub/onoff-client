'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:series
 # @description
 # # series
###
angular.module('onoffClientApp')
  .directive('series', ->
    templateUrl: '/views/series.html'
    restrict: 'EA'
    link: (scope, element, attrs) ->
  )
