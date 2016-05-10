angular.module 'frontend'
  .controller 'PaymentHistoryController', ($scope, $http, apiroot) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'history'

    $http.get apiroot+'/api/payment-history'
    .success (s)->
      vm.data = s

    return
