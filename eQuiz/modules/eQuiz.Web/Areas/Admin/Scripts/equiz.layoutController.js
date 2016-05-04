(function (angular) {
    angular.module('equizModule').controller('LayoutController', function ($scope, $http, $sce) {
        var vm = this;
        function GoToReview() {
            $http.get('/Areas/Admin/Views/Pages/Review.html')
            .then(function (response) {
                vm.review = $sce.trustAsHtml(response.data);
            });
        };
        vm.GoToReview = GoToReview;
        vm.GoToReview();
    });

    angular.module('equizModule').directive('compile', ['$compile', function ($compile) {
        return function (scope, element, attrs) {
            scope.$watch(
                function (scope) {
                    return scope.$eval(attrs.compile);
                },
                function (value) {
                    element.html(value);
                    $compile(element.contents())(scope);
                }
            );
        };
    }]);
})(angular);