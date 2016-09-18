angular.module 'frontend'
  .controller 'RequestFormController',
  ($scope, $http, $timeout, apiroot, $filter, FileUploader, $window, $state, balance, SweetAlert, moment, regions) ->
    'ngInject'
    vm = this

    vm.regions = regions

    vm.openurl = (url)->
      window.open url, '_blank'

    vm.passport = {}
    orderID = 0
    $scope.$watch ->
      vm.orderCost
    , (newVal, oldVal)->
      if newVal > balance.getBalance()
        vm.showWarning = true
      else vm.showWarning = false

    submitOrder = ->
      exited = false
      $('.order-fields [required]').each ()->
        if !$(this).val() or $(this).val() is '? undefined:undefined ?'
          SweetAlert.swal
            title: 'Заполните поля'
            timer: 2000
          exited = true
      if !vm.order
        SweetAlert.swal
          title: 'Выберите базы для проверки'
          timer: 2000
        exited = true

      return false if exited

      ord = angular.copy vm.order
      angular.forEach ord, (order)->
        angular.forEach order.fields, (field, k)->
          delete field.uploader if field.uploader

      data =
        sub: vm.subfields
        order: ord
        cost: vm.orderCost
        base_type: vm.base_type
        name: vm.orderName

      data.reorder = vm.reorder if vm.reorder
      $http.post apiroot+'/api/order', data
      .error (e)->
        console.log e
      .success (s)->
        orderID = s.id
        console.log s
        balance.setBalance s.balance
        $state.go 'orders.current'

    vm.explode = (del, arr)->
      arr.split(del)

    vm.submitForm = ->
      #submitPass()
      submitOrder()


    vm.orderCost = 0
    vm.order = []
    vm.subfields = {}
    vm.counted = (obj)->
      _.findIndex vm.order, (item)->
        obj.id is item.id

    mergeByProperty = (arr1, arr2, prop) ->
      _.each arr2, (arr2obj) ->
        arr1obj = _.find(arr1, (arr1obj) ->
          arr1obj[prop] == arr2obj[prop]
        )
        if arr1obj then _.extend(arr1obj, arr2obj) else arr1.push(arr2obj)
        return
      return

    vm.countToggle = (obj)->
      index = vm.counted obj
      if index < 0
        vm.order.push obj
        vm.orderCost+=(+obj.price)
      else
        vm.order.splice index, 1
        vm.orderCost-=obj.price

      vm.fieldsMerged = []
      vm.requiredFields = []
      angular.forEach vm.order, (v)->
        console.log v.fields, vm.fieldsMerged
        mergeByProperty vm.fieldsMerged, v.fields, 'id'

        angular.forEach v.bfields, (s)->
          if vm.requiredFields[s.field_id]
            if s.required
              vm.requiredFields[s.field_id] = parseInt(s.required)
          else if !vm.requiredFields[s.field_id]
            if s.required
              vm.requiredFields[s.field_id] = parseInt(s.required)
        #vm.isRequired(v.id)


    $scope.$watch 'slug', (newVal, oldVal)->
      if newVal? and newVal isnt oldVal
        vm.type = {}
        vm.loaded = vm.orderCost = 0
        $http.get apiroot+'/database-type/search?slug='+$scope.slug+'&expand=sections,databases,buttons'
          .success (data)->
            vm.type = data
            vm.type.icon_class = 'fa fa-'+data.icon_class
            vm.base_type = data.id
            $timeout ()->
              vm.loaded = 1
            ,200,false

    $scope.$watch 'reorder', (reorder)->
      if reorder
        vm.reorder = reorder.model.id
        vm.orderName = reorder.model.title
        vm.subfields = []
        angular.forEach reorder.fields, (v)->
          if parseInt(v.field.type) is 3
            console.log v.content
            arr = vm.explode ',', v.content
            vm.subfields[v.field.id] = [moment(arr[0]).format('DD.MM.YYYY'), moment(arr[1]).format('DD.MM.YYYY')]
          else
            vm.subfields[v.field.id] = v.content
        angular.forEach reorder.order_buttons, (v)->
          vm.countToggle v.button

    return
