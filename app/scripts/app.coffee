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
    'ngRoute'
    'restangular'
    'ngStorage'
    'ilyazub.dragndrop-object'
    'angulartics'
    'angulartics.google.analytics'
  ])
  .config [
    '$routeProvider'
    ($routeProvider) ->
      $routeProvider
        .when '/',
          templateUrl: 'views/foreman.html'
          controller: 'ForemanCtrl'
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
      )
  ]