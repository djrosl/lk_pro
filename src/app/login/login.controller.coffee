angular.module 'frontend'
  .controller 'LoginController', ($timeout, $http, $window, $state, apiroot) ->
    'ngInject'
    vm = this

    if $window.sessionStorage.access_token
      $state.go 'orders.current'

    vm.loginForm = ->
      vm.submitted = true
      vm.error = {}
      console.log vm.userModel
      req =
        url: apiroot+'/api/login'
        data: vm.userModel
        method: 'post'
      $http(req)
      .success((data) ->
        $window.sessionStorage.access_token = data.access_token
        $state.go 'orders'
      ).error (data) ->
        console.log data
        angular.forEach data, (error) ->
          vm.error[error.field] = error.message
    vm.registerForm = ->
      vm.submitted = true
      vm.registerError = {}
      console.log vm.registerModel
      req =
        url: apiroot+'/api/register'
        data: vm.registerModel
        method: 'post'
      $http(req)
      .success((data) ->
        $window.sessionStorage.access_token = data.access_token
        $state.go 'add'
      ).error (data) ->
        console.log data
        angular.forEach data, (error) ->
          vm.registerError[error.field] = error.message




    vm.vegasConfig =
      slides: [
        {
          src: '/assets/images/bg.png'
        },
        {
          src: 'http://lorempixel.com/1000/1000/nature'
        },
        {
          src: 'http://lorempixel.com/1000/1000/people'
        }
      ]
      delay:7500
      animationDuration:12500
      shuffle:false
      transition: [ 'fade2', 'fade2', 'fade2', 'fade2' ]
      animation:'kenburns'
      timer:false




    return
