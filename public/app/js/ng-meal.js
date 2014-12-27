var mealModule = angular.module('meal-app', ['ui.router']);

mealModule.config(function($stateProvider, $urlRouterProvider) {

    //default route for unmatched urls
    $urlRouterProvider.otherwise("/");

    //states
    $stateProvider
        .state('home', {
            url: "/",
            templateUrl: "partials/home.html",
            controller: "geoController"
        })

        .state('geo-error', {
            url: "/geo-error",
            templateUrl: "partials/geo-error.html"
            //template: "ERROR"

        });
});

mealModule.controller('geoController', function($scope, $state, $http) {
   if (navigator.geolocation) {
       navigator.geolocation.getCurrentPosition(function(position){
           $scope.$apply(function(){
               $scope.position = position;

               $http.get("/places?lat=" + $scope.position.coords.latitude + "&lon=" + $scope.position.coords.longitude)
                   .success( function(data) {
                       $scope.place = data;
                   });

               //send params to /places... let places parse and return JSON, parse and create display on home

           });
       }, function(error) {
           //alert(error);

               $state.go('geo-error');

       });
   }
});