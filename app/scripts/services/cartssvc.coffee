'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartsSvc
 # @description
 # # CartsSvc
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartsSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendModel('carts', (model) ->
        model.restangularizeNested = ->
          Restangular.restangularizeCollection(model, model.cartItems, 'cart_items')
          model.cartItems.restangularizeNested(model)

        model
      )

      Restangular.service('carts')
  ]