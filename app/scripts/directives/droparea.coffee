'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:droparea
 # @description
 # # droparea
###
angular.module('onoffClientApp')
  .directive('droparea', ->
    restrict: 'EA'
    scope:
      drop: '&'
      transferredDataType: '@'
    link: ($scope, element, attrs) ->
      handleDrop = (e) ->
        element.removeClass('highlight')

        $scope.$apply(
          (scope) ->
            fn = scope.drop()

            json = JSON.parse(e.originalEvent.dataTransfer.getData($scope.transferredDataType))

            fn(json) if fn?
        )

        e.preventDefault()

      handleDragEnter = (e) ->
        element.addClass('highlight')

        e.preventDefault()

      handleDragLeave = (e) ->
        element.removeClass('highlight')

        e.preventDefault()

      handleDragOver = (e) ->
        e.originalEvent.dataTransfer.dropEffect = 'copy'

        e.preventDefault()

      element.on('drop', handleDrop)
      element.on('dragenter', handleDragEnter)
      element.on('dragleave', handleDragLeave)
      element.on('dragover', handleDragOver)
    controller: ($scope) ->
      $scope.transferredDataType ||= 'json'
  )