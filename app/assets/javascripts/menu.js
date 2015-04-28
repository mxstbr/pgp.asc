
function showMenu(e) {
	// Mobile menu
	var menu 		= $('nav ul');
	var menuHeight	= menu.height();
	if (menu.css('visibility') === 'visible') {
		menu.css('visibility', 'hidden');
		menu.css('opacity', '0.0');
	} else {
		menu.css('visibility', 'visible');
		menu.css('opacity', '1.0');
	}
}

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