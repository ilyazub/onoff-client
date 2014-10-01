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
        collection.restangularizeNested = ->
          for item in collection
            Restangular.restangularizeElement(item, item.device, 'devices')
            item.device.restangularizeNested()

        collection.add = (item) ->
          index = collection.indexOf(item)

          if index is -1
            collection.push(item)
            collection.restangularizeNested()

          collection

        collection.delete = (item, status) ->
          index = collection.indexOf(item)

          if index > -1 && status is 'true'
            collection.splice(index, 1)
            collection.restangularizeNested()

          collection

        collection
      )

      Restangular.service('cart_items')
  ]