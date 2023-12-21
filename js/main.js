$(document).ready(function(){
    
    $(window).scroll(function(){
		$("#txt1").text($(this).scrollTop());
    
	});
  $(window).scroll(function(){
    //#p2
    if($(this).scrollTop()>=4400){
      $("#quick_pc").css({"opacity":"0"});
    }else{
      $("#quick_pc").css({"opacity":"1"});
    }

});

  $(document).ready(function() {
    $('input, textarea').placeholder();
  });

  $(window).resize(function(){ 
    if (window.innerWidth < 1199) {  

    $(window).scroll(function(){
      if($(this).scrollTop()>=0){
        $("#quick_pc").css({"opacity":"0"});
      }else{
        $("#quick_pc").css({"opacity":"0"});
      }
  
  });
    
    } else {
    
    /* 스크립트내용*/ 
    
    }
    
    }).resize(); 



  $(window).resize(function(){ 
    if (window.innerWidth < 720) {  
    
    /* 스크립트내용*/ 
    $("#p1 img").attr('src', 'image/Mobile.png');
    $("#p2 img").attr('src', 'image/mo_02.png');
    $("#p3 .img3").attr('src', 'image/mo_03.png');
    $("#p4 .img4").attr('src', 'image/mo_04.png');
    $("#p5 .img5").attr('src', 'image/mo_05.png');
    $("#p6 .img6").attr('src', 'image/mo_06.png');
    $("#p7 img").attr('src', 'image/mo_07.png');
    $("#p8 img").attr('src', 'image/back.png');
    $(".result img").attr('src', 'image/re-mo.png');
    
    } else {
    
    /* 스크립트내용*/ 
    
    }
    
    }).resize(); 













































































































});




