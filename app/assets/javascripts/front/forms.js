$(function() {
  var defaultFormat;
  var __slice = [].slice;
  defaultFormat = $.fn.select2.defaults.formatResult;
  function bindSelect2() {
    $("select.select2").select2({
      width: 'off',
      formatResult: function() {
        var item, remainder;
        item = arguments[0], remainder = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        if ($(item.element).attr('disabled')) { return; }
        return defaultFormat.apply(null, [item].concat(__slice.call(remainder)));
      }
    });
  }

  $(document).ready(function() {
    bindSelect2();
  });
});
