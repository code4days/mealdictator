var app =  angular.module('MealDictatorApp', ['ngRoute', 'ngMaterial']);

app.config(function($routeProvider, $mdThemingProvider) {
    $routeProvider
        .when('/', {
            controller: 'GeoController',
            templateUrl: 'partials/home.html'
            //this view can contain everything, use a var when set show location otherwise show form
            //
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
    $mdThemingProvider.theme('default')
        .primaryPalette('blue')
        .accentPalette('red');
});