angular.module 'frontend'
  .filter 'imageFilter', ->
    (val)->
      'http://admin.lkpro.acrux.tk'+val