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
          itemPriceFn = if collection.hasParameters() then 'compiledPrice' else 'price'

          price = _.reduce(
            collection
            (price, item) ->
              price + item[itemPriceFn]()
            0
          )

          amount * price

        collection.hasParameters = ->
          for model in collection
            if model.hasParameters()
              return true

          return false

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
        model.compiledTitle = ->
          if model.parameters.length > 0
            values = model.parameters.selectedValues()

            title = undefined
            for value in values
              title = model.compileTitle(value, title)

            title
          else
            model.sku.title

        model.compileTitle = (value, title = model.sku.title) ->
          title.replace(value.parameter.variable, value.code)

        model.price = ->
          model.amount * model.sku.unit_price

        model.compiledPrice = ->
          model.amount * model.parameters.selectedValuesPrice()

        model.hasParameters = ->
          model.parameters.length > 0

        model.toJSON = ->
          clone = model.clone()
          delete clone.device_series
          delete clone.parameters

          clone

        model.restangularizeNested = (options) ->
          Restangular.restangularizeElement(null, model.sku, 'skus')
          Restangular.restangularizeCollection(model, model.parameters, 'parameters')
          model.parameters.restangularizeNested(model)

          model[key] = value for key, value of options

          model

        model
      )

      Restangular.service('device_series_skus')
    ]