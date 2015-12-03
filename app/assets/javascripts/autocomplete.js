$('#selectizable').selectize({
    valueField: 'id',
    labelField: 'title',
		searchField: 'fake',
		create: false,
    render: {
        option: function(item, escape) {
            return '<div>' +
                '<span class="title">' +
                    '<span class="name">' + escape(item.title) + '</span>' +
                '</span>' +
                '<span class="platform">' + " - " + escape(item.platform) + '</span>' +
            '</div>';
        }
    },
    load: function(query, callback) {
        if (!query.length) return callback();
        $.ajax({
            url: '/games/autocomplete',
            type: 'GET',
            dataType: 'text',
            data: {
                query: query,
            },
            error: function(jqXHR, textStatus, errorThrown) {
                callback();
            },
            success: function(res) {
								res = JSON.parse(res);
								res.forEach(function(item) {
									item.fake = query;
								});
                callback(res);
            }
        });
    },
		onItemAdd: function(value, $item){
			window.open('/games/'+value, '_self');
		}
});
