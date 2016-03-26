angular.module 'frontend'
  .directive 'dashboardHeader', ->
    {
      restrict: 'E'
      templateUrl: 'app/header/header.html'
      scope: true
      transclude: false
      controller: 'HeaderController'
      controllerAs: 'header'
    }