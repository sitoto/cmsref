// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//
//
$(document).ready(function(){
	$('#nav li').hover(
		function(){
		$('ul',this).slideDown(100);
		},
		function(){
		$('ul',this).slideUp(100);
		}
		);
});

//for slider
$(document).ready(function(){  
  $("#slider").easySlider({
    auto: true, 
    speed: 500,
    pause: 5500,
    continuous: true
  });
});  


//for topnav
$(document).ready(function() {
  function megaHoverOver(){
    $(this).find(".sub").stop().fadeTo('fast', 1).show();
      
    //Calculate width of all ul's
    (function($) { 
      jQuery.fn.calcSubWidth = function() {
        rowWidth = 0;
        //Calculate row
        $(this).find("ul").each(function() {          
          rowWidth += $(this).width(); 
        });  
      };
    })(jQuery); 
    
    if ( $(this).find(".row").length > 0 ) { //If row exists...
      var biggestRow = 0;  
      //Calculate each row
      $(this).find(".row").each(function() {                 
        $(this).calcSubWidth();
        //Find biggest row
        if(rowWidth > biggestRow) {
          biggestRow = rowWidth;
        }
      });
      //Set width
      $(this).find(".sub").css({'width' :biggestRow});
      $(this).find(".row:last").css({'margin':'0'});
      
    } else { //If row does not exist...
      
      $(this).calcSubWidth();
      //Set Width
      $(this).find(".sub").css({'width' : rowWidth});
      
    }
  }
  
  function megaHoverOut(){ 
    $(this).find(".sub").stop().fadeTo('fast', 0, function() {
      $(this).hide(); 
    });
  }

  var config = {    
     sensitivity: 1, // number = sensitivity threshold (must be 1 or higher)    
     interval: 5, // number = milliseconds for onMouseOver polling interval    
     over: megaHoverOver, // function = onMouseOver callback (REQUIRED)    
     timeout: 5, // number = milliseconds delay before onMouseOut    
     out: megaHoverOut // function = onMouseOut callback (REQUIRED)    
  };

  $("ul#topnav li .sub").css({'opacity':'0'});
  $("ul#topnav li").hoverIntent(config);

});
 
