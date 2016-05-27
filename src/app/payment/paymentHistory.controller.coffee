angular.module 'frontend'
  .controller 'PaymentHistoryController', ($scope, $http, apiroot) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = 'history'

    $http.get apiroot+'/api/payment-history'
    .success (s)->
      vm.data = s
      vm.pagination.pages = Math.ceil(s.length/vm.pagination.per)


    vm.pagination =
      current: 0
      per: 10

    vm.pagination.to = (index)->
      vm.pagination.current = index
    vm.pagination.next = ->
      return false if parseInt(vm.pagination.current)+1 > (vm.pagination.pages-1)
      vm.pagination.current = parseInt(vm.pagination.current)+1
    vm.pagination.prev = ->
      return false if vm.pagination.current-1 < 0
      vm.pagination.current = parseInt(vm.pagination.current)-1

    return
