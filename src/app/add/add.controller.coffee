angular.module 'frontend'
  .controller 'AddController', ($timeout, $state, $rootScope, $stateParams) ->
    'ngInject'
    vm = this
    vm.mainMenuActive = 'add'

    return
