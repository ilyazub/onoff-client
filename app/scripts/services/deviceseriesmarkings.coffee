'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.DeviceSeriesMarkings
 # @description
 # # DeviceSeriesMarkings
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'DeviceSeriesMarkings', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('device_series_markings', (collection) ->
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

      Restangular.extendModel('device_series_markings', (model) ->
        model.price = ->
          model.amount * model.marking.price

        model.restangularizeNested = ->
          Restangular.restangularizeElement(null, model.marking, 'marking')

        model
      )

      Restangular.service('device_series_markings')
    ]