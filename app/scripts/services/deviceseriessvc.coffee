'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DeviceSeriesSvc
 # @description
 # # DeviceSeriesSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'DeviceSeriesSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('device_series', (collection) ->
        collection.restangularizeNested = ->
          for item in collection
            Restangular.restangularizeCollection(item, item.device_series_stock_keeping_units, 'device_series_stock_keeping_units')
            item.device_series_stock_keeping_units.restangularizeNested()

        collection
      )
      Restangular.service('device_series')
  ]