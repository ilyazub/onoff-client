'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartItems
 # @description
 # # CartItems
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartItems', [
    'Restangular'
    (Restangular) ->
      Restangular.service('cart_items')
  ]