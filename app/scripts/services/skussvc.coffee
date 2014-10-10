'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.SKUsSvc
 # @description
 # # SKUsSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'SKUsSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.service('markings')
  ]