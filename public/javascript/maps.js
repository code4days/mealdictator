
function getLocation() {
    if (navigator.geolocation) {
        console.log("IN GEO IF")
        //navigator.geolocation.getCurrentPosition(showPosition, error);
        navigator.geolocation.watchPosition(showPosition, error);
    } else {
       // document.write("Geolocation is not supported by this browser.");
        //console.log("user rejected location request")
        console.log("IN GEO ELSE")


    }
}

function showPosition(position) {
    // document.write("Latitude: " + position.coords.latitude +
    // "<br>Longitude: " + position.coords.longitude);
    var lat = position.coords.latitude;
    var lon = position.coords.longitude;


    //window.location.assign("http://localhost:4567/geo?lat=" + lat + "&lon=" + lon);
    //window.location.assign("/geo?lat=" + lat + "&lon=" + lon);

    //TODO:This has to be moved to prevent auto redirect
    window.location.assign("/places?lat=" + lat + "&lon=" + lon);
}

function error() {
    console.log("in ERROR function");
    //var output = document.getElementById("restaurant");

    //output.innerHTML = "<b>Please type in location to find restaurant</b>";
    window.location.assign("/places/true");
}

function parse(form) {
    var query = form.query.value;
    var mile = form.mile.value;

    window.location.assign("/maps?query=" + query + "&mile=" + mile);
}

function onClickSkip(){
    console.log("Pressed Skip");
    window.location.assign("/");
}

