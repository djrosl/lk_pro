angular.module 'frontend'
  .controller 'OrdersController', ($timeout, $state, $rootScope) ->
    'ngInject'
    vm = this
    vm.mainMenuActive = 'orders'

    return
