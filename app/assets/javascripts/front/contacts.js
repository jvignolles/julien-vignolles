$(function() {
  function bindIndications() {
    $("#js-indications-source").click(function(e) {
      e.preventDefault();
      var link = $(this);
      $("#js-indications-target").show();
      link.hide();
    });
  }

  $(document).ready(function() {
    bindIndications();
  });
});

