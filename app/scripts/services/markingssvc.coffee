'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.MarkingsSvc
 # @description
 # # MarkingsSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'MarkingsSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.service('markings')
  ]