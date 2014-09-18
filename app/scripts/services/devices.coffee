'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.Devices
 # @description
 # # Devices
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'Devices', [
    'Restangular'
    (Restangular) ->
      Restangular.service('devices')
  ]