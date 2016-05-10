angular.module 'frontend'
  .controller 'SettingsController', ($http, apiroot) ->
    'ngInject'
    vm = this

    vm.formError = []
    $http.get(apiroot+'/api/user-settings')
    .success (s)->
      vm.data = s

    vm.processForm = ->
      $http.post(apiroot+'/api/user-settings', vm.data)
      .success (s)->
        vm.data = s
      .error (e)->
        vm.formError = e

    return
