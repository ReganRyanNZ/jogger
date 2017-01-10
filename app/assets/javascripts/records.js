var deleteRecord = function(id) {
    if (confirm('Are you sure you want to delete this jogging record?')) {
        $ajax({
            url: Routes.jog_path(id),
            method: 'DELETE'
        }).success(function() {
            alert("great!");
            // $editForms.fadeOut(function() {
            //     clearForm();
            // });
            // $boundBox.fadeOut();
            // var $active = $highlightForm.hasClass('overview') ? $('#' + id + '.overview-btn.overview') : $('.snippet-objects.active');
            // $active.fadeOut(function() {
            //     $(this).remove();
            // });
        })
    }

};