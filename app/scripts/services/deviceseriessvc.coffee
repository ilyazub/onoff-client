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
        collection.restangularizeNested = (device) ->
          model.restangularizeNested() for model in collection

          collection

        collection
      )

      Restangular.extendModel('device_series', (model) ->
        model.restangularizeNested = (options = {}) ->
          Restangular.restangularizeCollection(model, model.device_series_skus, 'device_series_skus')
          model.device_series_skus.restangularizeNested(model)

          model[key] = value for key, value in options

          model

        model
      )

      Restangular.service('device_series')
  ]