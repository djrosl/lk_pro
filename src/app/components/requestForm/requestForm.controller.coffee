angular.module 'frontend'
  .controller 'RequestFormController', ($scope, $http, $timeout) ->
    'ngInject'
    vm = this
    
    vm.tooltipContent =
      time: "<p>Срок - <b>2 рабочих дня</b></p><p>Заявка обрабатывается с пн по пт по рабочим дням</p>"
      example: "<div class='text-center'><a href=''>Пример отчета</a></div>"
      help: "Что такое «проверка до негатива»
      Это уникальная функция нашего сервиса, которая экономит время и деньги.
      Если у брокера проходит большой поток клиентов, ему важны не подробности кредитной истории каждого заемщика,
      а сама возможность выдачи кредита.
      В таком случае заказывать все отчеты на каждого человека может быть чересчур затратно.
      Для этого мы ввели функцию проверки до первого негатива.
      Она начинается с баз, в которых есть наибольший шанс встретить негатив,
      и останавливается при обнаружении первого негативного фактора."
    
    $scope.$watch 'slug', (newVal, oldVal)->
      if newVal? and newVal isnt oldVal
        vm.type = {}
        vm.loaded = 0
        $http.get 'http://lkpro.loc/database-type/search?slug='+$scope.slug+'&expand=sections,databases'
          .success (data)->
            vm.type = data
            angular.forEach data.sections, (v,k)->
              vm.type.sections[k].databases = data.databases[v.id]
            delete vm.type.databases
            vm.type.icon_class = 'fa fa-'+data.icon_class
            $timeout ()->
              vm.loaded = 1
            ,200,false

    return
