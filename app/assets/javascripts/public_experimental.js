/*
//= require jquery
//= require jquery_ujs
//= require gko/externals/innershiv
//= require gko/externals/jquery.easing.1.3
//= require gko/externals/jquery.imagesloaded
//= require gko/externals/jquery.elastislide
//= require gko/externals/jquery.elastidegallery
//= require modernizr.custom.72835
//= require gko/externals/jquery.circlemouse
*/


$(document).ready(function() {
	Gallery.init($('.images:first'));
	var $loader = $('<div id="loader" class="loader"></div>').prependTo($('body')),
			$bubble = $('<div class="bubble"><img id="bubble" src="images/bubble.png" alt=""/></div>').appendTo($('body')),
			$js_container_wrapper = $('<div class="row" id="js_container_wrapper"><div id="js_container" class="twelve_column"></div><a href="#" id="close_js_container_wrapper">Close</a></div>').prependTo($('#wrapper-wide-main .wrapper-content:first'));
	$('.circle').circlemouse({
		onMouseEnter	: function( el ) {
			el.addClass('ec-circle-hover');
		},
		onMouseLeave : function( el ) {
			el.removeClass('ec-circle-hover');
		},
		onClick : function( el ) {
			$loader.show();
		}
	});
  $('.circle')
	.bind("ajax:complete", function(event, xhr, status) {
		console.log('complete');
		$loader.hide();
	})	
	.bind('ajax:success', function(evt, data, status, xhr){ 
		console.log('success' + eval(xhr.responseText).html());
		//margin_circle is the diameter for the 
		//bubble image
		var w_w				= $(window).width(),
			w_h				= $(window).height(),
			margin_circle	= w_w + w_w/3;
		if(w_h>w_w)
			margin_circle	= w_h + w_h/3;
		//animate the bubble image
		$bubble.stop().animate({
			'width'		:	margin_circle + 'px',
			'height'	:	margin_circle + 'px',
			'marginTop'	:	-margin_circle/2+'px',
			'marginLeft':	-margin_circle/2+'px'
		},700,function(){
			//solve resize problem
			//$('BODY').css('background','#FFD800');
		});
		$("#circles").stop().fadeOut(500);
		$("#js_container").stop().fadeOut(500).html(eval(xhr.responseText)).fadeIn(500);
		Gallery.init($('.images:first')); 
	})
	.bind('ajax:error', function(evt, xhr, status, error){
		console.log('error' + error);
	}); 
});