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
    'CartsModel'
    'DevicesSvc'
    'CartItemsSvc'
    ($scope, localStorage, Restangular, Carts, Devices, CartItems) ->
      initializeCart = (cart) ->
        $scope.cart = cart

      initializeDevices = (devices) ->
        $scope.devices = devices

      Carts.initialize(initializeCart)
      Devices.getList().then(initializeDevices)

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