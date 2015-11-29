/*var games = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: '/games/autocomplete?query=%QUERY',
    wildcard: '%QUERY'
  }
});

games.initialize();

// Instantiate the Typeahead UI
$('#srch-item').typeahead({
		hint: true,
		highlight: true,
		minLength: 1
	},
	{
		name: 'games',
		displayKey: 'title',
		source: games.ttAdapter()
});*/

$('#selectizable').selectize({
    valueField: 'id',
    labelField: 'title',
		searchField: 'fake',
		maxOptions: 5,
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
    }
}).on('item_add', function(value, $item) {
	console.log(value);
	window.location.href='http://google.com';
});
