(function(angular) {
angular.module('equizModule').controller('ReviewController', ReviewController);

    ReviewController.$inject = ['$scope', '$filter', 'reviewDataService'];

    function ReviewController($scope, $filter, reviewDataService) {

    $scope.search = '';
    $scope.myPredicate = null;
    $scope.tablePage = 0;
    $scope.resultsPerPage = 10;

    var orderBy = $filter('orderBy');

    $scope.headers = [
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
  
    $scope.content = [];
  
    $scope.custom = { student: 'bold', userGroup: 'grey', quizzes: 'grey' };

    $scope.resultsCount = [10, 25, 50, 100];

    function activate() {
        //var contentPromise = reviewDataService.getStudents();
        //contentPromise.then(function (response) {
        //    $scope.$applyAsync(function () {
        //        $scope.content.push.apply($scope.content, response.data);
        //    });
        //});
        $scope.content = reviewDataService.getStudents()
    };

    activate();

    function generatePredicate() {
        $scope.myPredicate = [null, null, null];
    };

    $scope.refreshPredicate = function (index) {
      if ($scope.myPredicate === null) {
          generatePredicate();
      }
      if ($scope.myPredicate[index] === null) {
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
          $scope.myPredicate[index] = item;
      }
      else if ($scope.myPredicate[index][0] === '+') {
          $scope.myPredicate[index] = '-' + $scope.myPredicate[index].slice(1);
      }
      else if ($scope.myPredicate[index][0] === '-') {
          $scope.myPredicate[index] = null;
      }
  };

    $scope.direction = function (index) {
      if ($scope.myPredicate) {
          if ($scope.myPredicate[index] === null) {
              return null;
          };
          if ($scope.myPredicate[index][0] === '+') {
              return true;
          };
          return false;
      };
      return null;
  };

    $scope.numberOfPages = function () {
        return Math.ceil($scope.content.length / $scope.resultsPerPage);
    };

    $scope.getNumber = function (num) {
      return new Array(num);
  };

    $scope.order = function(predicate, reverse) {
       $scope.content = orderBy($scope.content, predicate, reverse);
       $scope.predicate = predicate;
  };

    $scope.goToPage = function (page) {
        $scope.tablePage = page;
    };
    
    $scope.selectedGroup = [];
    $scope.groupList = GetUniquePropertyValues($scope.content, 'userGroup'); //property user group needs to be changed manualy    

    $scope.setSelectedGroup = function () { // DONT PUT THIS FUNCTION INTO VM! let it be in scope (because of 'this' in function)
        var id = this.group;
        if (_.contains($scope.selectedGroup, id)) {
            $scope.selectedGroup = _.without($scope.selectedGroup, id);
        } else {
            $scope.selectedGroup.push(id);
        }
        return false;
    };

    $scope.isChecked = function (group) {
        if (_.contains($scope.selectedGroup, group)) {
            return 'icon-ok pull-right';
        }
        return false;
    };

    $scope.checkAll = function () {
        $scope.selectedGroup = $scope.groupList;
    };

    $scope.unCheckAll = function () {
        $scope.selectedGroup = [];
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

angular.module('equizModule').filter('startFrom', function () {
  return function (input, start) {
      if (!input || !input.length) { return; }
      start = +start;
      return input.slice(start);
  }
});

angular.module("equizModule").filter('highlight', function ($sce) {
    return function (text, phrase) {
        if (phrase) {
            text = text.replace(new RegExp('(' + phrase + ')', 'gi'), '<span class="highlightedText">$1</span>');
        }

        return $sce.trustAsHtml(text);
    }
});

angular.module('equizModule').filter('groupFilter', function () {
    return function (data, selectedData) {
        if (!angular.isUndefined(data) && !angular.isUndefined(selectedData) && selectedData.length > 0) {
            var tempData = [];
            angular.forEach(selectedData, function (id) {
                angular.forEach(data, function (item) {
                    if (angular.equals(item.userGroup, id)) { //property user group needs to be changed manualy
                        tempData.push(item);
                    }
                });
            });
            return tempData;
        } else {
            return data;
        }
    };
});

})(angular);