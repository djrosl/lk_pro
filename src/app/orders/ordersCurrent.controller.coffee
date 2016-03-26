angular.module 'frontend'
  .controller 'OrdersCurrentController', ($scope) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'current'
    
    return
