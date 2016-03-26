angular.module 'frontend'
  .controller 'PaymentAutoController', ($scope) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'auto'

    return
