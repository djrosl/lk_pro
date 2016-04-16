angular.module 'frontend'
  .filter 'imageFilter', ->
    (val)->
      'http://api.lkpro.acrux.tk'+val