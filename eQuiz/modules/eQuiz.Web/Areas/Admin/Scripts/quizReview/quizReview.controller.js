(function (angular) {
    angular.module("equizModule")
           .controller('quizReviewController', quizReviewController);
    quizReviewController.$inject = ['$scope', 'quizReviewDataService'];

    function quizReviewController($scope, quizReviewDataService) {
        var vm = this;
        vm.passed = 0;
        vm.notPassed = 0;
        vm.inVerification = 0;

        vm.CountStats = function () {
            vm.passed = 0;
            vm.notPassed = 0;
            vm.inVerification = 0;

            vm.quiz.questions.forEach(function (item) {
                if (item.questionStatus === 0) {
                    vm.inVerification++;
                }
                if (item.questionStatus === 1) {
                    vm.passed++;
                }
                if (item.questionStatus === 2) {
                    vm.notPassed++;
                }
            });
        }

        function activate() {
            vm.student = quizReviewDataService.getStudent();
            vm.group = quizReviewDataService.getGroup();
            vm.quiz = quizReviewDataService.getQuiz();

            vm.CountStats();
        };

        activate();

        vm.SetQuestionStatus = function (id, status) {            
            for (var i = 0; i < vm.quiz.questions.length; i++){            
                if (vm.quiz.questions[i].question_id === id) {                    
                    vm.quiz.questions[i].questionStatus = status;
                }
            }
            
            vm.CountStats();           
        }
    };
})(angular);