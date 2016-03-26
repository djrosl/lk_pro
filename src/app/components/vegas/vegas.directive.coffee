angular.module 'frontend'
  .directive 'vegas', ->
    {
      restrict: 'A'
      replace: true
      scope:
        vegas: "=vegas"
      link: (scope, elem, attrs) ->
        console.log(scope.vegas)
        $('.login-wrapper').vegas scope.vegas
    }
