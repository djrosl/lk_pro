angular.module 'frontend'
  .controller 'RequestFormController', ($scope, $http, $timeout, apiroot, $filter, FileUploader, $window) ->
    'ngInject'
    vm = this

    vm.passport = {}
    $http.get(apiroot+'/api/dashboard')
    .error (e)->
      console.log e
    .success (s)->
      s.passport.own_birthdate = new Date(s.passport.own_birthdate)
      s.passport.pass_get = new Date(s.passport.pass_get)
      vm.passport = s.passport

    submitOrder = ->
      return true

    vm.submitForm = ->
      #submitPass()
      submitOrder()


    vm.orderCost = 0
    vm.order = []
    vm.counted = (obj)->
      $filter('filter')(vm.order, obj).length

    vm.countToggle = (obj)->
      if !vm.counted obj
        vm.order.push obj
        vm.orderCost+=(+obj.price)
      else
        index = _.findIndex(vm.order, obj)
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
