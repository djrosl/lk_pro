angular.module 'frontend'
  .controller 'PaymentCashController', ($scope, FileUploader, apiroot, $http, $state, SweetAlert) ->
    'ngInject'
    vm = this

    date = new Date()
    vm.form = {
      date: ''
    }

    vm.uploader = new FileUploader
      url: apiroot+'/api/file-check'
      onAfterAddingFile: (item)->
        vm.form.check = true
      onCompleteItem: (item, response)->
        vm.form.check = item.file.name
        vm.form.date = new Date vm.form.date
        $http.post apiroot+'/api/payment-add', vm.form
        .success (s)->
          console.log s
          vm.processFormHide = 0
          SweetAlert.swal
            title: 'Форма отправлена! В ближайшее время мы проверим поступление средств.'
            timer: 2000
          $state.go 'orders.current'
        .error (e)->
          console.log e

    vm.processForm = ->
      if !vm.form.summ or !vm.form.check or !vm.form.date or !vm.form.cash_type
        SweetAlert.swal
          title: 'Заполните все поля!'
          timer: 2000
        return false

      vm.processFormHide = 1
      vm.uploader.uploadItem(0)


    $scope.$parent.activeTab = 'cash'

    return
