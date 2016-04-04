angular.module 'frontend'
  .factory 'authInterceptor', ["$q","$window",'$location', ($q, $window, $location)->
    {
      request: (config) ->
        if $window.sessionStorage.access_token
          #HttpBearerAuth
          config.headers.Authorization = 'Bearer ' + $window.sessionStorage.access_token
        config
      responseError: (rejection) ->
        if rejection.status == 401
          $location.path('/login').replace()
        $q.reject rejection

    }
  ]
