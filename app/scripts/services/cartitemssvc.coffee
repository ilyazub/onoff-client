'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartItemsSvc
 # @description
 # # CartItemsSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartItemsSvc', (Restangular) ->
    Restangular.extendCollection('cart_items', (collection) ->
      collection.add = (item) ->
        index = collection.indexOf(item)

        if index is -1
          collection.push(item)

        collection

      collection.delete = (item, newItem) ->
        index = collection.indexOf(item)

        unless index is -1
          collection.splice(index, 1)

        collection

      collection
    )

    Restangular.service('cart_items')