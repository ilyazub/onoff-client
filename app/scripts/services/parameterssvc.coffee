'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.ParametersSvc
 # @description
 # # ParametersSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'ParametersSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('parameters', (collection) ->
        collection.selectedValues = ->
          _.flatten(model.selectedValue() for model in collection)

        collection.selectDefaultValues = ->
          model.selectDefaultValue() for model in collection

        collection.restangularizeNested = (deviceSeries) ->
          deviceSeriesCopy = deviceSeries.clone()
          delete deviceSeriesCopy.parameters

          options =
            device_series: deviceSeriesCopy
            collection: collection

          model.restangularizeNested(options) for model in collection

          collection

        collection
      )

      Restangular.extendModel('parameters', (model) ->
        model.selectDefaultValue = ->
          model.values.selectDefault()

        model.selectedValue = ->
          model.values.getSelected()

        model.restangularizeNested = (options) ->
          Restangular.restangularizeCollection(model, model.values, 'values')
          model.values.restangularizeNested(model)

          model[key] = value for key, value of options

          model

        model
      )

      Restangular.service('parameters')
  ]