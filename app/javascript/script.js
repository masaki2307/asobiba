/*global $ */
$(document).on('turbolinks:load', function() {
  
  $(".modal-open").on('click',function() {
    $(".modal-overlay").fadeIn("fast");
  });
  
  $(".modal-close").on("click", function(){
    $(".modal-overlay").fadeOut("fast");
  });
 
});

