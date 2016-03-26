angular.module 'frontend'
  .controller 'LoginController', ($timeout) ->
    'ngInject'
    vm = this
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
