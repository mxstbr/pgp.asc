
$(function() {
	var pull 		= $('#pull');
		menu 		= $('nav ul');
		menuHeight	= menu.height();

	$(pull).on('click', function(e) {
		e.preventDefault();
		if (menu.css('visibility') === 'visible') {
			menu.css('visibility', 'hidden');
			menu.css('opacity', '0.0');
		} else {
			menu.css('visibility', 'visible');
			menu.css('opacity', '1.0');
		}
	});

	$(window).resize(function(){
		var w = $(window).width();
		if(w > 320 && menu.css('visibility') === 'hidden') {
			menu.removeAttr('style');
		}
	});
});
	