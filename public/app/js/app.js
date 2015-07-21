var app =  angular.module('MealDictatorApp', ['ngRoute']);

app.config(function($routeProvider) {
    $routeProvider
        .when('/', {
            controller: 'GeoController',
            templateUrl: 'partials/home.html'
        })
        .when('/nogeo', {
            controller: 'NoGeoController',
            templateUrl: 'partials/location_form.html'
        })
        .when('/restaurant', {
            controller: 'RestaurantController',
            templateUrl: 'partials/restaurant.html'
        })
        .otherwise({
            redirectTo: '/'
        });
});