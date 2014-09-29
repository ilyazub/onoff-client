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
        model.restangularizeChildren = ->
          Restangular.restangularizeCollection(model, model.cart_items, 'cart_items')
          model.cart_items.restangularizeSeries()

        model
      )

      Restangular.service('carts')
  ]