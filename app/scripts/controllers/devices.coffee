'use strict'

###*
 # @ngdoc function
 # @name onoffClientApp.controller:DevicesCtrl
 # @description
 # # DevicesCtrl
 # Controller of the onoffClientApp
###
angular
  .module('onoffClientApp')
  .controller 'DevicesCtrl', [
    '$scope'
    '$localStorage'
    'Carts'
    'Devices'
    'CartItems'
    ($scope, localStorage, Carts, Devices, CartItems) ->
      if $scope.storedCart = localStorage.cart
        Carts.one($scope.storedCart.id).put().then(
          (cart) ->
            console.log 'update', cart

            $scope.cart = cart
            $scope.storedCart = localStorage.$reset(
              cart:
                id: cart.id
            )
        )
      else
        Carts.post().then(
          (cart) ->
            console.log 'create', cart

            $scope.cart = cart
            $scope.storedCart = localStorage.$reset(
              cart:
                id: cart.id
            )
        )

      Devices.getList().then(
        (devices) ->
          $scope.devices = devices
      )

      $scope.addToCart = (device) ->
        $scope.cart.id = $scope.session.id

        $scope.cart.post(
          'cart_items',
          cart_item:
            device_id: device.id
            amount: 1
        ).then(
          (cartItem) ->
            console.log cartItem
          (error) ->
            console.log error
        )
  ]