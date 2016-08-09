angular.module 'frontend'
  .controller 'PaymentController', (activeLink) ->
    'ngInject'
    vm = this

    activeLink.setLink ''

    vm.form = {}

    return
