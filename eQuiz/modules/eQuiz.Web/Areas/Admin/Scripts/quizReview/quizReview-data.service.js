(function (angular) {

    angular
        .module("equizModule")
        .factory("quizReviewDataService", quizReviewDataService);

    quizReviewDataService.$inject = ["$http"];

    function quizReviewDataService($http) {

        var service = {
            getStudent: getStudentAjax,
            getQuiz: getQuizAjax,
            getGroup: getGroupAjax
        };

        return service;

        function getStudentAjax() {
            var promise = {
                first_name: "Paul",
                last_name: "Dema",
                parent_name: "Michael"                              
            };
            return promise;
        }

        function getQuizAjax() {
            var promise = {
                quiz_name: ".Net junior test",
                start_date: "21.04.2016 10:05",
                end_date: "21.04.2016 10:45",
                questions: [
                  { question_id: 1, question: "What does 'foo' really mean?", answer: "The terms foobar, fubar, foo are sometimes used as placeholder names in computer programming or computer-related documentation.They have been used to name entities such as variables, functions, and commands whose purpose is unimportant and serve only to demonstrate a concept. The words themselves have no meaning in this usage", questionStatus: 0, questionType: 0 },
                  { question_id: 2, question: "What is class?", answer: "A class is a construct that enables you to create your own custom types by grouping together variables of other types, methods and events.", questionStatus: 0, questionType: 0 },
                  { question_id: 3, question: "Select only value types:", answers: [{ id: 1, answer: "integer" }, { id: 2, answer: "string" }, { id: 3, answer: "boolean" }], questionStatus: 0, questionType: 1 },
                  { question_id: 4, question: "What is difference between an interface and an Abstract class?", answers: [{ id: 1, answer: "A class may implement a number of interfaces, but can extend only one abstract class" }, { id: 2, answer: "Word 'Abstract' is written in another way than 'interface'" }, { id: 3, answer: "I dont know" }], questionStatus: 0, questionType: 1 },
                  { question_id: 5, question: "What CLR stands for?", answer: "Common Language Runtime", questionStatus: 0, questionType: 0 }
                ]
            };
            return promise;
        }

        function getGroupAjax() {
            var promise = {
                group_name: ".Net 2015"
            };
            return promise;
        }
    }

})(angular);