var values = []
function init_categories_filters() {

    // Setting up our variables
    var $filterList = $('.games-categories .nav-list');
    var $filter = 'all';
    // Set our filter
    var $container = $('ul.grid');
	var $filterable_items;

    $filterList.prepend($("<li id='all' class='filterable active'><a href='#'>Toutes</a></li>"));

	// Store elements that have tags
	$filterable_items = $container.find('li[data-tags*=]');
	
	$container.find('li.filterable').each(function() {
		$(this).css({clear: 'none', float: 'left'});
	})
    // Apply our Quicksand to work
    $('.games-categories li.filterable a').on('click',
    function(e) {
		e.stopPropagation();
		e.preventDefault();

        var li = $(this).parent()
			,id = li.attr('id')
			,ul = li.parent()
			,actives = []
			,result = [];

		// toogle the 'active' class to the clicked link
		ul.find('li.active').removeClass('active');
		li.toggleClass('active');
		if(id == 'all') {
			$container.find('li.filterable').each(function() {
				$(this).show(300);
			});
		} 
		else {
	        $container.find('li.filterable').each(function() {
				var elm = $(this)
					,tags = elm.data('tags')
					,presence = false;
				if(tags) {
					$.grep(tags, function (item_tag) {
						if(~item_tag.toLowerCase().indexOf(id)) {
							presence = true;
						}
					})
				}
				else {
					presence = false;
				}

				if(presence) {
					elm.show(300);
				}
				else {
					elm.hide(300);
				}
	        })
		}
		
    });
}