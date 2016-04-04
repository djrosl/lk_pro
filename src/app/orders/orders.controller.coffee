angular.module 'frontend'
  .controller 'OrdersController', ($timeout, $state, $rootScope, $http) ->
    'ngInject'
    vm = this
    vm.mainMenuActive = 'orders'


    $http.get('http://lkpro.loc/api/dashboard').success (data)->
      vm.dashboard = data

    return
