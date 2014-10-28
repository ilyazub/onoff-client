'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartItemsSvc
 # @description
 # # CartItemsSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartItemsSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('cart_items', (collection) ->
        collection.add = (item) ->
          index = collection.indexOf(item)

          if index is -1
            collection.push(item)
            item.restangularizeNested()

          collection

        collection.delete = (item, newItem) ->
          index = collection.indexOf(item)

          if index > -1
            collection.splice(index, 1)

          collection

        collection.series = ->
          result = []

          for model in collection
            series = model.series() or []

            for serie in series
              if existingSeries = _.find(result, id: serie.id)
                existingSeries.deviceSeriesSkus.push(serie.deviceSeriesSkus...)
              else
                result.push(serie)

          Restangular.restangularizeCollection(model.cart, result, 'series')
          result.restangularizeNested()

          result

        collection.restangularizeNested = (cart) ->
          model.restangularizeNested(cart: cart) for model in collection

          collection

        collection
      )

      Restangular.extendModel('cart_items', (model) ->
        model.series = ->
          model.device.series

        model.toJSON = ->
          clone = model.plain()
          delete clone.device

          clone

        model.restangularizeNested = (options = {}) ->
          Restangular.restangularizeElement(null, model.device, 'devices')
          model.device.restangularizeNested()

          model[key] = value for key, value in options

          model

        model
      )

      service = Restangular.service('cart_items')
  ]