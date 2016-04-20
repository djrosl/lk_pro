angular.module 'frontend'
  .controller 'OrdersCurrentController', ($scope, $http, apiroot) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'current'

    $http.get(apiroot+'/api/user-orders')
    .success (s)->
      vm.data = s
    
    return
