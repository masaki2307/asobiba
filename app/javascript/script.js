/*global $ */
/*global raty */
$(document).on('turbolinks:load', function() {
  $("#modal-open").on('click',function() {
     $("#modal-overlay").fadeIn("fast");
  });
  
  $("#modal-close").on("click", function(){
      $("#modal-overlay").fadeOut("fast");
  });
  
  $(".genre_link").on("click", function(){
      $("#modal-overlay").hide();
  });
 
});

$(document).on('turbolinks:load', function() {
  
  $("#duration-open").on('click',function() {
    $("#duration-overlay").fadeIn("fast");
  });
  
  $("#duration-close").on("click", function(){
    $("#duration-overlay").fadeOut("fast");
  });
  
  $(".duration_link").on("click", function(){
      $("#duration-overlay").hide();
  }); 
  
});

$(document).on('turbolinks:load', function() {
  
  $(".confirm-open").on('click',function() {
    $(".confirm-overlay").fadeIn("fast");
  });
  
  $(".confirm-action").on("click", function(){
    $(".delete")[0].click();
  });
  
  $(".confirm-close").on("click", function(){
    $(".confirm-overlay").fadeOut("fast");
  });
  

});
