angular.module 'frontend'
  .run ($log, $state, $rootScope) ->
    'ngInject'

    $rootScope.$on '$stateChangeSuccess', (event, toState, params)->
      if toState.controllerAs is 'orders'
        $state.go 'orders.current'
      if toState.controllerAs is 'add'
        $state.go 'add.individual'
      if toState.controllerAs is 'payment'
        $state.go 'payment.auto'
      return
