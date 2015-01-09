$(function() {
  function bindProductCategories() {
    $('#js-product-categories').click(function(e) {
      e.preventDefault();
      e.stopPropagation();
      var menu = $(e.target);
      var source = menu.closest('a');
      if (!source.length) return;
      if (!source.hasClass('active')) {
        $('#js-product-categories a').removeClass('active');
        source.addClass('active');
      }
      var id = source.data('id');
      $('#js-products .product-thumb').each(function (index) {
        var product = $(this);
        if ('' == id || product.data('category') == id) {
          product.removeClass('not-visible');
        } else {
          product.addClass('not-visible');
        }
      });
    });
  }

  $(document).ready(function() {
    bindProductCategories();
  });
});

