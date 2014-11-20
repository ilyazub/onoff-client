'use strict'

###*
 # @ngdoc function
 # @name onoffClientApp.controller:AdminCtrl
 # @description
 # # AdminCtrl
 # Controller of the onoffClientApp
###
angular.module('onoffClientApp')
  .controller 'AdminCtrl', ($scope, apiUrl, Restangular) ->
    AdminRestangular = Restangular.setBaseUrl(apiUrl + '/admin')

    DeviceGroupsSvc = AdminRestangular.service('device_groups')
    RangesSvc       = AdminRestangular.service('ranges')

    $scope.deviceGroups = DeviceGroupsSvc.getList().$object
    $scope.ranges       = RangesSvc.getList().$object