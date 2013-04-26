//= require jquery
//= require jquery_ujs
//= require gko/public/jquery.grid.responsive.js
//= require gko/public/jquery.bootstrap.navbarhover.js
//= require twitter.bootstrap.2.2.1/bootstrap/transition.js
//= require twitter.bootstrap.2.2.1/bootstrap/alert.js
//= require twitter.bootstrap.2.2.1/bootstrap/button.js
//= require twitter.bootstrap.2.2.1/bootstrap/collapse.js
//= require twitter.bootstrap.2.2.1/bootstrap/dropdown.js
//= require twitter.bootstrap.2.2.1/bootstrap/modal.js
//= require twitter.bootstrap.2.2.1/bootstrap/tooltip.js
//= require twitter.bootstrap.2.2.1/bootstrap-datepicker.js
//= require twitter.bootstrap.2.2.1/bootstrap-timepicker.js
//= require flexslider/jquery.flexslider.js
//= require jquery.categoriesFilter
//= require modernizr.custom.72835
//= require circlemouse

var Carousel = {

	init : function() {  
	  if ($('#carousel li').length > 1) { 
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
    } else {
			$('#carousel').hide();
			$('.flexslider .slides > li').css('display', 'block');
		}
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