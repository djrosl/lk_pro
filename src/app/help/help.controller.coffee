angular.module 'frontend'
  .controller 'HelpController', ($timeout, $state, $rootScope, $stateParams, activeLink) ->
    'ngInject'
    vm = this
    activeLink.setLink 'help'

    return
