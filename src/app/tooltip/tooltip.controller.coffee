angular.module 'frontend'
  .controller 'TooltipController', ($scope, $sce) ->
    'ngInject'
    vm = this
    vm.help = $sce.trustAsHtml $scope.content.help
    vm.example = $sce.trustAsHtml $scope.content.example
    vm.time = $sce.trustAsHtml $scope.content.time
    return
