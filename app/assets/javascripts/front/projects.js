$(function() {
  function bindProjectCarousel() {
    $('#js-carousel').flexslider({
      animation: "slide",
      controlNav: false,
      animationLoop: false,
      slideshow: false,
      itemWidth: 50,
      itemHeight: 50,
      itemMargin: 10,
      direction: "vertical",
      controlNav: false,
      prevText: "Précédente",
      nextText: "Suivante",
      asNavFor: '#js-slider'
    });
    $('#js-slider').flexslider({
      animation: "slide",
      controlNav: false,
      animationLoop: false,
      slideshow: false,
      prevText: "Précédente",
      nextText: "Suivante",
      sync: "#js-carousel"
    });
  }

  $(document).ready(function() {
    bindProjectCarousel();
  });
});
