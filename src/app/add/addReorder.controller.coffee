angular.module 'frontend'
  .controller 'AddReorderController', ($timeout, $state, $rootScope, $stateParams, $http, $scope, activeLink, apiroot) ->
    'ngInject'
    vm = this
    activeLink.setLink 'add'
    
    $http.get apiroot+'/database-type?fields=id,show_title,icon_class,slug'
    .success (data)->
      for value in data
        value.icon_class = 'fa fa-'+value.icon_class
      vm.types = data
      

    $http.get apiroot+'/api/reorder?id='+$stateParams.id
    .success (data)->
      vm.activeSlug = data.base_slug
      vm.reorder = data

    return
