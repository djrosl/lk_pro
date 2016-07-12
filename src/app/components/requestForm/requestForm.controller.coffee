angular.module 'frontend'
  .controller 'RequestFormController',
  ($scope, $http, $timeout, apiroot, $filter, FileUploader, $window, $state, balance, SweetAlert, moment, regions) ->
    'ngInject'
    vm = this

    vm.regions = regions

    vm.passport = {}

    $scope.$watch ->
      vm.orderCost
    , (newVal, oldVal)->
      if newVal > balance.getBalance()
        vm.showWarning = true
      else vm.showWarning = false

    submitOrder = ->
      exited = false
      $('.order-fields input[required]').each ()->
        if !$(this).val()
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
      angular.forEach vm.fieldsMerged, (item)->
        if item.type is '4'
          item.uploader.uploadItem(0)
      
      data =
        sub: vm.subfields
        order: vm.order
        cost: vm.orderCost
        base_type: vm.base_type
        name: vm.orderName
      data.reorder = vm.reorder if vm.reorder
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
      _.findIndex vm.order, (item)->
        obj.id is item.id

    mergeByProperty = (arr1, arr2, prop) ->
      _.each arr2, (arr2obj) ->
        arr1obj = _.find(arr1, (arr1obj) ->
          arr1obj[prop] == arr2obj[prop]
        )
        #If the object already exist extend it with the new values from arr2, otherwise just add the new object to arr1
        if arr1obj then _.extend(arr1obj, arr2obj) else arr1.push(arr2obj)
        return
      return


    $scope.$watch ->
      vm.fieldsMerged
    ,(newVal, oldVal)->
      if newVal
        i = 0
        while i < vm.fieldsMerged.length
          if vm.fieldsMerged[i].type is '4'
            vm.fieldsMerged[i].uploader = new FileUploader
              url: apiroot+'/api/add-file-field'
              alias: 'fieldFile'
              removeAfterUpload: true
              queueLimit: 1
              onCompleteItem: (item, response)->
                vm.subfields[response.id] = response.path
              headers:
                Authorization: 'Bearer ' + $window.sessionStorage.access_token
                FieldId: vm.fieldsMerged[i].id
          i++
    
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



    vm.isRequired = (button_id)->
      ###angular.forEach vm.fieldsMerged, (f)->
        $http.get(apiroot+'/api/is-required?button_id='+button_id+'&field_id='+f.id).success (s)->
          if f.required
            if s.required
              f.required = s.required
          else if !f.required
            if s.required
              f.required = s.required###
      return



    return
