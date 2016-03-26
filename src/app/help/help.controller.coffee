angular.module 'frontend'
  .controller 'HelpController', ($timeout, $state, $rootScope, $stateParams) ->
    'ngInject'
    vm = this
    vm.mainMenuActive = 'help'

    return
