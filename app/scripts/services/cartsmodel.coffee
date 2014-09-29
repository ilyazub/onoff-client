'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartsModel
 # @description
 # # CartsModel
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartsModel', [
    '$localStorage'
    'CartsSvc'
    (localStorage, CartsSvc) ->
      storedCart = localStorage.cart

      initialize: (callback) ->
        if storedCart
          CartsSvc.one(storedCart.id).put().then(
            (cart) =>
              this.initializeCart(cart, callback)
          )
        else
          CartsSvc.post().then(
            (cart) =>
              this.initializeCart(cart, callback)
          )

      initializeCart: (cart, callback) ->
        callback(cart)

        plainCart = angular.copy(cart.plain())

        storedCart = localStorage.$reset(
          cart:
            id: plainCart.id
            cart_items: plainCart.cart_items
        )

        cart.restangularizeChildren()
  ]