'use strict'

###*
 # @ngdoc directive
 # @name onoffClientApp.directive:fileInput
 # @description
 # # fileInput
###
angular.module('onoffClientApp')
  .directive('fileInput', ($parse) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.on('change', ->
        $parse(attrs.fileInput).assign(scope, element[0].files)
        scope.$apply()
      )
  )
