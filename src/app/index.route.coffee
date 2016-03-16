angular.module 'frontend'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/dashboard'
        templateUrl: 'app/main/main.html'
        controller: 'MainController'
        controllerAs: 'main'
      .state 'login',
        url: '/'
        templateUrl: 'app/login/login.html'
        controller: 'LoginController'
        controllerAs: 'login'

    $urlRouterProvider.otherwise '/'
