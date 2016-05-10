angular.module 'frontend'
  .controller 'HeaderController', ($http, $sce, activeLink, $scope, apiroot, $window, $state, balance) ->
    'ngInject'
    vm = this

    vm.logout = ->
      $window.sessionStorage.removeItem('access_token')
      $state.go 'login'


    $scope.$watch ->
      activeLink.getLink()
    , (nVal, oVal)->
      vm.activeLink = nVal if nVal isnt oVal

    vm.columns = []
    $http.get(apiroot+'/header/')
    .success (data)->
      vm.columns = [
        $sce.trustAsHtml(data[0].column_1),
        $sce.trustAsHtml(data[0].column_2),
        $sce.trustAsHtml(data[0].column_3)
      ]

    $scope.$watch ->
      balance.getBalance()
    , (newVal)->
      
      vm.balance = newVal

    $http.get(apiroot+'/api/dashboard')
    .success (data)->
      vm.user = data
      balance.setBalance data.balance

    return
