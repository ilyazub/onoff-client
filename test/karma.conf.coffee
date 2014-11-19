module.exports = (config) ->
  config.set
    # base path, that will be used to resolve files and exclude
    basePath: '../'

    # testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['jasmine']

    # list of files / patterns to load in the browser
    files: [
      'bower_components/jquery/dist/jquery.js'
      'bower_components/angular/angular.js'
      'bower_components/angular-mocks/angular-mocks.js'
      'bower_components/angular-route/angular-route.js'
      'bower_components/lodash/dist/lodash.compat.js'
      'bower_components/restangular/dist/restangular.js'
      'bower_components/ngstorage/ngStorage.js'
      'bower_components/foundation/js/foundation.js'
      'bower_components/angular-dragndrop-object/dist/angular-dragndrop-object.js'
      'bower_components/jquery-waypoints/waypoints.js'
      'bower_components/SHA-1/sha1.js'
      'bower_components/angulartics/src/angulartics.js'
      'bower_components/angulartics/src/angulartics-ga.js'
      'app/scripts/**/*.coffee'
      'test/mock/**/*.coffee'
      'test/spec/**/*.coffee'
    ]

    # list of files / patterns to exclude
    exclude: []

    # web server port
    port: 8080

    # level of logging
    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: [
      'PhantomJS'
    ]

    # Which plugins to enable
    plugins: [
      'karma-phantomjs-launcher'
      'karma-coffee-preprocessor'
      'karma-jasmine'
    ]

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: false

    colors: true

    preprocessors: '**/*.coffee': ['coffee']

    # Uncomment the following lines if you are using grunt's server to run the tests
    # proxies: '/': 'http://localhost:9000/'
    # URL root prevent conflicts with the site root
    # urlRoot: '_karma_'
