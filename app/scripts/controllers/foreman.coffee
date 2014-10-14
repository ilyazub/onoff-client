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
    'DeviceSeriesSvc'
    'SKUsSvc'
    'DeviceSeriesSKUsSvc'
    'ParametersSvc'
    'ValuesSvc'
    ($scope, Restangular, Carts, Devices, CartItems, DeviceSeries, SKUs, DeviceSeriesSKUs, Parameters, Values) ->
      initializeCart = (cart) ->
        $scope.cart = cart
        $scope.cartItems = new CartItems(service: cart.cart_items)

      initializeDevices = (devices) ->
        $scope.devices = devices

      Carts.initialize(initializeCart)
      Devices.getList().then(initializeDevices)
  ]