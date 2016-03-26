angular.module 'frontend'
  .directive 'dashboardFooter', ->
    {
      restrict: 'E'
      templateUrl: 'app/footer/footer.html'
      scope: true
      transclude: false
      controller: 'FooterController'
      controllerAs: 'footer'
    }