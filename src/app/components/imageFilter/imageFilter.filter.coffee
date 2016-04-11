angular.module 'frontend'
  .filter 'imageFilter', ->
    (val)->
      'http://admin.lkpro.loc'+val