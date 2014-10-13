'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:parameters
 # @description
 # # parameters
###
angular.module('onoffClientApp')
  .directive('parameters', ->
    templateUrl: '/views/parameters.html'
    restrict: 'EA'
  )
