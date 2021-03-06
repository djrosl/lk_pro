angular.module 'frontend'
  .controller 'HeaderController', ($interval, $http, $sce, activeLink, $scope, apiroot, $window, $state, balance, SweetAlert, regions) ->
    'ngInject'
    vm = this

    vm.logout = ->
      $window.sessionStorage.removeItem('access_token')
      $state.go 'login'

    $('body').on 'focusout', 'input[type="date"]', ()->
      if $(this).val() < '1940-01-01' or $(this).val() > '2050-01-01'
        SweetAlert.swal
          title: 'Введите правильную дату!'
          timer: 2000
        return $(this).focus()

    $scope.$watch ->
      activeLink.getLink()
    , (nVal, oVal)->
      vm.activeLink = nVal if nVal isnt oVal

    vm.columns = []
    ###$http.get(apiroot+'/api/header/')
    .success (data)->
      ###

    $scope.$watch ->
      balance.getBalance()
    , (newVal)->

      vm.balance = newVal

    $http.get(apiroot+'/api/dashboard')
    .success (data)->
      vm.user = data
      balance.setBalance data.balance
      angular.forEach data.header, (item)->
        vm.columns.push($sce.trustAsHtml(item.column_1))
      ###vm.columns = [
        $sce.trustAsHtml(data.header[0].column_1),
        $sce.trustAsHtml(data.header[0].column_2),
        $sce.trustAsHtml(data.header[0].column_3)
      ]###

    $interval ()->
      $http.get(apiroot+'/api/dashboard')
      .success (data)->
        vm.user = data
        balance.setBalance data.balance
    , 60000


    return
