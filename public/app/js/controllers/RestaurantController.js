app.controller('RestaurantController', ['$scope', 'place',
    function ($scope, place) {
        $scope.$watch(place.getData(), function() {$scope.place_data = place.getData()}, true);

        console.log($scope.place_data);
        console.log(place.getData());
    }
]);