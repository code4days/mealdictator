app.controller('NoGeoController', ['$scope', 'GeoPostService', '$location', 'place', '$rootScope',
    function($scope, GeoPostService, $location, place, $rootScope) {
        //here we create the function for the form after submition it should do the same thing
        //geoController does but with custom position MIGHT NEEED REFACTORING

        $scope.inputLocation = "";
        $scope.radius = 1;

        $scope.customLocation = function customLocation() {
            //todo:update service to take second param in func to know if it's post or not
            //take values from form and passthem as a postion object into  geoservice to make a post request to server

            //var position = {
            //    coords: {
            //        latitude: 0,
            //        longitude: 0
            //
            //    }
            //};
            var position = {
                locationInput: $scope.locationInput,
                radius: $scope.radius
            };


            console.log(position);
            //console.log(JSON.stringify(position));
            GeoPostService.getPlaces(position).success(function (data) {
                //console.log(data);
                place.setData(data);
                //$rootScope.x = place.getData();
                $location.path("/restaurant");

            });
            GeoPostService.getPlaces(position).error(function (data) {
                console.log("Error in nogeoctrl: " + data);
            })

        }

    }]);