angular.module 'frontend'
  .controller 'AddIndividualController', ($timeout, $scope, $http, apiroot) ->
    'ngInject'
    vm = this
    
    $scope.$parent.activeTab = 'individual'

    $http.get apiroot+'/database-types/1'
    .success (data)->
      vm.header = data.show_title
      vm.icon_class = "fa fa-"+data.icon_class


    return
