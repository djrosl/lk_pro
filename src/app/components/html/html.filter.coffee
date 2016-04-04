angular.module 'frontend'
  .filter 'html', ($sce)->
    (value)->
      $sce.trustAsHtml value