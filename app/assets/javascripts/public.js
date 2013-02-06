//= require jquery
//= require jquery_ujs

//= require twitter/bootstrap/transition.js
//= require twitter/bootstrap/alert.js
//= require twitter/bootstrap/button.js
//= require twitter/bootstrap/carousel.js
//= require twitter/bootstrap/collapse.js
//= require twitter/bootstrap/dropdown.js
//= require twitter/bootstrap/modal.js

//= require gko/public/jquery.grid.responsive.js
//= require gko/public/jquery.bootstrap.navbarhover.js

//= require flexslider/jquery.flexslider.js
//= require jquery.categoriesFilter
//= require modernizr.custom.72835
//= require circlemouse

var Carousel = {

	init : function() {
		// The slider being synced must be initialized first
		  $('#carousel').flexslider({
		    animation: "slide",
		    controlNav: false,
		    animationLoop: false,
		    slideshow: false,
		    itemWidth: 210,
		    itemMargin: 5,
		    asNavFor: '#slider'
		  });

		  $('#slider').flexslider({
		    animation: "slide",
		    controlNav: false,
		    animationLoop: false,
		    slideshow: false,
		    sync: "#carousel"
		  });
	}
}


$(document).ready(function() {
	Carousel.init();
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