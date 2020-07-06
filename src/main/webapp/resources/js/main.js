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

})
