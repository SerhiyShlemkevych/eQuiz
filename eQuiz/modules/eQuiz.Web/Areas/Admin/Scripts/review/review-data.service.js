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
          student: 'Dmytro Maherovskyi',
          userGroup: 'Admin',
          quizzes: 'dotNet, Angular'
      }, {
          student: 'Halyna Posivnych',
          userGroup: 'Admin',
          quizzes: 'dotNet'
      }, {
          student: 'Lev-Ivan Bulyk',
          userGroup: 'User',
          quizzes: 'ASP.NET MVC'
      }, {
          student: 'Ostap Herelei',
          userGroup: 'Moderator',
          quizzes: 'ASP.NET MVC'
      }, {
          student: 'Pavlo Demskyi',
          userGroup: 'Moderator',
          quizzes: 'ASP.NET MVC'
      }, {
          student: 'Eugene Shtefaniuk',
          userGroup: 'User',
          quizzes: 'dotNet, HTML'
      }, {
          student: 'Dmytro Maherovskyi',
          userGroup: 'Admin',
          quizzes: 'dotNet, Angular'
      }, {
          student: 'Halyna Posivnych',
          userGroup: 'Admin',
          quizzes: 'dotNet'
      }, {
          student: 'Lev-Ivan Bulyk',
          userGroup: 'User',
          quizzes: 'ASP.NET MVC'
      }, {
          student: 'Ostap Herelei',
          userGroup: 'Moderator',
          quizzes: 'ASP.NET MVC'
      }, {
          student: 'Pavlo Demskyi',
          userGroup: 'Moderator',
          quizzes: 'ASP.NET MVC'
      }
            ];
            return promise;
        }
    }

})(angular);