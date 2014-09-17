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
  .factory 'RestangularJson', (Restangular) ->
    Restangular.withConfig(
      (RestangularConfigurer) ->
        RestangularConfigurer.setRequestSuffix('.json')
    )
  .factory 'Devices', (RestangularJson) ->
    RestangularJson.service('devices')
  .factory 'Carts', (RestangularJson) ->
    RestangularJson.service('carts')
  .factory 'CartItems', (RestangularJson) ->
    RestangularJson.service('cart_items')
  .controller 'DevicesCtrl', ($scope, $localStorage, Devices, Carts, CartItems) ->
    console.log $scope.session

    unless $scope.session
      Carts.post().then(
        (cart) ->
          $scope.cart = cart

          $scope.session = $localStorage.$default(
            cartId: cart.id
          )
      )

    Devices.getList().then(
      (devices) ->
        $scope.devices = devices
    )

    $scope.addToCart = (device) ->
      $scope.cart.id = $scope.session.cartId

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