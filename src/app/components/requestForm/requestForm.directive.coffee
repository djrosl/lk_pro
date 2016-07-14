angular.module 'frontend'
  .directive 'requestForm', ->
    {
      restrict: 'AE'
      scope:
        slug: '@'
        reorder: '='
      templateUrl: 'app/components/requestForm/requestForm-template.html'
      controller: 'RequestFormController'
      controllerAs: 'form'
    }