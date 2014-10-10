'use strict'

###*
 # @ngdoc service
 # @name onoffClientApp.ParameterValuesSvc
 # @description
 # # ParameterValuesSvc
 # Service in the onoffClientApp.
###
angular.module('onoffClientApp')
  .service 'ParameterValuesSvc', [
    'Restangular'
    (Restangular) ->
      Restangular.extendCollection('values', (collection) ->
        collection.unselect = ->
          model.unselect() for model in collection

        collection.selectDefault = ->
          if collection.length
            model = _.sample(collection)
            model.select()

        collection.getSelected = ->
          _.filter(collection, 'selected')

        collection.restangularizeNested = (parameter) ->
          parameterCopy = parameter.clone()
          delete parameterCopy.values

          options =
            parameter: parameterCopy
            collection: collection

          model.restangularizeNested(options) for model in collection

          collection.selectDefault()

          collection

        collection
      )

      Restangular.extendModel('values', (model) ->
        model.toJSON = ->
          clone = model.clone()
          delete clone.collection

          clone

        model.select = ->
          unless model.selected is true
            model.collection.unselect()
            model.selected = true

        model.unselect = -> model.selected = false

        model.restangularizeNested = (options = {}) ->
          model[key] = value for key, value of options

        model
      )

      Restangular.service('values')
  ]