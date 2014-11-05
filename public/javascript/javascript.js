var x = document.getElementById("demo");

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else { 
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
    x.innerHTML="Latitude: " + position.coords.latitude + 
    "<br>Longitude: " + position.coords.longitude;	
    document.getElementById("lat").innerHTML = position.coords.latitude;
    document.getElementById("lon").innerHTML = position.coords.longitude;


$.post(
    "http://localhost:4567/location",
    {'lat': lat, 'lon': lon},
    onsuccess   //optional
);

}