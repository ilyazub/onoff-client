'use strict'

describe 'Controller: SeriesCtrl', ->

  beforeEach module 'onoffClientApp'

  SeriesCtrl = {}
  scope = {}
  http = {}
  routeParams = cartId: 'cart-id'
  Restangular = {}
  NonCachedRestangular = {}
  CartsSvc = {}
  Series = {}

  beforeEach inject ($controller, $rootScope, $q) ->
    scope = $rootScope.$new()

    Series = jasmine.createSpy('Series')

    NonCachedRestangular = jasmine.createSpyObj('Restangular without caching', ['service'])
    NonCachedRestangular.service.and.returnValue(Series)

    Restangular = jasmine.createSpyObj('Restangular', ['setDefaultHttpFields'])
    Restangular.setDefaultHttpFields.and.returnValue(NonCachedRestangular)

    promise = $q.defer().promise
    CartsSvc = jasmine.createSpyObj('Carts service', ['one'])
    CartsSvc.one.and.returnValue(promise)

    SeriesCtrl = $controller 'SeriesCtrl', {
      $scope: scope
      $http: http
      $routeParams: routeParams
      Restangular: Restangular
      CartsSvc: CartsSvc
    }

  describe 'initialization', ->
    it 'creates non-cached Restangular', ->
      expect(Restangular.setDefaultHttpFields).toHaveBeenCalledWith(cache: false)

    it 'creates service for series', ->
      expect(NonCachedRestangular.service)

    it 'updates cart', ->
      expect(CartsSvc.one).toHaveBeenCalledWith(routeParams.cartId)