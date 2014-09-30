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

        add: (device, callback) =>
          cartItem = this._newCartItem(device)

          @service?.post(cartItem)
            .then(
              (cartItem) =>
                this._addItem(cartItem)
                callback?(cartItem)
            )

        update: (cartItem, callback) ->
          cartItem.put().then(
            (status) =>
              this._updateItem(status)
              callback?(status)
          )

        remove: (cartItem, callback) ->
          cartItem.remove().then(
            (status) =>
              this._deleteItem(cartItem, status)
              callback?(cartItem, status)
          )

        _addItem: (cartItem) =>
          @service?.add(cartItem)

        _updateItem: (status) =>
          @service?.restangularizeSeries() if status is 'true'

        _deleteItem: (cartItem, status) =>
          @service?.delete(cartItem, status)

        _newCartItem: (device) ->
          device_id: device.id
          amount: 1
  ]