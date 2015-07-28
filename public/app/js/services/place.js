app.service('place', function () {
    //this.data = {};
    //var data = {};

    return {
        getData: function () {
            //return data;
            return JSON.parse(localStorage.getItem("place"));
        },
        setData: function(value) {
            //data = value;
            localStorage.setItem("place", JSON.stringify(value));
        }
        //todo: think about adding a third function to clear the localStroage.
        //todo: think about having localStorage expire?

    }
});