angular.module 'frontend'
  .controller 'PaymentCashController', ($scope, FileUploader, apiroot, $http, $state) ->
    'ngInject'
    vm = this

    date = new Date()
    vm.form = {
      date: new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes())
    }

    vm.uploader = new FileUploader
      url: apiroot+'/api/file-check'
      onAfterAddingFile: (item)->
        vm.form.check = true
      onCompleteItem: (item, response)->
        vm.form.check = item.file.name

        $http.post apiroot+'/api/payment-add', vm.form
        .success (s)->
          console.log s
          vm.processFormHide = 0
          alert 'Форма отправлена! В ближайшее время мы проверим поступление средств.'
          $state.go 'orders.current'
        .error (e)->
          console.log e

    vm.processForm = ->
      if !vm.form.summ or !vm.form.check or !vm.form.date or !vm.form.cash_type
        alert 'Заполните все поля!'
        return false

      vm.processFormHide = 1
      vm.uploader.uploadItem(0)


    $scope.$parent.activeTab = 'cash'

    return
