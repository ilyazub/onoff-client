'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.ValuesSvc
 # @description
 # # ValuesSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'ValuesSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('values', (collection) ->
        collection.unselect = ->
          model.unselect() for model in collection

        collection.getSelected = ->
          _.filter(collection, 'selected_by_default')

        collection.restangularizeNested = (parameter) ->
          parameterCopy = parameter.clone()
          delete parameterCopy.values

          options =
            parameter: parameterCopy
            collection: collection

          model.restangularizeNested(options) for model in collection

          collection

        collection
      )

      Restangular.extendModel('values', (model) ->
        model.toJSON = ->
          clone = model.clone()
          delete clone.collection

          clone

        model.select = ->
          unless model.selected_by_default is true
            model.collection.unselect()
            model.selected_by_default = true

        model.unselect = -> model.selected_by_default = false

        model.restangularizeNested = (options = {}) ->
          model[key] = value for key, value of options

        model
      )

      Restangular.service('values')
  ]