angular.module 'frontend'
  .controller 'TooltipController', ($scope, $sce, $element, $timeout) ->
    'ngInject'
    vm = this
    vm.help = $sce.trustAsHtml $scope.content.help
    vm.example = $sce.trustAsHtml $scope.content.example
    vm.time = $sce.trustAsHtml $scope.content.time

    $timeout ()->
      if $element.offset().left > window.innerWidth/2
        vm.classLeft = 1
      else
        vm.classLeft = 0
      console.log $element.offset().left, window.innerWidth/2
    ,0,false
    
    return
