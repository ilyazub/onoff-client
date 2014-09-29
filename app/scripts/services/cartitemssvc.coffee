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
        collection.restangularizeSeries = ->
          series = _.flatten(item.series for item in collection)

          collection.series = series

          Restangular.restangularizeCollection(collection, series, 'series')

        collection.add = (item) ->
          index = collection.indexOf(item)

          if index is -1
            collection.push(item)
            collection.restangularizeSeries()

          collection

        collection.delete = (item, status) ->
          index = collection.indexOf(item)

          if index > -1 && status is 'true'
            collection.splice(index, 1)
            collection.restangularizeSeries()

          collection

        collection
      )

      Restangular.service('cart_items')
  ]