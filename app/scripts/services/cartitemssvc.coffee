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

        collection.restangularizeNested = ->
          model.restangularizeNested() for model in collection

          collection

        collection
      )

      Restangular.extendModel('cart_items', (model) ->
        model.toJSON = ->
          clone = model.plain()
          delete clone.device

          clone

        model.restangularizeNested = ->
          Restangular.restangularizeElement(null, model.device, 'devices')
          model.device.restangularizeNested()

          model

        model
      )

      service = Restangular.service('cart_items')
  ]