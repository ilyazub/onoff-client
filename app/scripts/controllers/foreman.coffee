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
    'SeriesSvc'
    'DeviceSeriesSvc'
    'SKUsSvc'
    'DeviceSeriesSKUsSvc'
    'ParametersSvc'
    'ValuesSvc'
    ($scope, $http, Restangular, Carts, Devices, CartItems, Series, DeviceSeries, SKUs, DeviceSeriesSKUs, Parameters, Values) ->
      initializeDevices = (devices) ->
        $scope.devices = devices

      initializeCart = (cart) ->
        $scope.cart = cart
        $scope.cartItems = new CartItems(service: $scope.cart.cartItems)
        $scope.newCart = new OnOff.Models.Cart(id: cart.id)

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

        loadSeries: ->
          $http.get("http://localhost:9292/carts/#{@id}/series")
          .then(
            (response) =>
              @series = new OnOff.Collections.Series(response.data, cart: this)
              @expanded = false
          )

      class OnOff.Models.Series extends OnOff.Models.Base
        initialize: ->
          @parameters = new OnOff.Collections.Parameters(
            @parameters
            series: this
            cart: @options.cart
          )

          @skus = new OnOff.Collections.SKU(@skus, series: this)

        price: ->
          @skus.price(@parameters)

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
          $http.put("http://localhost:9292/carts/#{@options.cart.id}/values", angular.toJson(this))


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

        price: (parameters) ->
          price = if @unitPrice then @unitPrice else @skuParameters.price(parameters)

          price * @amount

      class OnOff.Collections.SKU extends OnOff.Collections.Base
        model: OnOff.Models.SKU

        price: (parameters) ->
          this.reduce(
            (price, model) ->
              price + model.price(parameters)
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


      seriesList = [
        {
          id: 1
          title: 'Axcent'
          manufacturer:
            title: 'ABB'
            country: 'Германия'
            assembly: 'Busch-Jaeger'
          deviceGroups: [
            {
              id: 1
              title: 'Frames'
              parameters: [
                {
                  id: 1
                  variable: 'X1'
                  description: 'Цвет'
                  values: [
                    { id: 1, code: '280', description: 'Белый', selected: true }
                    { id: 2, code: '281', description: 'Светло серый', selected: false }
                    { id: 3, code: '282', description: 'Чёрный', selected: false }
                  ]
                }
                {
                  id: 2
                  variable: 'X2'
                  description: 'Форма'
                  values: [
                    { id: 4, code: 'RND', description: 'Закруглённые углы', selected: true }
                    { id: 5, code: 'PNT', description: 'Заострённые углы', selected: false }
                  ]
                }
              ]
              skus: [
                { title: '87BC6', unitPrice: 35, amount: 2, parameters: [] }
                { title: '123-B', unitPrice: 4.35, amount: 1, parameters: [] }
                {
                  title: '7075-X1', amount: 1, parameters: [
                    {
                      parameterId: 1
                      values: [
                        { valueId: 1, unitPrice: 23.25 }
                        { valueId: 2, unitPrice: 16.25 }
                        { valueId: 3, unitPrice: 27.5 }
                      ]
                    }
                  ]
                }
                {
                  title: '1095-X1', amount: 2, parameters: [
                    {
                      parameterId: 1
                      values: [
                        { valueId: 1, unitPrice: 3.25 }
                        { valueId: 2, unitPrice: 10.25 }
                        { valueId: 3, unitPrice: 25.5 }
                      ]
                    }
                  ]
                }
                {
                  title: '4376-X2', amount: 1, parameters: [
                    {
                      parameterId: 2
                      values: [
                        { valueId: 4, unitPrice: 50.25 }
                        { valueId: 5, unitPrice: 100.25 }
                      ]
                    }
                  ]
                }
              ]
            }
            {
              id: 2
              title: 'Sockets'
              parameters: [
                {
                  id: 3
                  variable: 'Y1'
                  description: 'Цвет'
                  values: [
                    { id: 6, code: '283', description: 'Белый', selected: true }
                    { id: 7, code: '284', description: 'Светло серый', selected: false }
                    { id: 8, code: '285', description: 'Чёрный', selected: false }
                    { id: 9, code: '286', description: 'Слоновая кость', selected: false }
                  ]
                }
                {
                  id: 1
                  variable: 'X1'
                  description: 'Цвет'
                  values: [
                    { id: 106, code: '283', description: 'Белый', selected: false }
                    { id: 107, code: '284', description: 'Светло серый', selected: false }
                    { id: 108, code: '285', description: 'Чёрный', selected: false }
                    { id: 109, code: '286', description: 'Слоновая кость', selected: true }
                  ]
                }
              ]
              skus: [
                { title: '2051-A', unitPrice: 20.35, amount: 1, parameters: [] }
                {
                  title: '7075-Y1', amount: 1, parameters: [
                    {
                      parameterId: 3
                      values: [
                        { valueId: 6, unitPrice: 23.25 }
                        { valueId: 7, unitPrice: 16.25 }
                        { valueId: 8, unitPrice: 27.5 }
                        { valueId: 9, unitPrice: 33.0 }
                      ]
                    }
                  ]
                }
                {
                  title: '1095-Y1 / 2006 X1', amount: 2, parameters: [
                    {
                      parameterId: 3
                      values: [
                        { valueId: 6, unitPrice: 3.25 }
                        { valueId: 7, unitPrice: 10.25 }
                        { valueId: 8, unitPrice: 25.5 }
                        { valueId: 9, unitPrice: 12.10 }
                      ]
                    }
                    {
                      parameterId: 1
                      values: [
                        { valueId: 106, unitPrice: 11.5 }
                        { valueId: 107, unitPrice: 90.75 }
                        { valueId: 108, unitPrice: 30 }
                        { valueId: 109, unitPrice: 18 }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          id: 2
          title: 'Basic 55'
          manufacturer:
            title: 'ABB'
            country: 'Германия'
            assembly: 'Busch-Jaeger'
          deviceGroups: [
            {
              id: 1
              title: 'Frames'
              parameters: [
                {
                  id: 1
                  variable: 'X1'
                  description: 'Цвет'
                  values: [
                    { id: 10, code: '870', description: 'Оранжевый', selected: false }
                    { id: 11, code: '871', description: 'Светло серый', selected: true }
                    { id: 12, code: '872', description: 'Чёрный', selected: false }
                  ]
                }
              ]
              skus: [
                { title: '7600-F', unitPrice: 11.35, amount: 2, parameters: [] }
                { title: 'OO92-AA', unitPrice: 35, amount: 1, parameters: [] }
                {
                  title: '7075-X1', amount: 1, parameters: [
                    {
                      parameterId: 1
                      values: [
                        { valueId: 10, unitPrice: 15.25 }
                        { valueId: 11, unitPrice: 34.25 }
                        { valueId: 12, unitPrice: 22.5 }
                      ]
                    }
                  ]
                }
              ]
            }
            {
              id: 2
              title: 'Sockets'
              parameters: [
                {
                  id: 3
                  variable: 'Y1'
                  description: 'Цвет'
                  values: [
                    { id: 13, code: '45A', description: 'Серебрянный', selected: true }
                    { id: 14, code: '46A', description: 'Светло-серый', selected: false }
                    { id: 15, code: '47A', description: 'Чёрный', selected: false }
                    { id: 16, code: '48A', description: 'Коричневый', selected: false }
                    { id: 17, code: '49A', description: 'Рог носорога', selected: false }
                  ]
                }
                {
                  id: 4
                  variable: 'Y2'
                  description: 'Форма'
                  values: [
                    { id: 18, code: 'RND', description: 'Закруглённые углы', selected: true }
                    { id: 19, code: 'PNT', description: 'Заострённые углы', selected: false }
                  ]
                }
              ]
              skus: [
                { title: '98JJ-2014', unitPrice: 14.35, amount: 2, parameters: [] }
                {
                  title: '1095-Y1', amount: 2, parameters: [
                    {
                      parameterId: 3
                      values: [
                        { valueId: 13, unitPrice: 3.25 }
                        { valueId: 14, unitPrice: 11.25 }
                        { valueId: 15, unitPrice: 25.5 }
                        { valueId: 16, unitPrice: 25.5 }
                        { valueId: 17, unitPrice: 25.5 }
                      ]
                    }
                  ]
                }
                {
                  title: '7075-Y1', amount: 1, parameters: [
                    {
                      parameterId: 3
                      values: [
                        { valueId: 13, unitPrice: 23.25 }
                        { valueId: 14, unitPrice: 16.2 }
                        { valueId: 15, unitPrice: 27.5 }
                        { valueId: 16, unitPrice: 17.53 }
                        { valueId: 17, unitPrice: 14.25 }
                      ]
                    }
                  ]
                }
                {
                  title: '1095-Y1', amount: 2, parameters: [
                    {
                      parameterId: 3
                      values: [
                        { valueId: 13, unitPrice: 31.25 }
                        { valueId: 14, unitPrice: 12.25 }
                        { valueId: 15, unitPrice: 19.5 }
                        { valueId: 16, unitPrice: 18.5 }
                        { valueId: 17, unitPrice: 20.5 }
                      ]
                    }
                  ]
                }
                {
                  title: '4376-Y2', amount: 1, parameters: [
                    {
                      parameterId: 4
                      values: [
                        { valueId: 18, unitPrice: 80.25 }
                        { valueId: 19, unitPrice: 67.25 }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
  ]