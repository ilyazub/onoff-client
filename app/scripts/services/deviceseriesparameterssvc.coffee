'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DeviceSeriesParametersSvc
 # @description
 # # DeviceSeriesParametersSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'DeviceSeriesParametersSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('device_series_parameters', (collection) ->
        collection.restangularizeNested = ->
          model.restangularizeNested() for model in collection

        collection
      )

      Restangular.extendModel('device_series_parameters', (model) ->
        model.restangularizeNested = ->
          Restangular.restangularizeCollection(model, model.values, 'device_series_parameter_values')

        model
      )

      Restangular.service('device_series_parameters')
  ]