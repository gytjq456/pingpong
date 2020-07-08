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
    	chatList.find(".list ul").html("");
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
    		
    		for(var i=0; i<resp.length; i++){
    			var userTag = $("<li>");
    			var userInfo_s1 = $("<div class='userInfo_s1'>");
    			var info = $("<div class='info'>"); 
    			userInfo_s1.append("<div class='thumb'><img src='/resources/img/sub/userThum.jpg'>")
    			userInfo_s1.append("<div class='info'><p class='userId'>"+resp[i].name+"("+resp[i].age+"세)</p><p class='txt'>"+resp[i].introduce+"</p>")
    			userTag.append(userInfo_s1)    		
    			chatList.find(".list ul").append(userTag);
    		};
    	})
    }

})
