app.factory('GeoPostService', ['$http', function($http) {
    return {
        getPlaces: function (position) {
            return $http.post('/places', position)
                .success(function (data) {
                    return data;
                })
                .error(function (data) {
                    return data;
                });
        }
    }
}]);
