'use strict'

describe 'Service: defaultTransferredDataType', ->

  beforeEach module 'onoffClientApp'

  defaultTransferredDataType = {}
  beforeEach inject (_defaultTransferredDataType_) ->
    defaultTransferredDataType = _defaultTransferredDataType_

  it 'equals to default transferred data type', ->
    expect(defaultTransferredDataType).toEquals('json')