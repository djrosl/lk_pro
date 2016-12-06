angular.module 'frontend'
  .directive 'ordersTable', (apiroot, $http, balance)->
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

        scope.needMoney = (array)->
          #DEVEL
          #return false
          #\\DEVEL
          out = 0
          angular.forEach array, (item)->

            if parseInt(item.payed) is 0
              console.log 'hui'
              out+=parseInt(item.button.price)
          out = out-balance.getBalance() if out isnt 0
          out

        scope.showArchive = (orderbuttons)->
          out = true
          angular.forEach orderbuttons, (item)->
            if item.status isnt '3' and item.status isnt '2'
              out = false
          return out

        scope.showCancel = (orderbuttons)->
          out = true
          angular.forEach orderbuttons, (item)->
            if item.status isnt '0' and item.status isnt '4'
              out = false
          return out


        scope.pagination =
          current: 0
          per: 10

        scope.pagination.to = (index)->
          scope.pagination.current = index
        scope.pagination.next = ->
          return false if parseInt(scope.pagination.current)+1 > (scope.pagination.pages-1)
          scope.pagination.current = parseInt(scope.pagination.current)+1
        scope.pagination.prev = ->
          return false if scope.pagination.current-1 < 0
          scope.pagination.current = parseInt(scope.pagination.current)-1
        scope.$watch 'data', (newVal)->
          if newVal
            scope.pagination.pages = Math.ceil(newVal.length/scope.pagination.per)

        scope.changeStatus = (order, status)->
          $http.post(apiroot+'/api/change-order-status', {id: order.id, status: status})
          .success (s)->
            console.log s
            ###if(typeof s == 'integer') {
            }###
            ind = _.findIndex scope.data, order
            scope.data.splice ind, 1
            scope.pagination.pages = Math.ceil(scope.data.length/scope.pagination.per)
          return true
    }