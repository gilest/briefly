// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

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