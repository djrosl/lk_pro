angular.module 'frontend'
  .controller 'OrdersArchiveController', ($timeout, $scope) ->
    'ngInject'
    vm = this
    
    $scope.$parent.activeTab = 'archive'

    return
