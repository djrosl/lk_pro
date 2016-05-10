angular.module 'frontend'
  .controller 'RequestFormController', ($scope, $http, $timeout, apiroot, $filter, FileUploader, $window, $state, balance) ->
    'ngInject'
    vm = this

    vm.passport = {}

    $scope.$watch ->
      vm.orderCost
    , (newVal, oldVal)->
      if newVal > balance.getBalance()
        vm.showWarning = true
      else vm.showWarning = false


    submitOrder = ->
      if vm.showWarning
        alert 'На вашем счету недостаточно средств!'
        return false
      if !vm.order
        alert 'Выберите базы для проверки'
        return false
      if !vm.orderName
        alert 'Введите название заказа'
        return false
      data =
        sub: vm.subfields
        order: vm.order
        cost: vm.orderCost
        base_type: vm.base_type
        name: vm.orderName
      $http.post apiroot+'/api/order', data
      .error (e)->
        console.log e
      .success (s)->
        console.log s
        balance.setBalance s
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
      _.findIndex(vm.order, obj)

    vm.countToggle = (obj)->
      index = vm.counted obj
      if index < 0
        vm.order.push obj
        vm.orderCost+=(+obj.price)
      else
        vm.order.splice index, 1
        vm.orderCost-=obj.price

    uploader = $scope.uploader = new FileUploader
      url: apiroot+'/api/add-passport-photo'
      alias: 'images'
      headers:
        Authorization: 'Bearer ' + $window.sessionStorage.access_token
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

    submitPass = ->
      if vm.passport
        vm.formErrors = []
        $http.get(apiroot+'/api/dashboard')
        .error (e)->
          console.log e
        .success (s)->
          vm.passport.user_id = s.id
          req =
            method: 'POST'
            data: vm.passport
            url: apiroot+'/api/add-passport'
          $http(req)
          .success (s)->
            console.log s
            uploader.uploadAll()
          .error (e)->
            console.log e
            vm.formErrors = _.indexBy e, 'field'
      else return true

    return
