angular.module 'frontend'
  .controller 'OrdersController', ($timeout, $state, $rootScope, $http, activeLink) ->
    'ngInject'
    vm = this
    activeLink.setLink 'orders'


    $http.get('http://lkpro.loc/api/dashboard').success (data)->
      vm.dashboard = data

    return
