angular.module 'frontend'
  .config ($logProvider, $locationProvider) ->
    'ngInject'
    # Enable log
    $locationProvider.html5Mode true
    $logProvider.debugEnabled true
