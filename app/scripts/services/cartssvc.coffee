'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartsSvc
 # @description
 # # CartsSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartsSvc', (Restangular) ->
    Restangular.extendModel('carts', (model) ->
      model.removeAll = ->
        model.remove().then(
          (cart) ->
            model.cartItems.length = 0
        )

      model.restangularizeNested = ->
        Restangular.restangularizeCollection(model, model.cartItems, 'cart_items')

      model
    )

    Restangular.service('carts')