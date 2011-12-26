//= require jquery.js
//= require jquery_ujs
//= require gko/externals/innershiv
//= require gko/externals/jquery.easing.1.3
//= require gko/externals/jquery.imagesloaded
//= require gko/externals/jquery.elastislide
//= require gko/externals/jquery.elastidegallery
//= require modernizr.custom.72835
//= require gko/externals/jquery.circlemouse


$(document).ready(function() {
	Gallery.init($('.images:first')); 
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