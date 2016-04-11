angular.module 'frontend'
  .controller 'AddController', ($timeout, $state, $rootScope, $stateParams, $http, $scope, activeLink, apiroot) ->
    'ngInject'
    vm = this
    activeLink.setLink 'add'
    
    $http.get apiroot+'/database-type?fields=id,show_title,icon_class,slug'
    .success (data)->
      for value in data
        value.icon_class = 'fa fa-'+value.icon_class
      vm.types = data
      vm.activeSlug = data[0].slug

    return
