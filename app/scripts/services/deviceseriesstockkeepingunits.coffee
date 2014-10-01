'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DeviceSeriesStockKeepingUnits
 # @description
 # # DeviceSeriesStockKeepingUnits
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'DeviceSeriesStockKeepingUnits', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('device_series_stock_keeping_units', (collection) ->
        collection.price = (amount = 1) ->
          prices = _.reduce(
            collection
            (price, item) ->
              price + item.price()
            0
          )

          price = amount * prices

        collection.restangularizeNested = ->
          item.restangularizeNested() for item in collection

        collection
      )

      Restangular.extendModel('device_series_stock_keeping_units', (model) ->
        model.price = ->
          model.amount * model.stock_keeping_unit.price

        model.restangularizeNested = ->
          Restangular.restangularizeElement(null, model.stock_keeping_unit, 'stock_keeping_unit')

        model
      )

      Restangular.service('device_series_stock_keeping_units')
    ]