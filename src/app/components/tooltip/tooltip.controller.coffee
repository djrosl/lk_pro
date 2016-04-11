angular.module 'frontend'
  .controller 'TooltipController', ($scope, $sce, $element, $timeout) ->
    'ngInject'
    vm = this
    vm.help = $sce.trustAsHtml $scope.content.help
    vm.example = $sce.trustAsHtml $scope.content.example
    vm.time = $sce.trustAsHtml $scope.content.time

    $timeout ()->
      if $element.offset().left > window.innerWidth/2
        console.log 1
        vm.classLeft = 1
      else
        console.log 0
        vm.classLeft = 0
      console.log $element.offset().left, window.innerWidth/2
    ,1500,true
    
    return
