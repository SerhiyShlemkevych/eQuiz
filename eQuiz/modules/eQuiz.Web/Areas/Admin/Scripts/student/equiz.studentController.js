(function (angular) {
	angular.module('equizModule').controller('StudentController', StudentController);

	StudentController.$inject = ['$scope', '$filter', 'studentDataService', 'sharedProperties'];

	function StudentController($scope, $filter, studentDataService, sharedProperties) {
	    var vm = this;

	    vm.studentInfo = {};
		vm.studentQuizzes = [];
		vm.studentComments = [];

		vm.studentQuizzesHeaders = [
{
    name: 'Name',
    field: 'name',
    predicateIndex: 0
}, {
    name: 'State',
    field: 'state',
    predicateIndex: 1
}, {
    name: 'Questions',
    field: 'questions',
    predicateIndex: 2
}, {
    name: 'Verification Type',
    field: 'verificationType',
    predicateIndex: 3
}, {
    name: 'Other details',
    field: 'otherDetails',
    predicateIndex: 4
}
		];
		vm.myPredicate = null;
		vm.newComment = {};
		vm.currentTab = 'Profile';
		vm.newCommentFrame = false;
		vm.modelChanged = false;
		var orderBy = $filter('orderBy');

		var activate = function () {
		    //var studentInfoPromise = studentDataService.getStudentInfo(sharedProperties.selectedStudent);
		    //studentInfoPromise.then(function (response) {
		    //    $scope.$applyAsync(function () {
		    //        vm.studentInfo = response.data;
		    //    });
		    //}
            //);

		    vm.studentInfo = studentDataService.getStudentInfo(sharedProperties.selectedStudent);
		    vm.studentQuizzes = studentDataService.getStudentQuizzes(sharedProperties.selectedStudent);
		    vm.studentComments = studentDataService.getStudentComments(sharedProperties.selectedStudent);
		};
        
		activate();

		function generatePredicate() {
		    vm.myPredicate = [null, null, null, null, null];
		};

		vm.refreshPredicate = function (index) {
		    if (vm.myPredicate === null) {
		        generatePredicate();
		    }
		    if (vm.myPredicate[index] === null) {
		        var item = null;
		        switch (index) {
		            case 0:
		                item = '+name';
		                break;
		            case 1:
		                item = '+state';
		                break;
		            case 2:
		                item = '+questions';
		                break;
		            case 3:
		                item = '+verificationType';
		                break;
		            case 4:
		                item = '+otherDetails';
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

		vm.order = function (predicate, reverse) {
		    vm.studentQuizzes = orderBy(vm.studentQuizzes, predicate, reverse);
		    vm.predicate = predicate;
		};

		vm.getPassedQuizzes = function() {
		    var passed = 0;
		    var inVerification = 0;
		    var notPassed = 0;

		    vm.studentQuizzes.forEach(function (currVal, index) {
		        if (currVal.state == 'Passed') {
		            passed++;
		        }
		        else if(currVal.state == 'In Verification') {
		            inVerification++;
		        }
		        else {
		            notPassed++;
		        }
		    });

		    return passed + '/' + inVerification + '/' + notPassed;
		};

		vm.saveProfile = function () {
		    studentDataService.saveProfileInfo(vm.studentInfo, vm.studentComments);
		    vm.modelChanged = false;
		};

		vm.cancelProfile = function() {
		    activate();
		    vm.modelChanged = false;
		};

		vm.toggleNewCommentFrame = function () {
		    vm.newCommentFrame = !vm.newCommentFrame;
		    vm.newComment = {}
		};

		vm.addComment = function () {
		    vm.studentComments.push(vm.newComment);
		    vm.modelChanged = true;
		    vm.toggleNewCommentFrame();
		};

		vm.validationCheck = function () {
		    return $scope.profileInfo.firstName.$valid && $scope.profileInfo.lastName.$valid && $scope.profileInfo.phone.$valid && vm.modelChanged;
		};

		vm.setQuiz = function (quiz) {
		    sharedProperties.selectedQuiz = quiz;
		    console.log(sharedProperties.selectedQuiz);
		};

		vm.getWatchersLength = function () {
		    var watchers = [];
		    angular.forEach($scope.$$watchers, function (watcher) {
		        watchers.push(watcher.exp);
		    })
		    return watchers
		}
	};
})(angular);