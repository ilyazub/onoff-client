'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DevicesSvc
 # @description
 # # DevicesSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'DevicesSvc', (Restangular) ->
    Restangular.service('devices')