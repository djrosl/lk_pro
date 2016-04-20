angular.module 'frontend'
  .directive 'ordersTable', (apiroot, $http)->
    {
      restrict: 'AE'
      scope:
        data: '=data'
        type: '@type'
      templateUrl: 'app/components/ordersTable/ordersTable.html'
      link: (scope, element, attrs) ->
        scope.openDoc = (filename)->
          if filename
            window.open apiroot+'/api/file?path='+filename
          else return false
          return true
        scope.changeStatus = (order, status)->
          $http.post(apiroot+'/api/change-order-status', {id: order.id, status: status})
          .success (s)->
            console.log s
            ind = _.findIndex scope.data, order
            scope.data.splice ind, 1
          return true
    }