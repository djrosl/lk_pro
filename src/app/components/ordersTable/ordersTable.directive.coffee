angular.module 'frontend'
  .directive 'ordersTable', ->
    {
      restrict: 'AE'
      scope:
        data: '=data'
      templateUrl: 'app/components/ordersTable/ordersTable.html'
      link: (scope, element, attrs) ->
        console.log(scope.data)
    }