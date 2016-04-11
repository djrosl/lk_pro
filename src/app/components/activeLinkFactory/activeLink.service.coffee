angular.module 'frontend'
  .factory 'activeLink', ->
    link = ''
    {
      getLink: ->
        link
      setLink: (newLink) ->
        link = newLink
        return
    }
