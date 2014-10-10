'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:skuParameters
 # @description
 # # skuParameters
###
angular.module('onoffClientApp')
  .directive('skuParameters', ->
    templateUrl: '/views/skuparameters.html'
    restrict: 'EA'
  )
