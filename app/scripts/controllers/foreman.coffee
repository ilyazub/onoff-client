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
    'Restangular'
    'CartsModel'
    'DevicesSvc'
    'CartItemsModel'
    ($scope, Restangular, Carts, Devices, CartItems) ->
      initializeCart = (cart) ->
        $scope.cart = cart
        $scope.cartItems = new CartItems(service: cart.cart_items)

      initializeDevices = (devices) ->
        $scope.devices = devices

      Carts.initialize(initializeCart)
      Devices.getList().then(initializeDevices)
  ]