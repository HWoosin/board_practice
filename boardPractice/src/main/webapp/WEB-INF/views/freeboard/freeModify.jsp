<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/js/bootstrap.js"></script>

    <section>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <p>수정하기</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/freeboard/update" method="post" name="updateForm" onsubmit="return false" enctype="multipart/form-data">   
                            <div class="form-group">
                                <input type="hidden" name="bno" value="${article.bno}">
                                <input type="hidden" name="originBno" value="${article.originBno}">
                                <input type="hidden" name="parentBno" value="${article.parentBno}">
                                <input type="hidden" name="groupOrd" value="${article.groupOrd}">
                                <input type="hidden" name="groupLayer" value="${article.groupLayer}">
                            </div>
                            <div class="form-group">
                                <label>작성자</label>
                                <textarea class="form-control ellipsis" id="writer" rows="1" name="writer" readonly><c:out value="${article.writer}"></c:out></textarea>
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <textarea class="form-control ellipsis" id="title" rows="1" name="title" oninput="handleTitleLength(this, 100)" onblur="trimInput(this)"><c:out value="${article.title}"></c:out></textarea>
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <span id="textLengthCheck"></span>
                                <textarea class="form-control" id="content" rows="10" name="content" oninput="handleContentLength(this, 1000); countWords(this, 1000)"><c:out value="${article.content}"></c:out></textarea>
                            </div>

                            <div class="form-group">
                                <!-- 파일 업로드 폼입니다 -->
                                <div class="reply-content">
                                    <div class="reply-group">
                                        <div class="filebox pull-left">
                                            <label for="file" id="updatefiles">파일 업로드 ➕</label>
                                            <input type="file" name="file" id="file" style="display:none;" multiple>
                                            <div class="file-list">
                                                <c:forEach var="file" items="${fileInfo}">
                                                    <div>
                                                        <p>${file.fileRealName}</p>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 파일 업로드 폼 끝 -->
                            </div>
                            
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input type="password" class="form-control" placeholder="(대/소)영문/특수문자 포함 8자~10자 입력가능." id="pw" name="pw" value="${article.pw}" oninput="handlePWLength(this, 10)" onblur="trimInput(this)" onkeydown="preventSpace(event)">
                            </div>

                            <button type="button" id="listBtn" class="btn btn-dark">목록</button>    
                            <button type="button" id="updateBtn" class="btn btn-primary">변경</button>
                            <button type="button" id="delBtn" class="btn btn-info">삭제</button>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
        
      
      <script>
        //목록 이동 처리
        document.getElementById('listBtn').onclick = function() {
            location.href="${pageContext.request.contextPath}/freeboard/freeList"
        }

        const titleInput = document.getElementById('title');
        const writerInput = document.getElementById('writer');
        const contentInput = document.getElementById('content');
        const pwInput = document.getElementById('pw');
        const passwordRegex =  /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[$@!%*#?&])[a-zA-Z0-9$@!%*#?&]{8,10}$/; //최소 8 자 및 최대 10 자, 하나 이상의 대문자, 하나의 소문자, 하나의 숫자 및 하나의 특수 문자 정규식


        function hasBadWords(inputText){
                const badWordsRegex = /(바보|멍청이|똥깨|씨발|개새끼|시발|OR|SELECT|INSERT|DELETE|UPDATE|CREATE|DROP|EXEC|UNION|FETCH|DECLARE|TRUNCATE)/gi;//파일처리하면 더 좋을것같음.
                return badWordsRegex.test(inputText);
            }

        //입력에 따라 textarea 변함
        const contentTextarea = document.getElementById('content');
            function adjustTextareaHeight() {
                contentTextarea.style.height = 'auto';
                contentTextarea.style.height = contentTextarea.scrollHeight + 'px';
            }

            contentTextarea.addEventListener('input', adjustTextareaHeight);
            window.addEventListener('load', adjustTextareaHeight);


        function updateCharacterCount() {
            let content = $("#content").val();
            $("#textLengthCheck").text(content.length + " / 1000");
        }
            
        //글자 수 세기
        function countWords(textarea, maxLength) {
            let text = textarea.value;
            let currentLength = text.length;
            let remainingLength = maxLength - currentLength;
            let lengthCheckSpan = document.getElementById('textLengthCheck');
            lengthCheckSpan.textContent = currentLength > maxLength ? maxLength + ' / ' + maxLength : currentLength + ' / ' + maxLength;
                
                if (currentLength > maxLength) {
                    textarea.value = textarea.value.substring(0, maxLength);
                }
        }

        //파일등록
        const fileInput = document.getElementById('file');
            const fileListBox = document.querySelector('.file-list');
            const form = document.getElementById('upload-form');
            const formData = new FormData();
            const selectedFiles = [];

            fileInput.addEventListener('change', function() { //목록 보여주기
                fileListBox.innerHTML = ''; // 이전 파일 목록 지우기

                const newSelectedFiles = Array.from(fileInput.files);

                for (let i = 0; i < newSelectedFiles.length; i++) {
                    const file = newSelectedFiles[i];
                    selectedFiles.push(file);

                    const fileDiv = createFileDiv(file);
                    fileListBox.appendChild(fileDiv);
                    console.log(selectedFiles[i]);
                }
            });

            function createFileDiv(file) {
                const fileDiv = document.createElement('div');
                const fileNameSpan = document.createElement('p');
                fileNameSpan.textContent = file.name;

                fileDiv.appendChild(fileNameSpan);
                return fileDiv;
            }

        const $form = document.updateForm;

        //수정 버튼 이벤트 처리
        document.getElementById('updateBtn').onclick = function() {

            const titleValue = titleInput.value;
            const writerValue = writerInput.value;
            const contentValue = contentInput.value;
            const pwValue = pwInput.value;

            if(writerValue === ''){
                alert('작성자는 필수 항목');
                $form.writer.focus();
                return;
            }    
            else if(titleValue === ''){
                alert('제목은 필수 항목');
                $form.title.focus();
                return;
            }
            else if(contentValue === ''){
                alert('내용은 필수 항목');
                $form.content.focus();
                return;
            }
            else if(pwValue === ''){
                    alert('비밀번호는 필수 항목');
                    $form.pw.focus();
                    return;
                }
            // 앞뒤 공백을 제거하고 빈 칸 여부 판단
            else if (writerValue.trim() === '') {
                  alert('공백만으로 글을 작성할 수 없습니다.(작성자)');
                  return;
                  
              }
        	else if (titleValue.trim() === '') {
        	    alert('공백만으로 글을 작성할 수 없습니다.(제목)');
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
            // 욕설이 포함된 경우, sql 문 막기
            else if (hasBadWords(titleValue) || hasBadWords(writerValue) || hasBadWords(contentValue)) {
                    alert('사용할 수 없는 단어가 포함되어 있습니다. 글을 등록할 수 없습니다.');
                    return;
                }
            else if (!passwordRegex.test(pwValue)) {
                    const pwErrorMsg = document.getElementById('pwErrorMsg');
                    alert('비밀번호는 (대/소)영문/특수문자 포함 8자~10자여야 합니다.');
                    pwInput.focus();
                    return;
                }
            else{
                titleInput.textContent = titleValue.trim();

                selectedFiles.forEach(file => {
                        formData.append('files[]', file);
                    });

                $form.submit();
            }
        }
            //제목 글자수 제한
            function handleTitleLength(el, max) {
                const trimmedValue = el.value.trim();
                if(trimmedValue.length > max) {
                    el.value = el.value.substr(0, max);
                    alert('100자를 넘었습니다.')
                }
            }
            //내용 글자수 제한
            function handleContentLength(el, max) {
                const trimmedValue = el.value.trim();
                if(trimmedValue.length > max) {
                    el.value = el.value.substr(0, max);
                    alert('1000자를 넘었습니다.')
                }
            }
            //비밀번호 글자수 제한
            function handlePWLength(el, max) {
                const trimmedValue = el.value.trim();
                if(trimmedValue.length > max) {
                    el.value = el.value.substr(0, max);
                    alert('10자를 넘었습니다.')
                }
            }
        //글자 submit 전 trim
        function trimInput(el) {
                el.value = el.value.trim();
        }

        //비밀번호칸에 스페이스바 입력 금지
        function preventSpace(event) {
            var keyCode = event.keyCode ? event.keyCode : event.which;

            if (keyCode === 32) {
                event.preventDefault();
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
      
      
      
      