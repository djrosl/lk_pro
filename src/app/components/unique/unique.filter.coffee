angular.module 'frontend'
  .filter 'unique', ->
    (items, filterOn) ->
      out = _.uniq items, (item)->
        item.id
      console.log out
      out