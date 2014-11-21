'use strict'

###*
 # @ngdoc function
 # @name onoffClientApp.controller:AdminCtrl
 # @description
 # # AdminCtrl
 # Controller of the onoffClientApp
###
angular.module('onoffClientApp')
  .controller 'AdminCtrl', ($scope, $http, apiUrl) ->
    $scope.uploads =
      catalogue: {}
      priceList: {}
      images:
        devices: []
        ranges: []
        parameters: []

    upload = (thing, name) ->
      data = new FormData()
      angular.forEach(thing, (file) ->
        data.append(name, file)
      )

      $http.post(
        apiUrl + '/admin/upload/' + name
        data
        transformRequest: angular.identity
        headers: 'Content-Type': undefined
      ).success(
        (response) ->
          console.log response

          thing = {}
      )

    $scope.upload = ->
      upload($scope.uploads.catalogue, 'catalogue') if $scope.uploads.catalogue.length > 0
      upload($scope.uploads.priceList, 'price_list') if $scope.uploads.priceList.length > 0