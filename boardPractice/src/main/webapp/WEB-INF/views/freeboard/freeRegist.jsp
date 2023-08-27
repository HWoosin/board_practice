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
                                    <div class="reply-group">
                                        <div class="filebox pull-left">
                                            <label for="file">파일 업로드 ➕</label>
                                            <input type="file" name="file" id="file" style="display:none;" multiple>
                                            <div class="file-list"></div>
                                        </div>
                                    </div>
                            </div>
                            <!-- <div id="file-upload-container">
                                <label class="upload-label">파일 업로드</label>
                                <button type="button" class="btn" id="uploadPlusBtn">+</button>
                                <button type="button" class="btn" id="uploadMinusBtn">-</button>
                            </div> -->
                            
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

            //파일 등록
            // let fileNo = 0  // 첨부된 이미지 총 갯수 (삭제되도 줄어들지않음). 이미지마다 다른 id를 지정하기 위함
            // let filesArr = []  // 첨부된 모든 파일 리스트 (삭제되도 제거되지않음)

            // function fileUpload(obj) {  // 파일을 인자값으로 받음

            //     let maxFileCnt = 5   // 첨부파일 최대 개수
            //     let attFileCnt = document.querySelectorAll('.filebox').length    // 기존 추가된 첨부파일 개수
            //                                                                     // 업로드를 하면 바디에 생성된 태그 갯수로 계산
            //     let remainFileCnt = maxFileCnt - attFileCnt    // 추가로 첨부가능한 개수
            //     let curFileCnt = obj.files.length  // 현재 선택된 첨부파일 개수
                
            //     // 첨부파일 개수 확인
            //     // 최대 개수 초과 시
            //     if (curFileCnt > remainFileCnt) {
            //         alert("이미지는 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.")
            //     }

            //     // 최대 개수 넘지 않았을 시
            //     else {
            //         // 첨부된 복수의 파일 하나씩
            //         for (const file of obj.files) {
                        
            //             // 파일 배열에 담기
            //             filesArr.push(file)  // 파일 리스트에 추가
                        
            //             // 이미지 목록에 추가
            //             // 업로드한 파일마다 파일이름과 삭제 가능한 버튼을 문서에 붙인다
            //             let htmlData = ''
            //             htmlData += '<div id="file' + fileNo + '" class="filebox">'
            //             htmlData += '   <p class="name" style="display:inline">' + file.name + '</p>'
            //             htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ')">❌</a>'  // 온클릭 이벤트 추가하고 해당 파일을 파라미터에 담음
            //             htmlData += '</div>'
            //             $('.file-list').append(htmlData)
            //             filesArr[fileNo].is_delete=false;

            //             fileNo++  // 파일 번호 +1
            //             console.log("생성배열:", filesArr);
            //         }
            //     }
            // }

            // // 첨부파일 삭제
            // // 동적으로 생성된 html 태그에서 파일 이름 옆 ❌버튼을 누르면 작동
            // function deleteFile(num) {
            //     document.querySelector("#file" + num).remove()
            //     filesArr[num].is_delete = true  // 파일 리스트의 해당 인덱스에 is_delete=false 라는 키와 값을 추가한다
            //     console.log(num);
            //     console.log(filesArr);
            //     console.log(filesArr[num].is_delete);
            //     /*
            //     배열을 삭제하지 않고 남겨두는 이유는
            //     fileNo를 통해서 순서대로 리스트에 추가했고
            //     fileNo로 index 조회를 하고있기에
            //     fileNo와 리스트에 저장된 index 번호가 달라지면 안되기 때문이다
            //     */

            //      // 파일을 제거한 새로운 배열 생성
            //     const updatedFilesArr = filesArr.filter(file => !file.is_delete);

            //     filesArr = updatedFilesArr; // 기존 filesArr 배열을 업데이트된 배열로 덮어쓰기
            //     console.log("삭제된 파일:", filesArr[num]);
            //     console.log("업데이트된 배열:", filesArr);
            // }

            // const $fileUploadContainer = document.getElementById('file-upload-container');
            // //파일 업로드 추가
            // document.getElementById('uploadPlusBtn').addEventListener('click', e => {
            //     e.preventDefault();
            //     const str = `<br><input type="file" name="file">`;
            //     $fileUploadContainer.insertAdjacentHTML('beforeend', str);
            // });

            // //파일 업로드 빼기
            // document.getElementById('uploadMinusBtn').addEventListener('click', e => {
            //     e.preventDefault();
            //     if($fileUploadContainer.lastElementChild.tagName === 'INPUT') {
            //         $fileUploadContainer.lastElementChild.remove();
            //         $fileUploadContainer.lastElementChild.remove();
            //     }
            // });

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
                    // // 폼데이터에 담기
                    // let formData = new FormData()	// 폼데이터 객체 생성

                    // for (let i = 0; i < filesArr.length; i++) {
                    //     // 삭제되지 않은 파일만 폼데이터에 담기
                    //     console.log(filesArr);
                    //     if (filesArr[i].is_delete === false) {
                    //         formData.append('file', filesArr[i])
                    //     }
                    // }
                    // for (const pair of formData.entries()) {
                    //     console.log(pair[0], pair[1]);
                    // }

                    //리스트에 담은 파일 전송
                    selectedFiles.forEach(file => {
                        formData.append('files[]', file);
                    });
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
  