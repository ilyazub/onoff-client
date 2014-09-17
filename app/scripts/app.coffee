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
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'restangular',
    'ngStorage'
  ])
  .config [ '$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/devices.html'
        controller: 'DevicesCtrl'
      .otherwise
        redirectTo: '/'
  ]
  .config [ 'RestangularProvider', (RestangularProvider) ->
      RestangularProvider.setBaseUrl('http://localhost:9292')
      RestangularProvider.setDefaultHttpFields(
        cache: true
        withCredentials: true
      )
  ]