
'use strict'

angular.module('green.inputmask4angular', []).directive 'inputMask', ->
  {
    restrict: 'A'
    link: (scope, el, attrs) ->
      $(el).inputmask scope.$eval(attrs.inputMask)
      $(el).on 'change', ->
        scope.$eval attrs.ngModel + '=\'' + $(el).val() + '\''
        # or scope[attrs.ngModel] = el.val() if your expression doesn't contain dot.
        return
      return

  }
