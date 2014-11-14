'use strict'

###*
 # @ngdoc function
 # @name onoffClientApp.controller:SeriesCtrl
 # @description
 # # SeriesCtrl
 # Controller of the onoffClientApp
###
angular.module('onoffClientApp')
  .controller 'SeriesCtrl', ($scope, $http, $routeParams, Restangular) ->
    $scope.cartId = $routeParams.cartId

    Cart = Restangular.one('carts', $scope.cartId)
    Series = Restangular.service('series', Restangular.one('carts', $scope.cartId))

    Cart.put().then(
      (cart) ->
        $scope.newCart = new CartModel(id: $scope.cartId, cartItems: cart.cartItems)
        $scope.newCart.loadSeries()
    )

    class BaseModel
      constructor: (@attributes = {}, @options = {}) ->
        this.defineProperties()
        @collection = @options.collection if @options.collection
        this.initialize(@attributes, @options)

      initialize: ->

      defineProperties: ->
        this.defineProperty(key, value) for key, value of @attributes

      defineProperty: (key, value) ->
        self = this

        self.attributes[key] = value

        do (key) ->
          Object.defineProperty(
            self
            key
            enumerable: true
            configurable: true
            get: ->
              self.attributes[key]
            set: (value) ->
              self.attributes[key] = value
          )

      toJSON: ->
        angular.copy @attributes

    for method in [ 'has' ]
      BaseModel::[method] = (args...) ->
        args.unshift(@attributes)
        return _[method].apply(_, args)

    class BaseCollection
      model: BaseModel

      constructor: (models = [], options = {}) ->
        @model = options.model if options.model
        this.reset(models, options)
        this.initialize(models, options)

      initialize: ->

      reset: (models, options) ->
        @models = for attributes in models
          options.collection = this

          new @model(attributes, options)

      findWhere: (attributes) ->
        _.find(
          @models
          (model) ->
            for key, value of attributes
              return false if model[key] isnt value

            return true
          this
        )

      size: ->
        @models.length

      toJSON: ->
        model.toJSON() for model in @models

    for method in [ 'pluck', 'where', 'find', 'reduce' ]
      BaseCollection::[method] = (args...) ->
        args.unshift(@models)
        return _[method].apply(_, args)

    class CartModel extends BaseModel
      initialize: ->
        @expanded = true

        @cartItems = new CartItemsCollection(@cartItems, cart: this)

      loadSeries: ->
        Series.getList().then(
          (series) =>
            @series = new SeriesCollection(series.plain(), cart: this)
        )

      amountOfDevices: (deviceId) ->
        @cartItems.amountOfDevices(deviceId)

    class CartItemModel extends BaseModel
      initialize: ->
        @device = new DeviceModel(@device, cartItem: this)

      amountOfDevices: (deviceId) ->
        if @device.id is deviceId then @amount else 0

    class CartItemsCollection extends BaseCollection
      model: CartItemModel

      amountOfDevices: (deviceId) ->
        this.reduce(
          (amount, cartItem) ->
            amount + cartItem.amountOfDevices(deviceId)
          0
        )

    class DeviceModel extends BaseModel
    class DevicesCollection extends BaseModel
      model: DeviceModel

    class SeriesModel extends BaseModel
      initialize: ->
        @parameters = new ParametersCollection(
          @parameters
          series: this
          cart:   @options.cart
        )

        @skus = new SKUCollection(@skus, series: this)

      price: ->
        @skus.price(@parameters, @options.cart)

      toJSON: ->
        attrs = super

        delete attrs.title
        delete attrs.manufacturer

        attrs

    class SeriesCollection extends BaseCollection
      model: SeriesModel

    class ParameterModel extends BaseModel
      initialize: ->
        @values = new ValuesCollection(
          @values
          parameter: this
          series: @options.series
          cart: @options.cart
        )

      selectedValue: ->
        @values.selectedValue()

      selectedValueId: ->
        @values.selectedValueId()

      toJSON: ->
        attrs = super

        delete attrs.variable
        delete attrs.description

        attrs

    class ParametersCollection extends BaseCollection
      model: ParameterModel

    class ValueModel extends BaseModel
      initialize: ->
        this.update() if @selected

      select: ->
        unless @selected
          @collection.unselect()
          @selected = true
          this.update()

      unselect: ->
        @selected = false

      update: ->
        $http.put("/api/carts/#{@options.cart.id}/values", angular.toJson(this))

      toJSON: ->
        attrs = super

        delete attrs.code
        delete attrs.description

        attrs.parameter_id = @options.parameter.id

        attrs

    class ValuesCollection extends BaseCollection
      model: ValueModel

      selectedValue: ->
        this.findWhere(selected: true)

      selectedValueId: ->
        this.selectedValue().id

      unselect: ->
        model.unselect() for model in @models

    class SKUModel extends BaseModel
      initialize: ->
        @skuParameters = new SkuParametersCollection(this.parameters, sku: this)

      price: (parameters, cart) ->
        price = if @unitPrice > 0 and @skuParameters.size() is 0 then @unitPrice else @skuParameters.price(parameters)

        price * @amount * cart.amountOfDevices(@deviceId)

    class SKUCollection extends BaseCollection
      model: SKUModel

      price: (parameters, cart) ->
        this.reduce(
          (price, model) ->
            price + model.price(parameters, cart)
          0
        )

    class SkuParameterModel extends BaseModel
      initialize: ->
        @skuValues = new SkuValuesCollection(this.values, parameter: this)

      price: (parameters) ->
        parameters.reduce(
          (price, parameter) ->
            if this.parameterId is parameter.id
              price + this.getValuePrice(parameter.selectedValueId())
            else
              price
          0
          this
        )

      getValuePrice: (valueId) ->
        @skuValues.get(valueId).unitPrice

    class SkuParametersCollection extends BaseCollection
      model: SkuParameterModel

      price: (parameters) ->
        this.reduce(
          (price, model) ->
            price + model.price(parameters)
          0
        )

    class SkuValueModel extends BaseModel

    class SkuValuesCollection extends BaseCollection
      model: SkuValueModel

      get: (valueId) ->
        this.findWhere(valueId: valueId)