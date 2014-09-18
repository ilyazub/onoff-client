'use strict'

###*
 # @ngdoc overview
 # @name onoffClientApp
 # @description
 # # onoffClientApp
 #
 # Main module of the application.
###
angular
  .module('onoffClientApp', [
    'ngAnimate'
    'ngCookies'
    'ngResource'
    'ngRoute'
    'ngSanitize'
    'ngTouch'
    'restangular'
    'ngStorage'
  ])
  .config [
    '$routeProvider'
    ($routeProvider) ->
      $routeProvider
        .when '/',
          templateUrl: 'views/devices.html'
          controller: 'DevicesCtrl'
        .otherwise
          redirectTo: '/'
  ]
  .config [
    'RestangularProvider'
    'apiUrl'
    (RestangularProvider, apiUrl) ->
      RestangularProvider.setBaseUrl(apiUrl)
      RestangularProvider.setDefaultHttpFields(
        cache: true
        withCredentials: true
      )
  ]