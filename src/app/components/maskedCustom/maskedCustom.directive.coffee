angular.module 'frontend'
  .directive 'rmask', ->
    {
      restrict: 'A'
      link: (scope, elem, attr, ctrl) ->
        parseDate = (str) ->
          if attr.datetime
            return str.match(/(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3_][0-9_]\.(?!1[3-9]|00)[01_][0-9_]\.(?!10|28|29)[12_][09_][0-9_][0-9_]\s([01_][0-9_]|2[0-3_]):([0-5_][0-9_])/)
          else
            return str.match(/(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3_][0-9_]\.(?!1[3-9]|00)[01_][0-9_]\.(?!10|28|29)[12_][09_][0-9_][0-9_]/)
        
        if attr.rmask
          elem.mask attr.rmask, placeholder: attr.rmaskPlaceholder

          elem.bind 'keydown', (event) ->
            if !parseDate(elem.val())
              event.preventDefault()
              return false
            #debugger
            return
        return

    }