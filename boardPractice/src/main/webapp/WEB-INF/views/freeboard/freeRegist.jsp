﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
	<%@ include file="../include/header.jsp" %>
    <section>
       <div class="container">
            <div class="row">
                <div class="col-xs-12 content-wrap">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    
                     <form action="${pageContext.request.contextPath}/freeboard/regist" method="post" name="registForm">   
                         
                            <div class="form-group">
                                <label>작성자</label>
                                <input class="form-control" name="writer" oninput="handleInputLength(this, 15)">
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control " name="title" oninput="handleInputLength(this, 100)">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" rows="10" name="content" oninput="handleInputLength(this, 1000)"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input class="form-control input-sm" name="pw">
                            </div>

                            <button type="button" id="listBtn" class="btn btn-dark">목록</button>    
                            <button type="button" id="registBtn" class="btn btn-primary">등록</button>

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

        const $form = document.registForm;

        //수정 버튼 이벤트 처리
        document.getElementById('registBtn').onclick = function() {
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
            else if($form.writer.value === ''){
                alert('작성자는 필수 항목');
                $form.writer.focus();
                return;
            }
            else{
                $form.submit();
            }
        }
        
        function handleInputLength(el, max) {
        	  if(el.value.length > max) {
        	    el.value = el.value.substr(0, max);
        	  }
        	}

      </script>
  