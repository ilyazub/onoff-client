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
      clearDb: false
      isUploading: false
      submitButtonLabel: 'Загрузить'

    appendFormData = (formData, files, name) ->
      angular.forEach(files, (file) ->
        formData.append(name, file)
      )

    $scope.upload = ->
      formData = new FormData()

      appendFormData(formData, $scope.uploads.catalogue, 'catalogue')
      appendFormData(formData, $scope.uploads.priceList, 'price_list')
      formData.append('clear_db', $scope.uploads.clearDb)

      $scope.uploads.isUploading = true
      $scope.uploads.submitButtonLabel = 'Загружаю...'

      $http.post(
        apiUrl + '/admin/upload/' + name
        formData
        transformRequest: angular.identity
        headers: 'Content-Type': undefined
      ).success(
        (response) ->
          $scope.uploads =
            catalogue: {}
            priceList: {}
            images:
              devices: []
              ranges: []
              parameters: []
            clearDb: false
            isUploading: false
            submitButtonLabel: 'Загрузить'
      )