var mealModule = angular.module('meal-app', ['ui.router']);

mealModule.config(function($stateProvider, $urlRouterProvider) {

    //default route for unmatched urls
    $urlRouterProvider.otherwise("/home");

    //states
    $stateProvider
        .state('home', {
            url: "/home",
            templateUrl: "partials/home.html",
            controller: "geoController"
        })

        .state('geo-error', {
            url: "/geo-error",
            templateUrl: "partials/geo-error.html"
            //template: "ERROR"

        })
    ;
});

mealModule.controller('geoController', function($scope, $state) {
   if (navigator.geolocation) {
       navigator.geolocation.getCurrentPosition(function(position){
           $scope.$apply(function(){
               $scope.position = position;
           });
       }, function(error) {
           //alert(error);
           $state.go('geo-error');
       });
   }
});