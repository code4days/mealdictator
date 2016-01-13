//in the controller we do the geo stuff, the http reqeust to get the location can be done in a service.
app.controller('GeoController', ['$scope', 'geoService', 'GeoPostService', '$sce', '$window', 'place', '$rootScope', '$location',
    function($scope, geoService, GeoPostService, $sce, $window, place, $rootScope, $location){

        $scope.hasLocation = false;

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
                    $scope.hasLocation = true;
                    $scope.place_data = place.getData();
                    //$rootScope.x = place.getData();
                    //$location.path("/restaurant");
                    //$scope.place = data;
                    $scope.map = $sce.trustAsResourceUrl("https://www.google.com/maps/embed/v1/search?key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4&q=+" + $scope.place_data.address.replace(/\s/g, '+'));
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
                //$location.path("/nogeo");
                console.warn("error: " + err);
                //todo: bool var can be used here too ??? thought
            });

        //$scope.inputLocation = "";
        //$scope.radius = 1;

        $scope.customLocation = function customLocation() {
            //todo:update service to take second param in func to know if it's post or not
            //take values from form and passthem as a postion object into  geoservice to make a post request to server

            var position = {
                locationInput: $scope.locationInput,
                radius: $scope.radius
            };


            console.log(position);
            //console.log(JSON.stringify(position));
            GeoPostService.getPlaces(position).success(function (data) {
                //console.log(data);
                place.setData(data);
                var resultData = place.getData();
                console.log(resultData);
                if (resultData.hasOwnProperty('error')) {
                    $scope.hasError = true;
                    $scope.errorMessage = resultData.error;
                }
                else {

                    $scope.hasLocation = true;
                    //$scope.place_data = place.getData();
                    $scope.place_data = resultData;
                    //$rootScope.x = place.getData();
                    //$location.path("/restaurant");
                    if ($scope.place_data.address !== undefined)
                        $scope.map = $sce.trustAsResourceUrl("https://www.google.com/maps/embed/v1/search?key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4&q=+" + $scope.place_data.address.replace(/\s/g, '+'));
                }
            });
            GeoPostService.getPlaces(position).error(function (data) {
                console.log("Error in nogeoctrl: " + data);
            })

        }

    }
}]);


