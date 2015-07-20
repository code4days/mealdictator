//in the controller we do the geo stuff, the http reqeust to get the location can be done in a service.
app.controller('GeoController', ['$scope', 'geoService', '$sce', '$window', 'place', '$rootScope', '$location',
    function($scope, geoService, $sce, $window, place, $rootScope, $location){

    if (!navigator.geolocation) {

        //there is no geolocation redirect to form
        console.warn("no geo support");

    } else {

        navigator.geolocation.getCurrentPosition(

            function(position){
                //$scope.position = position;
                //todo:thinking about a bool var for showing only form or entire page
                console.log(typeof position.coords);
                geoService.getPlaces(position).success(function (data) {
                    place.setData(data);
                    $rootScope.x = place.getData();
                    $location.path("/restaurant");
                    //$scope.place = data;
                    //$scope.map = $sce.trustAsResourceUrl("https://www.google.com/maps/embed/v1/search?key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4&q=+" + $scope.place.address.replace(/\s/g, '+'));
                });
                geoService.getPlaces(position).error(function (data) {
                    console.log("error reading places");
                });
                console.log("lat: " + position.coords.latitude);
                console.log("lon: " + position.coords.longitude);
                console.log("accuracy: " + position.coords.accuracy);
            },
            function error(err) {
                //$window.location.href = '#/nogeo';
                $location.path("#/nogeo");
                console.warn("error: " + err);
                //todo: bool var can be used here too ??? thought
            });

    }
}]);


