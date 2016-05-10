angular.module 'frontend'
  .filter 'pagination', (limitToFilter)->
    (items, per, page)->
      page = page || 0
      per = per || 10

      return limitToFilter(items, per, page*per)
  .filter 'range', ->
    (input, total) ->
      total = parseInt(total)
      i = 0
      while i < total
        input.push i
        i++
      input
      