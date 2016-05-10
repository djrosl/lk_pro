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
  .factory 'balance', ->
    balance = ''
    {
      getBalance: ->
        balance
      setBalance: (newBalance) ->
        balance = newBalance
        return
    }
