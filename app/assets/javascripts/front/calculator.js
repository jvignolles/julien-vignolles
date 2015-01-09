$(function () {
  function initCalculator() {
    var total = 0; //volume total de tous les cartons, initiée à 0 pour l'incrémenter plus loin
    var result = null;
    //CALCUL DU TOTAL
    $("#js-packages .js-package").each(function () { //récup du contenu des inputs dont la class est "js-package"
      var pack = $(this);
      var nb = parseInt(Number(pack.val()));
      var volume = nb * parseInt(Number(pack.data("coef"))); //multiplie le nombre de carton par leur surface respective (coef)
      total += volume; //volume total
    });
    //RECHERCHE DES BOX CORRESPONDANTS
    $("#js-boxes .js-box").each(function () {
      var box = $(this);
      var surface = parseInt(Number(box.data("surface")));
      if (total <= surface) {
        result = box;
        return false;
      }
    });
    //AFFICHAGE DE RESULTAT / MESSAGE SI ERREUR 
    var message = "Merci de nous contacter";
    if (null != result) {
      message = result.find(".name").html() + " à " + result.find(".price").html() + " TTC/mois";
    }
    $("#js-calculator-result").html(message);
  }

  function bindCalculator() {
    $("#js-calculator-btn").click(function (e) {
      e.preventDefault();
      e.stopPropagation();
      initCalculator();
      $("#js-result-footer").show();
    });
    initCalculator();
  }

  function initDescriptionWrapper(checkbox) {
    if (checkbox.checked) {
      $("#js-description-wrapper").show();
      $("#js-booking-with-description").show();
      $("#js-booking-without-description").hide();
    } else {
      $("#js-description-wrapper").hide();
      $("#js-booking-with-description").hide();
      $("#js-booking-without-description").show();
    }
  }

  function bindDescriptionWrapper() {
    var checkbox = $("#js-with-description-checkbox");
    checkbox.change(function() {
      if (this.checked) {
        $("#js-description-wrapper").show();
        $("#js-booking-with-description").show();
        $("#js-booking-without-description").hide();
      } else {
        $("#js-description-wrapper").hide();
        $("#js-booking-with-description").hide();
        $("#js-booking-without-description").show();
      }
    });
    initDescriptionWrapper(checkbox);
  }

  $(document).ready(function () {
    bindCalculator();
    bindDescriptionWrapper();
  });
});

