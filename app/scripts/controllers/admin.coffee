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
      clearDb: false
      images: []
      isUploading: false
      submitButtonLabel: 'Загрузить'
      url: apiUrl + '/admin/upload'

    appendFormData = (formData, files, name) ->
      angular.forEach(files, (file) ->
        formData.append(name, file)
      )

    uploadImages = ->
      angular.forEach($scope.uploads.images, (image) ->
        formData = new FormData()
        formData.append('image', image)

        $http.post(
          $scope.uploads.url + '/images'
          formData
          transformRequest: angular.identity
          headers: 'Content-Type': undefined
        ).success(
          (response) ->
            $scope.uploads.isUploading = false
            $scope.uploads.submitButtonLabel = 'Загрузить'
        )
      )

    $scope.upload = ->
      formData = new FormData()

      appendFormData(formData, $scope.uploads.catalogue, 'catalogue')
      appendFormData(formData, $scope.uploads.priceList, 'price_list')
      formData.append('clear_db', $scope.uploads.clearDb)
      uploadImages()

      $scope.uploads.isUploading = true
      $scope.uploads.submitButtonLabel = 'Загружаю...'

      $http.post(
        $scope.uploads.url
        formData
        transformRequest: angular.identity
        headers: 'Content-Type': undefined
      ).success(
        (response) ->
          $scope.uploads.isUploading = false
          $scope.uploads.submitButtonLabel = 'Загрузить'
      )