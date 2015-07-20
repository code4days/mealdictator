app.factory('geoService', ['$http', function($http) {

   return {
       getPlaces: function(position) {
           return $http.get("/places?lat=" + position.coords.latitude + "&lon=" + position.coords.longitude)
               .success(function (data) {
                   return data;
               })
               .error(function (err) {
                   return err;
               });
       }
   }

}]);