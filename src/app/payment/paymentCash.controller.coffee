angular.module 'frontend'
  .controller 'PaymentCashController', ($scope) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'cash'

    return
