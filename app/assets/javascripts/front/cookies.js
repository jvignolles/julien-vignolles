$(function() {
  function bindCookiePopin() {
    "En continuant à naviguer sur ce site, vous acceptez l’utilisation de cookies assurant le bon fonctionnement de nos services et de permettant des statistiques anonymes d’audiences."
    $("#js-indications-source").click(function(e) {
      e.preventDefault();
      var link = $(this);
      $("#js-indications-target").show();
      link.hide();
    });
  }

  $(document).ready(function() {
    bindCookiePopin();
  });
});

