angular.module 'frontend'
  .controller 'OrdersController', ($timeout, $state, $rootScope, $http, activeLink, apiroot) ->
    'ngInject'
    vm = this
    activeLink.setLink 'orders'


    $http.get(apiroot+'/api/dashboard').success (data)->
      vm.dashboard = data

    return
