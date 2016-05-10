angular.module 'frontend'
  .controller 'HelpController', ($timeout, $state, $rootScope, $stateParams, activeLink, $http, apiroot, $filter, $sce) ->
    'ngInject'
    vm = this
    activeLink.setLink 'help'

    $http.get apiroot+'/api/main-help'
    .success (s)->
      vm.mainHelp = s
      vm.mainHelp.text = $sce.trustAsHtml vm.mainHelp.text

    $http.get apiroot+'/api/help'
    .success (s)->
      vm.data = s
    vm.getHelp = (id)->
      $http.get apiroot+'/api/help?id='+id
      .success (s)->
        vm.openHelp s
    vm.openHelp = (content)->
      vm.popupContent = $sce.trustAsHtml content.text
      vm.showPopup = 1
    return
