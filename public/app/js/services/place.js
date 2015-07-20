app.service('place', function () {
    //this.data = {};
    var data = {};

    return {
        getData: function () {
            return data;
        },
        setData: function(value) {
            data = value;
        }
    }
});