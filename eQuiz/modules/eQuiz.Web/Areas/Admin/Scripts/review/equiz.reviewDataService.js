(function (angular) {

    angular
        .module("equizModule")
        .factory("reviewDataService", reviewDataService);

    reviewDataService.$inject = ["$http"];

    function reviewDataService($http) {

        var service = {
            getStudents: getStudentsAjax,
        };

        return service;

        function getStudentsAjax() {
            var promise = [
      {
          student: 'Eugene Shtefaniuk',
          userGroup: 'User',
          quizzes: 'dotNet, HTML'
      }, {
          student: 'Dmytro Maherovsky',
          userGroup: 'Admin',
          quizzes: 'dotNet, Angular'
      }, {
          student: 'Galyna Posivnych',
          userGroup: 'Admin',
          quizzes: 'dotNet'
      }, {
          student: 'Lev-Ivan Bulyk',
          userGroup: 'User',
          quizzes: 'ASP.NET MVC'
      }, {
          student: 'Ostap Gereley',
          userGroup: 'Moderator',
          quizzes: 'ASP.NET MVC'
      }
            ];
            return promise;
        }
    }

})(angular);