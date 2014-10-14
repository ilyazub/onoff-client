'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:selectedSkus
 # @description
 # # selectedSkus
###
angular.module('onoffClientApp')
  .directive('selectedSkus', ->
    templateUrl: '/views/selectedskus.html'
    restrict: 'EA'
  )
