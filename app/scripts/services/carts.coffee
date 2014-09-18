'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.Carts
 # @description
 # # Carts
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'Carts', [
    'Restangular'
    (Restangular) ->
      Restangular.service('carts')
  ]