/*global $ */
$(document).on('turbolinks:load', function() {
  
  $(".modal-open").on('click',function() {
    $(".modal-overlay").fadeIn("fast");
  });
  
  $(".modal-close").on("click", function(){
    $(".modal-overlay").fadeOut("fast");
  });
 
});

$(document).on('turbolinks:load', function() {
  
  $(".duration-open").on('click',function() {
    $(".duration-overlay").fadeIn("fast");
  });
  
  $(".duration-close").on("click", function(){
    $(".duration-overlay").fadeOut("fast");
  });
 
});