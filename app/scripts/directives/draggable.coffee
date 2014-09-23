'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:draggable
 # @description
 # # draggable
###
angular.module('onoffClientApp')
  .directive('draggable', ->
    restrict: 'EA'
    scope:
      jsonData: '='
      transferredDataType: '@'
    link: ($scope, element, attrs) ->
      handleDragStart = (e) ->
        e.originalEvent.dataTransfer.effectAllowed = 'copy'

        e.originalEvent.dataTransfer.setData($scope.transferredDataType, $scope.jsonData) if $scope.jsonData?

      element.on('dragstart', handleDragStart)
    controller: [ '$scope', 'defaultTransferredDataType', ($scope, defaultTransferredDataType) ->
      $scope.transferredDataType ||= defaultTransferredDataType
    ]
  )