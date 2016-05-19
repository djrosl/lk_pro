angular.module 'frontend'
  .config ($stateProvider, $urlRouterProvider, $httpProvider) ->
    'ngInject'
    $stateProvider
      .state 'orders',
        url: '/orders'
        templateUrl: 'app/orders/orders.html'
        controller: 'OrdersController'
        controllerAs: 'orders'
      .state 'orders.current',
        url: '/current'
        templateUrl: 'app/orders/orders-current.html'
        controller: 'OrdersCurrentController'
        controllerAs: 'current'
      .state 'orders.archive',
        url: '/archive'
        templateUrl: 'app/orders/orders-archive.html'
        controller: 'OrdersArchiveController'
        controllerAs: 'archive'
      .state 'add',
        url: '/add/'
        templateUrl: 'app/add/add.html'
        controller: 'AddController'
        controllerAs: 'add'
      .state 'reorder',
        url: '/reorder/:id'
        templateUrl: 'app/add/add.html'
        controller: 'AddReorderController'
        controllerAs: 'add'
      .state 'help',
        url: '/help'
        templateUrl: 'app/help/help.html'
        controller: 'HelpController'
        controllerAs: 'help'
      .state 'payment',
        url: '/payment'
        templateUrl: 'app/payment/payment.html'
        controller: 'PaymentController'
        controllerAs: 'payment'
      .state 'payment.auto',
        url: '/auto'
        templateUrl: 'app/payment/payment-auto.html'
        controller: 'PaymentAutoController'
        controllerAs: 'auto'
      .state 'payment.cash',
        url: '/cash'
        templateUrl: 'app/payment/payment-cash.html'
        controller: 'PaymentCashController'
        controllerAs: 'cash'
      .state 'payment.history',
        url: '/history'
        templateUrl: 'app/payment/payment-history.html'
        controller: 'PaymentHistoryController'
        controllerAs: 'history'
      .state 'settings',
        url: '/settings'
        templateUrl: 'app/settings/settings.html'
        controller: 'SettingsController'
        controllerAs: 'settings'
      .state 'login',
        url: '/'
        templateUrl: 'app/login/login.html'
        controller: 'LoginController'
        controllerAs: 'login'

    $urlRouterProvider.otherwise '/'
    $httpProvider.interceptors.push 'authInterceptor'
