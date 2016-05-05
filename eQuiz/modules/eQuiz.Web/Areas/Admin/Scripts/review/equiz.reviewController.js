(function(angular) {
angular.module('equizModule').controller('ReviewController', ReviewController);

    ReviewController.$inject = ['$scope', '$filter', 'reviewDataService'];

    function ReviewController($scope, $filter, reviewDataService) {
    var vm = this;
    vm.search = '';
    vm.myPredicate = null;
    vm.tablePage = 0;
    vm.resultsPerPage = 10;

    var orderBy = $filter('orderBy');

    vm.headers = [
    {
        name:'Student',
        field: 'student',
        predicateIndex: 1
    },{
        name: 'User group', 
        field: 'userGroup',
        predicateIndex: 0
    },{
        name:'Quizzes', 
        field: 'quizzes',
        predicateIndex: 2
    }
  ];
  
    vm.content = [];
  
    vm.custom = { student: 'bold', userGroup: 'grey', quizzes: 'grey' };

    vm.resultsCount = [10, 25, 50, 100];

    function activate() {
        //var contentPromise = reviewDataService.getStudents();
        //contentPromise.then(function (response) {
        //    $scope.$applyAsync(function () {
        //        $scope.content.push.apply($scope.content, response.data);
        //    });
        //});
        vm.content = reviewDataService.getStudents()
    };

    activate();

    function generatePredicate() {
        vm.myPredicate = [null, null, null];
    };

    vm.refreshPredicate = function (index) {
        if (vm.myPredicate === null) {
          generatePredicate();
      }
      if (vm.myPredicate[index] === null) {
          var item = null;
          switch (index) {
              case 0:
                  item = '+userGroup';
                  break;
              case 1:
                  item = '+student';
                  break;
              case 2:
                  item = '+quizzes';
                  break;
          }
          vm.myPredicate[index] = item;
      }
      else if (vm.myPredicate[index][0] === '+') {
          vm.myPredicate[index] = '-' + vm.myPredicate[index].slice(1);
      }
      else if (vm.myPredicate[index][0] === '-') {
          vm.myPredicate[index] = null;
      }
  };

    vm.direction = function (index) {
        if (vm.myPredicate) {
          if (vm.myPredicate[index] === null) {
              return null;
          };
          if (vm.myPredicate[index][0] === '+') {
              return true;
          };
          return false;
      };
      return null;
  };

    vm.numberOfPages = function () {
        return Math.ceil(vm.content.length / vm.resultsPerPage);
    };

    vm.getNumber = function (num) {
      return new Array(num);
  };

    vm.order = function(predicate, reverse) {
        vm.content = orderBy(vm.content, predicate, reverse);
        vm.predicate = predicate;
  };

    vm.goToPage = function (page) {
        vm.tablePage = page;
    };
    
    vm.selectedGroup = [];
    vm.groupList = GetUniquePropertyValues(vm.content, 'userGroup'); //property user group needs to be changed manualy    

    $scope.setSelectedGroup = function () { // DONT PUT THIS FUNCTION INTO VM! let it be in scope (because of 'this' in function)
        var id = this.group;
        if (_.contains(vm.selectedGroup, id)) {
            vm.selectedGroup = _.without(vm.selectedGroup, id);
        } else {
            vm.selectedGroup.push(id);
        }
        return false;
    };

    vm.isChecked = function (group) {
        if (_.contains(vm.selectedGroup, group)) {
            return 'icon-ok pull-right';
        }
        return false;
    };

    vm.checkAll = function () {
        vm.selectedGroup = vm.groupList;
    };

    vm.unCheckAll = function () {
        vm.selectedGroup = [];
    };

    function GetUniquePropertyValues(arrayToCheck, propertyName) {
        var flags = [];
        var output = [];
        for (var i = 0; i < arrayToCheck.length; i++) {
            if (flags[arrayToCheck[i][propertyName]]) {
                continue;
            }

            flags[arrayToCheck[i][propertyName]] = true;
            output.push(arrayToCheck[i][propertyName]);
        }

        return output;
    }
};

})(angular);