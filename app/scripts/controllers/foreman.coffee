'use strict'

###*
 # @ngdoc function
 # @name onoffClientApp.controller:ForemanCtrl
 # @description
 # # ForemanCtrl
 # Controller of the onoffClientApp
###
angular
  .module('onoffClientApp')
  .controller 'ForemanCtrl', [
    '$scope'
    '$localStorage'
    'Restangular'
    'Carts'
    'Devices'
    'CartItems'
    ($scope, localStorage, Restangular, Carts, Devices, CartItems) ->
      if $scope.storedCart = localStorage.cart
        Carts.one($scope.storedCart.id).put().then(
          (cart) ->
            $scope.cart = cart
            $scope.storedCart = localStorage.$reset(
              cart: cart.plain()
            )

            Restangular.restangularizeCollection(cart, cart.cart_items, 'items')
        )
      else
        Carts.post().then(
          (cart) ->
            $scope.cart = cart
            $scope.storedCart = localStorage.$reset(
              cart: cart.plain()
            )

            Restangular.restangularizeCollection(cart, cart.cart_items, 'items')
        )

      Devices.getList().then(
        (devices) ->
          $scope.devices = devices
      )

      $scope.addToCart = (device) ->
        $scope.cart.cart_items.post(
          device_id: device.id
          amount: 1
        ).then(
          (cartItem) ->
            index = $scope.cart.cart_items.indexOf(cartItem)

            if index is -1
              $scope.cart.cart_items.push(cartItem)
          (error) ->
            console.log error
        )

      $scope.updateItem = (cartItem) ->
        cartItem.put().then(
          (status) ->
            console.log status
          (error) ->
            console.log error
        )

      $scope.deleteItem = (cartItem) ->
        cartItem.remove().then(
          (status) ->
            index = $scope.cart.cart_items.indexOf(cartItem)
            if index > -1 && status
              $scope.cart.cart_items.splice(index, 1)
          (error) ->
            console.log error
        )

      $scope.stringify = (object) ->
        JSON.stringify(object.plain())
  ]