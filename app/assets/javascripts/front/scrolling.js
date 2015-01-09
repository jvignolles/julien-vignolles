//DivPeek - Custom jQuery CSS3 Animation Trigger Script by David Halford
//(see https://github.com/davidhalford/DivPeek)
//===============================================================================
//CONFIG: 
var elementsToTrack = [".fade-in"];

var pixelOffset = 0;
var inClassName = "in-viewport";
var outClassName = "out-viewport";
//===============================================================================

//add function to see of elements exist (otherwise removing an elemnet from DOM but not from array breaks everything)
jQuery.fn.exists = function() { return this.length > 0; }

//define vars out of scope
var viewPortHeight = $(window).height();
var scrollFromTop = $(window).scrollTop();
var scrollFromBottom = (parseInt(scrollFromTop) + parseInt(viewPortHeight));

//function for recalculating all positioning vars in scroll/resize
function recalcVars() {
  viewPortHeight = $(window).height();
  scrollFromTop = $(window).scrollTop();
  scrollFromBottom = (parseInt(scrollFromTop) + parseInt(viewPortHeight));
  for (var i = 0; i < elementsToTrack.length; i++) {
    if ($(elementsToTrack[i]).exists()) {
      checkInViewport(scrollFromBottom, elementsToTrack[i]);
    }
  }
}

//catch window events
$(window).on('resize', _.debounce(recalcVars, 250));
document.addEventListener("touchmove", _.debounce(recalcVars, 250), false);
document.addEventListener("scroll", _.debounce(recalcVars, 250), false);

//function that handles if an element is in the viewport or not 
function checkInViewport(scrollBottom, domElement) {
  var elementPos = $(domElement).offset().top;
  if ((parseInt(scrollBottom) + parseInt(pixelOffset)) > elementPos) {
    $(domElement).addClass(inClassName).removeClass(outClassName);
  } else {
    $(domElement).removeClass(inClassName).addClass(outClassName);
  }
}

$(document).ready(function() {
  recalcVars();
});

