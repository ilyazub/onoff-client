'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DeviceSeriesSKUsSvc
 # @description
 # # DeviceSeriesSKUsSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'DeviceSeriesSKUsSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('device_series_skus', (collection) ->
        collection.price = (amount = 1) ->
          prices = _.reduce(
            collection
            (price, item) ->
              price + item.price()
            0
          )

          price = amount * prices

        collection.restangularizeNested = (deviceSeries) ->
          deviceSeriesClone = deviceSeries.clone()
          delete deviceSeriesClone.device_series_skus

          options =
            device_series: deviceSeriesClone

          item.restangularizeNested(options) for item in collection

          collection

        collection
      )

      Restangular.extendModel('device_series_skus', (model) ->
        model.toJSON = ->
          clone = model.clone()
          delete clone.device_series

          clone

        model.price = ->
          model.amount * model.sku.unit_price

        model.compiledTitle = ->
          parameters = model.getParameters()

          if parameters.length > 0
            values = parameters.selectedValues()

            title = undefined
            for value in values
              title = model.compileTitle(value, title)

            title
          else
            model.sku.title

        model.compileTitle = (value, title = model.sku.title) ->
          title.replace(value.parameter.variable, value.code)

        model.getParameters = _.memoize(
          ->
            sku_parameters = _.pluck(model.sku_parameters, 'parameter_id')

            parameters = _.filter(
              model.device_series.parameters
              (parameter) ->
                _.contains(sku_parameters, parameter.id)
            )

            Restangular.restangularizeCollection(model.device_series, parameters, 'parameters')
            parameters.restangularizeNested(model.device_series)

            parameters
          ->
            model.id
        )

        model.restangularizeNested = (options) ->
          Restangular.restangularizeElement(null, model.sku, 'skus')

          model[key] = value for key, value of options

          model

        model
      )

      Restangular.service('device_series_skus')
    ]