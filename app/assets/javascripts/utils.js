function $ajax(options) {
    return $.ajax({
        url: options.url,
        type: options.method,
        data: options.data,
        headers: options.headers,
        contentType: false,
        processData: false,
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        }
    });
}