
$(function() {
	// Mobile menu
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

	// Show mobile menu on window resize
	$(window).resize(function(){
		var w = $(window).width();
		if(w > 320 && menu.css('visibility') === 'hidden') {
			menu.removeAttr('style');
		}
	});
});

// PGP Guide tab layout
function tabs() {
	var osxCheckbox = $('#checkbox-osx');
	var windowsCheckbox = $('#checkbox-windows');
	var linuxCheckbox = $('#checkbox-linux');

	var osx = $('#osx');
	var windows = $('#windows');
	var linux = $('#linux');

	if (osxCheckbox.prop('checked')) {
		windows.css('display', 'none');
		linux.css('display', 'none');
		osx.css('display', 'block');
	}

	if (windowsCheckbox.prop('checked')) {
		osx.css('display', 'none');
		linux.css('display', 'none');
		windows.css('display', 'block');
	}

	if (linuxCheckbox.prop('checked')) {
		windows.css('display', 'none');
		osx.css('display', 'none');
		linux.css('display', 'block');
	}
}
	