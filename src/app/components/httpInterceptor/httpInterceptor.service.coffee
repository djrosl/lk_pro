angular.module 'frontend'
  .factory('httpInterceptor', ['$q','$rootScope', ($q, $rootScope) ->
    loadingCount = 0
    {
      request: (config) ->
        if ++loadingCount == 1
          $rootScope.$broadcast 'loading:progress'
        config or $q.when(config)
      response: (response) ->
        if --loadingCount == 0
          $rootScope.$broadcast 'loading:finish'
        response or $q.when(response)
      responseError: (response) ->
        if --loadingCount == 0
          $rootScope.$broadcast 'loading:finish'
        $q.reject response

    }
]).config ['$httpProvider', ($httpProvider) ->
    $httpProvider.interceptors.push 'httpInterceptor'
    return
]
