//글쓰기 페이지
$(function(){
   var totalSize=0;
   var thumbnail = $("#thumbnail");
   
   /** 목록으로 돌이가기 **/
   $("#back").on("click",function(){
      location.href="/news/listProc";
   });
   
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
   
   //프로필
   $("#thumbnail").on('change',function(){
      //프로필 확장자 체크
      if(!/\.(gif|jpg|jpeg|png)$/i.test(thumbnail.val())){
         alert('썸네일은 gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + thumbnail.val());
         thumbnail.focus();
         thumbnail.val("");
         return false;
      }
      
      //프로필 용량
      var limit = 1024*1024*10;
      if(limit < thumbnail[0].files[0].size){
         alert("파일용량 10MB을 초과했습니다. 다른 파일로 변경해주세요");
         thumbnail.val("");
         return false;
      }
   });
   
   /** 첨부파일 **/
   var countf = 0;
   $("#addFile").click(function(){      
      if(countf<3){
         $("#fileSpace").append(
               "<div class='file_box'><input type='file' id='file"+countf+"' name='filesAll' class='files fileDelete'> <button type='button' class='minus'>-</button></div>"
         );
         ++countf;
      }else{
         alert("파일은 3개 까지 생성 가능합니다.");
      }      
   });
   
   $("#fileSpace").on("click",".minus",function(){
      $(this).parent().css('display','none');
      --countf;
   });
   
   //첨부파일 용량 제한하기
   $("#fileSpace").on('change','input[type=file]',function(e){
      if(!$(this).val()) {return false};
      var f = this.files[0];
      
      var size = f.size || f.fileSize;
      console.log(f.size + ":" +f.fileSize);
      var limit = 1024*1024*10; //바이트
      var limitAll = 1024*1024*30; //바이트
      if(size>limitAll){
         alert("총 파일용량이 30MB을 초과했습니다.");
         $(this).val("");
         return false;
      }
      totalSize = totalSize+size;
      console.log(totalSize);
   });
   
   //파일 첨부한거 지우기 / 사이즈도 같이지우기
   $("#fileSpace").on('click','.minus',function(e){
       var f = $(this).prev()[0].files[0];
       
       if(f==null){
            $(this).parent().remove();
            return false;
            
         }else{
            var size = f.size || f.fileSize;
            totalSize = totalSize-size;
            console.log(totalSize);
            $(this).parent().remove();
            return false;
         }
   });
   
   //보내기 전에 용량 체크
   $("#writeForm").submit(function(){
      
      var title = $("#title");
      var category = $('#category');
      var contents = $("#contents");
      var start = $("#apply_start");
      var end = $("#apply_end");
      var thumbnail = $("#thumbnail");

		if(title.val() == ""){
			alert("제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		
		if(category.val() == ""){
			alert("카테고리를 입력해주세요");
			$('#category').focus();
			return false;
		}
		
		if(start.val() != ""){
			if(end.val() == ""){
				alert("끝나는 기간을 알려주세요.");
				end.focus();
				return false;
			}
		}
		
		if(contents.val() == ""){
			alert("내용를 입력해주세요");
			$('div.note-editable').focus();
			return false;
		}
		
		//프로필 넣었는지 안넣었는지
		if(thumbnail.val() == ""){
			alert("썸네일을 입력해주세요");
			$('#thumbnail').focus();
			return false;
		}
		
		//파일 용량 체크
		var limit = 1024*1024*30;
		if(limit < totalSize){
			alert("파일용량 30MB을 초과했습니다. 파일을 삭제해주세요");
			return false;
		}
		if(thumbnail == ""){
			alert("썸네일을 입력해주세요");
			thumbnail.focus();
			return false;
		}
		
		
		var noteObj = $(".note-editable");
		var replaceId  = /(script)/gi;
		if(noteObj.text().match(replaceId)){
			alert("부적절한 내용이 들어가있습니다.")
			noteObj.focus();
			noteObj.html("")
			return false;
		}
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