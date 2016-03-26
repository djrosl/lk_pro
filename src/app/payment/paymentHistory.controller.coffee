angular.module 'frontend'
  .controller 'PaymentHistoryController', ($scope) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'history'

    return
