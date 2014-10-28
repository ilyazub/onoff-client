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
        model.toJSON = ->
          clone = model.plain()
          delete clone.deviceSeries

          clone

        model.restangularizeNested = () ->
          model.getList('device_series').then(
            (deviceSeries) ->
              series = deviceSeries.map(
                (deviceSerie) ->
                  deviceSerie.series.deviceSeriesSkus = deviceSerie.deviceSeriesSkus

                  deviceSerie.series
              )

              model.series = _.flatten(series)
          )

        model
      )

      Restangular.service('devices')
  ]