angular.module 'frontend'
  .controller 'HeaderController', ($http, $sce) ->
    'ngInject'
    vm = this

    vm.columns = []
    $http.get('http://lkpro.loc/header/')
    .success (data)->
      vm.columns = [
        $sce.trustAsHtml(data[0].column_1),
        $sce.trustAsHtml(data[0].column_2),
        $sce.trustAsHtml(data[0].column_3)
      ]

    return
