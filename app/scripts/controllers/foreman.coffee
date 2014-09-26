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
              cart: angular.copy(cart.plain())
            )

            cart.restangularizeChildren()
        )
      else
        Carts.post().then(
          (cart) ->
            $scope.cart = cart
            $scope.storedCart = localStorage.$reset(
              cart: angular.copy(cart.plain())
            )

            cart.restangularizeChildren()
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
            $scope.cart.cart_items.add(cartItem)
          (error) ->
            console.log error
        )

      $scope.updateItem = (cartItem) ->
        cartItem.put().then(
          (status) ->
            status is 'true' && $scope.cart.cart_items.restangularizeSeries()
            console.log status
          (error) ->
            console.log error
        )

      $scope.deleteItem = (cartItem) ->
        cartItem.remove().then(
          (status) ->
            $scope.cart.cart_items.delete(cartItem, status)
          (error) ->
            console.log error
        )
  ]