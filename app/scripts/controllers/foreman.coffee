'use strict'

###*
 # @ngdoc function
 # @name onoffClientApp.controller:ForemanCtrl
 # @description
 # # ForemanCtrl
 # Controller of the onoffClientApp
###
angular
  .module('onoffClientApp')
  .controller 'ForemanCtrl', [
    '$scope'
    '$http'
    'Restangular'
    'CartsModel'
    'DevicesSvc'
    'CartItemsModel'
    ($scope, $http, Restangular, Carts, Devices, CartItems) ->
      initializeDevices = (devices) ->
        $scope.devices = devices

      initializeCart = (cart) ->
        $scope.cart = cart
        $scope.cartItems = new CartItems(service: $scope.cart.cartItems)
        $scope.newCart = new OnOff.Models.Cart(id: $scope.cart.id, cartItems: $scope.cart.cartItems)

      $scope.cart = {}
      $scope.devices = []

      Devices.getList().then(initializeDevices)
      Carts.initialize(initializeCart)

      OnOff =
        Models: {}
        Collections: {}

      class OnOff.Models.Base
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
        OnOff.Models.Base::[method] = (args...) ->
          args.unshift(@attributes)
          return _[method].apply(_, args)

      class OnOff.Collections.Base
        model: OnOff.Models.Base

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
        OnOff.Collections.Base::[method] = (args...) ->
          args.unshift(@models)
          return _[method].apply(_, args)

      class OnOff.Models.Cart extends OnOff.Models.Base
        initialize: ->
          @expanded = true

          @cartItems = new OnOff.Collections.CartItems(@cartItems, cart: this)

        loadSeries: ->
          $http.get("/api/carts/#{@id}/series")
          .then(
            (response) =>
              @series = new OnOff.Collections.Series(response.data, cart: this)
              @expanded = false
          )

        amountOfDevices: (deviceId) ->
          @cartItems.amountOfDevices(deviceId)

      class OnOff.Models.CartItem extends OnOff.Models.Base
        initialize: ->
          @device = new OnOff.Models.Device(@device, cartItem: this)

        amountOfDevices: (deviceId) ->
          if @device.id is deviceId then @amount else 0

      class OnOff.Collections.CartItems extends OnOff.Collections.Base
        model: OnOff.Models.CartItem

        amountOfDevices: (deviceId) ->
          this.reduce(
            (amount, cartItem) ->
              amount + cartItem.amountOfDevices(deviceId)
            0
          )

      class OnOff.Models.Device extends OnOff.Models.Base
      class OnOff.Collections.Devices extends OnOff.Models.Base
        model: OnOff.Models.Device

      class OnOff.Models.Series extends OnOff.Models.Base
        initialize: ->
          @parameters = new OnOff.Collections.Parameters(
            @parameters
            series: this
            cart:   @options.cart
          )

          @skus = new OnOff.Collections.SKU(@skus, series: this)

        price: ->
          @skus.price(@parameters, @options.cart)

        toJSON: ->
          attrs = super

          delete attrs.title
          delete attrs.manufacturer

          attrs

      class OnOff.Collections.Series extends OnOff.Collections.Base
        model: OnOff.Models.Series

      class OnOff.Models.Parameter extends OnOff.Models.Base
        initialize: ->
          @values = new OnOff.Collections.Values(
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

      class OnOff.Collections.Parameters extends OnOff.Collections.Base
        model: OnOff.Models.Parameter

      class OnOff.Models.Value extends OnOff.Models.Base
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

      class OnOff.Collections.Values extends OnOff.Collections.Base
        model: OnOff.Models.Value

        selectedValue: ->
          this.findWhere(selected: true)

        selectedValueId: ->
          this.selectedValue().id

        unselect: ->
          model.unselect() for model in @models

      class OnOff.Models.SKU extends OnOff.Models.Base
        initialize: ->
          @skuParameters = new OnOff.Collections.SkuParameters(this.parameters, sku: this)

        price: (parameters, cart) ->
          price = if @unitPrice > 0 and @skuParameters.size() > 0 then @unitPrice else @skuParameters.price(parameters)

          price * @amount * cart.amountOfDevices(@deviceId)

      class OnOff.Collections.SKU extends OnOff.Collections.Base
        model: OnOff.Models.SKU

        price: (parameters, cart) ->
          this.reduce(
            (price, model) ->
              price + model.price(parameters, cart)
            0
          )

      class OnOff.Models.SkuParameter extends OnOff.Models.Base
        initialize: ->
          @skuValues = new OnOff.Collections.SkuValues(this.values, parameter: this)

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

      class OnOff.Collections.SkuParameters extends OnOff.Collections.Base
        model: OnOff.Models.SkuParameter

        price: (parameters) ->
          this.reduce(
            (price, model) ->
              price + model.price(parameters)
            0
          )

      class OnOff.Models.SkuValue extends OnOff.Models.Base

      class OnOff.Collections.SkuValues extends OnOff.Collections.Base
        model: OnOff.Models.SkuValue

        get: (valueId) ->
          this.findWhere(valueId: valueId)
  ]