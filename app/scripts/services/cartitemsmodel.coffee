'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.CartItemsModel
 # @description
 # # CartItemsModel
 # Factory in the onoffClientApp.
###
angular.module('onoffClientApp')
  .factory 'CartItemsModel', [
    'CartItemsSvc'
    (CartItemsSvc) ->
      class CartItems
        constructor: (@_options) ->
          { @model, @collection, @service } = @_options

        add: (device) =>
          cartItem = this._newCartItem(device)

          @service?.post(cartItem).then(
            this._addItem
          )

        update: (cartItem) =>
          cartItem.put().then(
            this._updateItem
            (response) ->
              console.warn response
          )

        remove: (cartItem) =>
          cartItem.remove().then(
            angular.bind(this, this._deleteItem, cartItem)
            (response) ->
              console.warn response
          )

        _addItem: (cartItem) =>
          @service?.add(cartItem)

        _updateItem: (status) =>

        _deleteItem: (cartItem, newCartItem) ->
          @service?.delete(cartItem, newCartItem)

        _newCartItem: (device) ->
          device_id: device.id
          amount: 1
  ]