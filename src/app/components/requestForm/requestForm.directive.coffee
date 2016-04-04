angular.module 'frontend'
  .directive 'requestForm', ->
    {
      restrict: 'AE'
      scope:
        slug: '@'
      templateUrl: 'app/components/requestForm/requestForm.html'
      controller: 'RequestFormController'
      controllerAs: 'form'
    }