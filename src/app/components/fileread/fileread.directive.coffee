angular.module 'frontend'
  .directive 'fileread', [ ->
    {
      scope: fileread: '='
      link: (scope, element, attributes) ->
        element.bind 'change', (changeEvent) ->
          scope.fileread = scope.fileread or []

          angular.forEach changeEvent.target.files, (v, k)->
            reader = new FileReader
            reader.onload = (loadEvent) ->
              scope.$apply ->
                scope.fileread.push loadEvent.target.result
                console.log scope.fileread
                return
              return
            reader.readAsDataURL v

          element.value = ''
          return
        return

    }
   ]