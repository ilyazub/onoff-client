'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DeviceSeriesParameterValuesSvc
 # @description
 # # DeviceSeriesParameterValuesSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'DeviceSeriesParameterValuesSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('device_series_parameter_values', (collection) ->
        collection.select = (value) ->
          model.unselect() for model in collection

          value.select()

        collection
      )

      Restangular.extendModel('device_series_parameter_values', (model) ->
        model.select = -> model.selected = true
        model.unselect = -> model.selected = false

        model
      )

      Restangular.service('device_series_parameter_values')
  ]