<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
	
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/js/bootstrap.js"></script>

    <section>
       <div class="container">
            <div class="row">
                <div class="col-xs-12 content-wrap">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    
                     <form action="${pageContext.request.contextPath}/freeboard/regist" method="post" name="registForm" onsubmit="return false" enctype="multipart/form-data">   
                         
                            <div class="form-group">
                                <label>작성자</label>
                                <input class="form-control" id="writer" name="writer" placeholder="최대 15자 입력가능." oninput="handleWriterLength(this, 15)" onblur="trimInput(this)">
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input type="text" class="form-control" id="title" name="title" placeholder="최대 100자 입력가능." oninput="handleTitleLength(this, 100)" onblur="trimInput(this)">
                                <!-- <textarea class="form-control" id="title" rows="1" placeholder="최대 100자 입력가능." name="title" oninput="handleTitleLength(this, 100)" onblur="trimInput(this)"></textarea> -->

                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <span id="textLengthCheck">0 / 1000</span>
                                <textarea class="form-control" id="content" rows="10" placeholder="최대 1000자 입력가능." name="content" oninput="handleContentLength(this, 1000); countWords(this, 1000)"></textarea>
                            </div>

                            <div class="form-group">
                                <!-- 파일 업로드 폼입니다 -->
                                    <div class="reply-group">
                                        <div class="filebox pull-left">
                                            <label for="file">파일 업로드</label>
                                            <input type="file" name="file" id="file" multiple>
                                            <div class="file-list"></div>
                                        </div>
                                    </div>
                                <!-- 파일 업로드 폼 끝 -->
                            </div>
                            
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input type="password" class="form-control input-sm" id="pw" name="pw" placeholder="(대/소)영문/특수문자 포함 8자~10자 입력가능." oninput="handlePWLength(this, 10)" onblur="trimInput(this)" onkeydown="preventSpace(event)">
                            </div>

                            <button type="button" id="listBtn" class="btn btn-dark">목록</button>    
                            <button type="button" id="registBtn" class="btn btn-primary">등록</button>

                    </form>
                    
                </div>
            </div>    
       </div>
    </section>
    
    
    <script>

            const registBtn = document.getElementById('registBtn');
            //목록 이동 처리
            document.getElementById('listBtn').onclick = function() {
                location.href="${pageContext.request.contextPath}/freeboard/freeList"
            }

            const $form = document.registForm;
            const titleInput = document.getElementById('title');
            const writerInput = document.getElementById('writer');
            const contentInput = document.getElementById('content');
            const pwInput = document.getElementById('pw');

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

            //파일 목록 띄우기
            const fileInput = document.getElementById('file');
            const fileListBox = document.querySelector('.file-list');

            fileInput.addEventListener('change', function() {
                fileListBox.innerHTML = ''; // 이전 파일 목록 지우기

                const selectedFiles = fileInput.files;

                for (let i = 0; i < selectedFiles.length; i++) {
                    const file = selectedFiles[i];
                    const fileDiv = document.createElement('div');
                    
                    const fileNameSpan = document.createElement('span');
                    fileNameSpan.textContent = file.name;
                    
                    const deleteButton = document.createElement('button');
                    deleteButton.textContent = 'Delete';
                    deleteButton.addEventListener('click', function() {
                        fileDiv.remove(); // 해당 파일 요소 삭제
                    });

                    fileDiv.appendChild(fileNameSpan);
                    fileDiv.appendChild(deleteButton);
                    fileListBox.appendChild(fileDiv);
                }
            });

            //https://purecho.tistory.com/68
            //파일등록
            // var fileNo = 0;
            // var filesArr = new Array();

            // /* 첨부파일 추가 */
            // function addFile(obj){
            //     var maxFileCnt = 5;   // 첨부파일 최대 개수
            //     var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
            //     var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
            //     var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수

            //     // 첨부파일 개수 확인
            //     if (curFileCnt > remainFileCnt) {
            //         alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
            //     } else {
            //         for (const file of obj.files) {
            //             // 첨부파일 검증
            //             if (validation(file)) {
            //                 // 파일 배열에 담기
            //                 var reader = new FileReader();
            //                 reader.onload = function () {
            //                     filesArr.push(file);
            //                 };
            //                 reader.readAsDataURL(file);

            //                 // 목록 추가
            //                 let htmlData = '';
            //                 htmlData += '<div id="file' + fileNo + '" class="filebox">';
            //                 htmlData += '   <p class="name">' + file.name + '</p>';
            //                 htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');"><i class="far fa-minus-square"></i></a>';
            //                 htmlData += '</div>';
            //                 $('.file-list').append(htmlData);
            //                 fileNo++;
            //             } else {
            //                 continue;
            //             }
            //         }
            //     }
            //     // 초기화
            //     document.querySelector("input[type=file]").value = "";
            // }

            // /* 첨부파일 검증 */
            // function validation(obj){
            //     const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
            //     if (obj.name.length > 100) {
            //         alert("파일명이 100자 이상인 파일은 제외되었습니다.");
            //         return false;
            //     } else if (obj.size > (100 * 1024 * 1024)) {
            //         alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
            //         return false;
            //     } else if (obj.name.lastIndexOf('.') == -1) {
            //         alert("확장자가 없는 파일은 제외되었습니다.");
            //         return false;
            //     } else if (!fileTypes.includes(obj.type)) {
            //         alert("첨부가 불가능한 파일은 제외되었습니다.");
            //         return false;
            //     } else {
            //         return true;
            //     }
            // }

            // /* 첨부파일 삭제 */
            // function deleteFile(num) {
            //     document.querySelector("#file" + num).remove();
            //     filesArr[num].is_delete = true;
            // }


            //글 등록
            registBtn.onclick = function() {

                const titleValue = titleInput.value;
                const writerValue = writerInput.value;
                const contentValue = contentInput.value;
                const pwValue = pwInput.value;
                const passwordRegex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[$@!%*#?&])[a-zA-Z0-9$@!%*#?&]{8,10}$/; //최소 8 자 및 최대 10 자, 하나 이상의 대문자, 하나의 소문자, 하나의 숫자 및 하나의 특수 문자 정규식


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
                    console.log(titleValue);
                    $form.submit();
                }

            }
            
            //작성자 글자수 제한
            function handleWriterLength(el, max) {
                const trimmedValue = el.value.trim();
                if(trimmedValue.length > max) {
                    el.value = el.value.substr(0, max);
                    alert('15자를 넘었습니다.')
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
            //비밀번호칸에 스페이스바 입력 금지
            function preventSpace(event) {
                var keyCode = event.keyCode ? event.keyCode : event.which;
                if (keyCode === 32) {
                    event.preventDefault();
                }
            }
            //글자 submit 전 trim
            function trimInput(el) {
                el.value = el.value.trim();
            }


    </script>
  