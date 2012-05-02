//= require gko/jquery.elastidegallery
//= require jquery.categoriesFilter
//= require modernizr.custom.72835
//= require circlemouse


$(document).ready(function() {
	if($('.images:first').length > 0) {
		Gallery.init($('.images:first'));
	}
	//if(!$('body').hasClass('mobile')) {
		init_categories_filters();// ! always after init_ajax
	//}
	
	if (jQuery.browser.msie) {
		$('.ec-circle h3').css({color:'#fff', display:'none'});
	}
	$('.circle').circlemouse({
		onMouseEnter	: function( el ) {
			el.addClass('ec-circle-hover');
			if (jQuery.browser.msie) {
				el.find('h3:first').stop().fadeIn();
			}
		},
		onMouseLeave : function( el ) {
			el.removeClass('ec-circle-hover');
			if (jQuery.browser.msie) {
				el.find('h3:first').stop().fadeOut();
			}
		},
		onClick : function( el ) {
			//$loader.show();
		}
	}); 
});