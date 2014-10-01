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
          Restangular.restangularizeCollection(model, model.cart_items, 'cart_items')
          model.cart_items.restangularizeNested()

        model
      )

      Restangular.service('carts')
  ]