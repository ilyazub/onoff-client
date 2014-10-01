'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DevicesSvc
 # @description
 # # DevicesSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'DevicesSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendModel('devices', (model) ->
        model.restangularizeNested = ->
          Restangular.restangularizeCollection(model, model.device_series, 'device_series')
          model.device_series.restangularizeNested()

        model
      )

      Restangular.service('devices')
  ]