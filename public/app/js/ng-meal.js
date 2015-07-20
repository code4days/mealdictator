var mealModule = angular.module('meal-app', ['ui.router']);

mealModule.config(function($stateProvider, $urlRouterProvider) {

    //default route for unmatched urls
    $urlRouterProvider.otherwise("/");

    $stateProvider
        //.state('parent', {
        //    abstract: true,
        //    templateUrl: "index.html"
        //})

        .state('home', {
            url:'/',
            views: {

                '': { templateUrl: "partials/restaurant.html"},
                'restaurant@home': {
                    templateUrl: "partials/home.html",
                    controller: "geoController"
                },
                'settings@home': {
                    templateUrl: "partials/geo-error.html"
                }

            }
        })
        .state('home.geo-error', {
            url: "/geo-error",
            templateUrl: "partials/geo-error.html",
            controller: "CustomSettings"

        })

        .state('test', {
            url: "/test",
            templateUrl: "partials/test.html",
            controller: "testctrl"
        });
/*
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

        })

        .state('test', {
            url:"/test",
            templateUrl: "partials/test.html"

        });
    */
});

mealModule.controller('geoController', function($scope, $state, $http, $sce) {
   if (navigator.geolocation) {
       navigator.geolocation.getCurrentPosition(function (position){
           $scope.$apply(function (){
               $scope.position = position;

               $http.get("/places?lat=" + $scope.position.coords.latitude + "&lon=" + $scope.position.coords.longitude)
                   .success( function(data) {
                       $scope.place = data;
                       $scope.map = $sce.trustAsResourceUrl("https://www.google.com/maps/embed/v1/search?key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4&q=+" + $scope.place.address.replace(/\s/g, '+'));
                   });

               //send params to /places... let places parse and return JSON, parse and create display on home

           });
       }, function(error) {
           //alert(error);

               $state.go('.geo-error');

       });
   }
});

mealModule.controller('CustomSettings', function($scope, $http, $state, Data) {

    console.log("IN CUSTOMSETTINGS CONTROLLER!!!");

    //$scope.newSettings.locationInput = "";
    //$scope.newSettings.radius = 1; // default radius in miles to be converted to meters later.
    //

    $scope.addSettings = function addSettings() {

        //console.log($scope.newSettings.locationInput);
        //console.log($scope.newSettings.radius);
        console.log($scope.newSettings);

         $scope.place_data = {};

        //$http.post('/places', $scope.newSettings).success(function(data) {
        //    console.log("Sucessssss!!!!");
        //    //console.log(data);
        //    $scope.place_data = data
        //    console.log($scope.place_data);
        //});

        //$state.go('home', place_data);


        //Data($scope.newSettings).success($scope.place_data);



        $scope.place_data = Data($scope.newSettings);


        console.log("BEFORE SENDING TO TEST ");
        console.log($scope.place_data)

        $state.go('test', {place_data: JSON.stringify($scope.place_data)});

    }


});

mealModule.controller('testctrl', function($scope, $stateParams) {
    console.log("IN TEST" + $stateParams.place_data);
    $scope.test_place = $stateParams.place_data;

});

mealModule.factory('Data',['$http', function($http) {
    console.log("IN new SETTINGS SERVICE");

    return  function(nSettings) {
             $http.post('/places', nSettings).success(function(data) {

                 console.log("IN DATA SERVICE")
                 console.log(data);
                 return data;

             });
    }
}]);
