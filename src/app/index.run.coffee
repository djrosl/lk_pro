angular.module 'frontend'
  .run ($log, $state, $rootScope, $timeout, $location, $anchorScroll, activeLink) ->
    'ngInject'

    $rootScope.$on '$routeChangeSuccess', (newRoute, oldRoute) ->
      if $location.hash()
        $anchorScroll()

    $rootScope.loaded = false
    $rootScope.$on 'loading:finish', ->
      $timeout ->
        $rootScope.loaded = true
      ,100
    
    $rootScope.$on '$stateChangeSuccess', (event, toState, params)->
      if toState.controllerAs is 'orders'
        $state.go 'orders.current'
      if toState.controllerAs is 'payment'
        $state.go 'payment.auto'
      if toState.controllerAs is 'login'
        $rootScope.loginPage = 1
      else
        $rootScope.loginPage = 0
      return
    return
