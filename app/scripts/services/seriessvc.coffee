'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.SeriesSvc
 # @description
 # # SeriesSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'SeriesSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendModel('series', (model) ->
        model.price = ->
          for deviceSeriesSku in model.deviceSeriesSkus
            deviceSeriesSku.unitPrice

        model.restangularizeNested = (options = {}) ->
          Restangular.restangularizeCollection(model, model.deviceSeriesSkus, 'device_series_skus')
          model.deviceSeriesSkus.restangularizeNested(model)

          model[key] = value for key, value in options

          model

        model
      )

      Restangular.extendCollection('series', (collection) ->
        collection.restangularizeNested = (cart) ->
          model.restangularizeNested(cart: cart) for model in collection

          collection

        collection
      )

      Restangular.service('series')
  ]