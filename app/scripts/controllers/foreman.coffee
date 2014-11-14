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
  .controller 'ForemanCtrl', ($scope, Restangular, CartsModel, DevicesSvc, CartItemsModel) ->
    initializeDevices = (devices) ->
      $scope.devices = devices

    initializeCart = (cart) ->
      $scope.cart = cart
      $scope.cartItems = new CartItemsModel(service: $scope.cart.cartItems)

    $scope.cart = {}
    $scope.devices = []

    DevicesSvc.getList().then(initializeDevices)
    CartsModel.initialize(initializeCart)