<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

	<%@ include file="../include/header.jsp" %>

    <section>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <p>수정하기</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/freeboard/update" method="post" name="updateForm">   
                            <div class="form-group">
                                <input class="form-control" name="bno" value="${article.bno}" type="hidden">
                            </div>
                            <div class="form-group">
                                <label>작성자</label>
                                <input class="form-control" id="writer" name="writer" value="${article.writer}" readonly>
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" id="title" name="title" value="${article.title}" oninput="handleInputLength(this, 100)">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" id="content" rows="10" name="content" oninput="handleInputLength(this, 1000)">${article.content}</textarea>
                            </div>
                            
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input type="password" class="form-control" id="pw" name="pw" value="${article.pw}" oninput="handleInputLength(this, 15)">
                            </div>

                            <button type="button" id="listBtn" class="btn btn-dark">목록</button>    
                            <button type="button" id="updateBtn" class="btn btn-primary">변경</button>
                            <button type="button" id="delBtn" class="btn btn-info">삭제</button>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
        
        <%@ include file="../include/footer.jsp" %>
      
      <script>
        //목록 이동 처리
        document.getElementById('listBtn').onclick = function() {
            location.href="${pageContext.request.contextPath}/freeboard/freeList"
        }

        const titleInput = document.getElementById('title');
        const writerInput = document.getElementById('writer');
        const contentInput = document.getElementById('content');
        const pwInput = document.getElementById('pw');

        function hasBadWords(inputText){
            const badWordsRegex = /(바보|멍청이|똥깨)/gi;
            return badWordsRegex.test(inputText);
        }

        const $form = document.updateForm;

        //수정 버튼 이벤트 처리
        document.getElementById('updateBtn').onclick = function() {

            const titleValue = titleInput.value;
            const writerValue = writerInput.value;
            const contentValue = contentInput.value;
            const pwValue = pwInput.value;

            if($form.title.value === ''){
                alert('제목은 필수 항목');
                $form.title.focus();
                return;
            }    
            else if($form.content.value === ''){
                alert('내용은 필수 항목');
                $form.content.focus();
                return;
            }
            else if($form.pw.value === ''){
                alert('비밀번호는 필수 항목');
                $form.content.focus();
                return;
            }
            // 앞뒤 공백을 제거하고 빈 칸 여부 판단
        	else if (titleValue.trim() === '') {
        	    alert('공백만으로 글을 작성할 수 없습니다.(제목)');
				return;
				
        	} 
        	else if (writerValue.trim() === '') {
          	    alert('공백만으로 글을 작성할 수 없습니다.(작성자)');
  				return;
  				
          	}
        	else if (contentValue.trim() === '') {
          	    alert('공백만으로 글을 작성할 수 없습니다.(내용)');
  				return;
  				
          	}
        	else if (pwValue.trim() === '') {
            	    alert('공백만으로 글을 작성할 수 없습니다.(비밀번호)');
    				return;
    				
            	  }
            // 욕설이 포함된 경우
            else if (hasBadWords(titleValue) || hasBadWords(writerValue) || hasBadWords(contentInput)) {
                    alert('욕설이 포함되어 있습니다. 글을 등록할 수 없습니다.');
                    return;
                }
            else{
                titleInput.textContent = titleValue.trim();
                $form.submit();
            }
        }
        
        function handleInputLength(el, max) {
      	  if(el.value.length > max) {
      	    el.value = el.value.substr(0, max);
      	  }
      	}

        //삭제 버튼 이벤트 처리
        document.getElementById('delBtn').onclick = (e) =>{
            if(confirm('정말 삭제하시겠습니까?')) {
                $form.setAttribute('action', '${pageContext.request.contextPath}/freeboard/delete');
                // $form.setAttribute('method','post');
                $form.submit();
            }
        }
      </script>
      
      
      
      