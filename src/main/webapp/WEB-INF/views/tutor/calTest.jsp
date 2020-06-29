<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp" />

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>

<script>
$(function(){
    $("#apply_start").datepicker({
    	showOn: "both",
        buttonImage: "/resources/img/common/alram.png",
        buttonImageOnly: true,
        buttonText: "",
       	onSelect:function(dateText, inst) {
            console.log(dateText);
        }
    });
    
    $("#apply_end").datepicker({
        showOn: "both",
        buttonImage: "/resources/img/common/alram.png",
        buttonImageOnly: true,
        buttonText: "",
        onSelect:function(dateText, inst) {
            console.log(dateText);
        }
    });
});
</script>
<div id="subWrap" class="hdMargin">
   <section id="subContents">
      <article id="" class="inner1200">
	      <input type="text" id="apply_start" name="apply_start" size="12">
	      ~
	      <input type="text" id="apply_end" name="apply_end" size="12">
      </article>
   </section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />