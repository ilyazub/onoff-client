'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.Carts
 # @description
 # # Carts
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'Carts', [
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