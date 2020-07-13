//글쓰기 페이지
$(function(){
	/** 타이틀 숫자 카운트 **/
	$("#title").keyup(function(e){
		var word = $("#title").val();
		var wordSize = word.length;
		if(wordSize <= 100){
			$('.current').text(wordSize);
		}else{
			word = word.substr(0,100);
			$(this).val(word);
			$('.current').text(word.length);
			alert("100자 이하로 등록해 주세요.");
		}
	});
	
	/** 달력 **/
	//오늘 날짜를 출력
    $("#today").text(new Date().toLocaleDateString());

    //datepicker 한국어로 사용하기 위한 언어설정
    $.datepicker.setDefaults($.datepicker.regional['ko']);
    
    //시작일.
    $('#apply_start').datepicker({
        dateFormat: "yy-mm-dd",             // 날짜의 형식
        minDate: 0,
        onClose: function( selectedDate ) {    
            // 시작일(apply_start) datepicker가 닫힐때
            // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#apply_end").datepicker( "option", "minDate", selectedDate );
        }                
    });

    //종료일
    $('#apply_end').datepicker({
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        onClose: function( selectedDate ) {
            // 종료일(toDate) datepicker가 닫힐때
            // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
            $("#apply_start").datepicker( "option", "maxDate", selectedDate );
        }                
    });
	
	
	/** 다음 지도 **/
	$("#postbtn").click(function(){
		/* Daum map */
		// 우편번호 찾기 찾기 화면을 넣을 element
	    var element_wrap = document.getElementById('wrap');
	    foldDaumPostcode(element_wrap)
	    sample3_execDaumPostcode(element_wrap);
	});
	
	/** 썸머노트 **/
	$('#contents').summernote({
		height: 400,
		lang: "ko-KR",
		callbacks: {
			onImageUpload: function(files) {
				uploadSummernoteImageFile(files[0], this);
			}
		}
	})
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/summerNote/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
	        	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}
	
	/** 첨부파일 삭제 **/
	$(".x").click(function(){
		var data_seq = $(this).data('seq');
		var files_name = $(this).data('files_name');
		alert(data_seq);
		
		$.ajax({
			type : "post",
			url : "/news/dele_fileOne",
			data:{
				seq : data_seq,
				files_name : files_name,
				category : "news"
			}
		}).done(function(resp){
			alert(resp);
			if(resp>0){
				alert("첨부파일이 삭제되었습니다.");
				location.href="/news/modify?seq="+data_seq;
			}
			
		}).fail(function(error1,error2){
			alert("관리자에게 문의주세요.")
		});
	});
	
	/** 첨부파일 **/
	var countf = 0;
	$("#addFile").click(function(){	
		var count = $(".f_all ul li").length;
		if(count<3){
			$("#fileSpace").append(
					"<div class='file_box'><input type='file' name='files' class='files'> <button type='button' class='minus'>-</button></div>"
			);
		}else{
			alert("파일은 3개 까지 생성 가능합니다.");
		}		
	});
	
	$("#fileSpace").on("click",".minus",function(){
		$(this).parent().css('display','none');
		--count;
	});
	
});


//다음 지도
function foldDaumPostcode(element_wrap) {
    // iframe을 넣은 element를 안보이게 한다.
    element_wrap.style.display = 'none';
}

//다음 지도
function sample3_execDaumPostcode(element_wrap) {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
               // document.getElementById("sample3_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample3_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample3_postcode').value = data.zonecode;
            document.getElementById("sample3_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            //document.getElementById("sample3_detailAddress").focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_wrap.style.display = 'none';

            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size) {
            element_wrap.style.height = size.height+'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);

    // iframe을 넣은 element를 보이게 한다.
    element_wrap.style.display = 'block';
}
