'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:cartItems
 # @description
 # # cartItems
###
angular.module('onoffClientApp')
  .directive('cartItems', ->
    templateUrl: '/views/cartitems.html'
    restrict: 'EA'
    link: (scope, element, attrs) ->
  )
