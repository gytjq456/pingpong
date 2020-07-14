$(function () {
    var mainVisual = $("#mainVisual");
    var winH = $(window).height();
    var winW = $(window).width();
    var headerH = $("header").height();


    // 메인 비주얼 slick slide
    $('#mainVisual .visu').slick({
        fade: true,
        autoplay: true,
        autoplaySpeed: 7000,
        infinite: true,
        dots: true,
        arrows: true,
        speed: 1000,
        swipe: false,
        pauseOnFocus: false,
        cssEase: 'cubic-bezier(0.7, 0, 0.3, 1)',
        focusOnSelect: false,
        pauseOnHover: false
    });
    
    var chatList = $("#partnerList");
    personList("partner");
    $("#tab_s3 li").click(function(){
    	
    	$("#tab_s3 li").removeClass("on");
    	$(this).addClass("on");
    	var data = $(this).data("type");
    	personList(data);
    })
    function personList(type){
    	$.ajax({
    		url:"/member/personList",
    		type:"post",
    		dataType:"json",
    		data:{
    			type:type
    		}
    	}).done(function(resp){
    		console.log(resp);
    		chatList.find(".list").html("");
    		var userTag = $("<ul class='clearfix'>");
    		for(var i=0; i<resp.length; i++){
    			var userInfo_s1 = $("<div class='userInfo_s1'>");
    			var li = $("<li>");
    			userInfo_s1.append("<div class='thumb'><img src='/update/mamber/"+resp[i].id+"/"+resp[i].sysname+"'>")
    			userInfo_s1.append("<div class='info'><p class='userId'>"+resp[i].name+"("+resp[i].age+"세)</p><p class='txt'>"+resp[i].introduce+"</p>")
    			li.append(userInfo_s1)
    			userTag.append(li)    		
    			chatList.find(".list").append(userTag);
    		};
    		if(chatList.find(".list li").length > 4){
    				$('#personList .list ul').not(".slick-initialized").slick({
    					slidesToShow:4,
    					slidesToScroll:1,    		    
    					autoplay: true,
    					autoplaySpeed: 7000,
    					infinite: true,
    					dots: false,
    					arrows: true,
    					speed: 1000,
    					swipe: false,
    					pauseOnFocus: false,
    					cssEase: 'cubic-bezier(0.7, 0, 0.3, 1)',
    					focusOnSelect: false,
    					pauseOnHover: false
    				});   			
    		}
    	})
    }
    
    


})
