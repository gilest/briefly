var currentFocusInt = 0;

function moveUp() {
	currentFocusInt--;
	if(currentFocusInt<1){ currentFocusInt = 1 }
	$('#'+currentFocusInt).focus();
}

function moveDown() {
	numberArticlesInt = $('.article').length;
	currentFocusInt++;
	if(currentFocusInt>numberArticlesInt){ currentFocusInt = numberArticlesInt }
	$('#'+currentFocusInt).focus();
}

$(document).shortkeys({
  'j': function () { moveDown(); },
  'k': function () { moveUp(); }
});