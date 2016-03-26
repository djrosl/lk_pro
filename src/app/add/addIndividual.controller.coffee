angular.module 'frontend'
  .controller 'AddIndividualController', ($timeout, $scope) ->
    'ngInject'
    vm = this
    
    $scope.$parent.activeTab = 'individual'

    return
