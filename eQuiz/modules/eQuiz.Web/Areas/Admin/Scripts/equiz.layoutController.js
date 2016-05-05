(function (angular) {
    angular.module('equizModule').controller('LayoutController', LayoutController);

    LayoutController.$inject = ['$scope', '$http', '$sce'];

    function LayoutController($scope, $http, $sce) {
        var vm = this;
        function GoToReview() {
            $http.get('/Areas/Admin/Scripts/Templates/Review.html')
            .then(function (response) {
                vm.review = $sce.trustAsHtml(response.data);
            });
        };
        vm.GoToReview = GoToReview;
        vm.GoToReview();
    };
})(angular);