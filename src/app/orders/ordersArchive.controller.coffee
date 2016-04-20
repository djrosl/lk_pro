angular.module 'frontend'
  .controller 'OrdersArchiveController', ($timeout, $scope, $http, apiroot) ->
    'ngInject'
    vm = this
    
    $scope.$parent.activeTab = 'archive'

    $http.get(apiroot+'/api/user-orders?status=4')
    .success (s)->
      vm.data = s

    return
