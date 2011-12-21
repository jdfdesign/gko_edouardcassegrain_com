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
	$('.circle').circlemouse({
		onMouseEnter	: function( el ) {
			el.addClass('ec-circle-hover');
		},
		onMouseLeave : function( el ) {
			el.removeClass('ec-circle-hover');
		},
		onClick : function( el ) {
			//$loader.show();
		}
	}); 
});