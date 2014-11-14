'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartsModel
 # @description
 # # CartsModel
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartsModel', ($localStorage, CartsSvc) ->
    storedCart = $localStorage.cart

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

      $localStorage.$reset(
        cart:
          id: cart.id
      )

      cart.restangularizeNested()