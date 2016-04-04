angular.module 'frontend'
  .directive 'tooltip', ->
    {
      restrict: 'E'
      templateUrl: 'app/components/tooltip/tooltip.html'
      scope:
        content: "="
      transclude: false
      controller: 'TooltipController'
      controllerAs: 'tooltip'
    }