var createRecord = function() {
    var createParams = {
          "jog[time]": $('#new-jog-time').val(),
          "jog[distance]": $('#new-jog-distance').val(),
          "jog[date]": $('#new-record-calendar').calendar('get date'),
          "jog[user_id]": $('#new-jog-user_id').val()
        }
    $ajax({
        url: "http://api.regan-ryan.dev/jogs",
        method: 'POST',
        data: createParams,
        headers: {
                    Accept: "application/vnd.regan-ryan.v1",
                    Authorization: userAuthToken
                  }
    }).success(function() {
        alert("great!");
        // finish this
    }).error(function() {
        console.log(arguments);
        alert('Failed!');
    });
};

var deleteRecord = function(id) {
    if (confirm('Are you sure you want to delete this jogging record?')) {
        $ajax({
            url: "http://api.regan-ryan.dev/jogs/" + id,
            method: 'DELETE',
            headers: {
                        Accept: "application/vnd.regan-ryan.v1",
                        Authorization: userAuthToken
                      }
        }).success(function() {
            alert("great!");
            // finish this
        }).error(function() {
            console.log(arguments);
            alert('Failed!');
        });
    }

};

