
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        document.write("Geolocation is not supported by this browser.");
    }
}

function showPosition(position) {
    // document.write("Latitude: " + position.coords.latitude +
    // "<br>Longitude: " + position.coords.longitude);
    var lat = position.coords.latitude;
    var lon = position.coords.longitude;


window.location.assign("http://localhost:4567/location?lat=" + lat + "&lon=" + lon);
// $.get(
//     "http://localhost:4567/location?lat=" + lat + "&lon" + lon;
//     // {'lat': lat, 'lon': lon},
//     // onsuccess   //optional
// );

}
