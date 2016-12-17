angular.module 'frontend'
  .controller 'OrdersDetailsController', ($scope, $http, apiroot, $stateParams, $sce) ->
    'ngInject'
    vm = this

    $scope.$parent.activeTab = ''

    vm.id = $stateParams.id

    $http.get(apiroot+'/api/user-orders?id='+vm.id)
    .success (s)->
      vm.data = s

    vm.images = (field)->
      html=[]
      field.content.split('$')

    return
