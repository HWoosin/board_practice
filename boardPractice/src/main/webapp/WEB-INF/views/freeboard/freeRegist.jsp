<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
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
                                <input class="form-control" id="writer" name="writer" oninput="handleInputLength(this, 15)" onblur="trimInput(this)" onkeyup="checkWords(this)" onkeydown="checkWords(this)">
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" id="title" name="title" oninput="handleInputLength(this, 100)" onblur="trimInput(this)"  onkeyup="checkWords(this)" onkeydown="checkWords(this)">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" id="content" rows="10" name="content" oninput="handleInputLength(this, 1000)"  onkeyup="checkWords(this)" onkeydown="checkWords(this)"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label>비밀번호</label>
                                <input type="password" class="form-control input-sm" id="pw" name="pw" oninput="handleInputLength(this, 15)" onblur="trimInput(this)"  onkeyup="checkWords(this)" onkeydown="checkWords(this)">
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

            function checkWords(inputText){
                const wordExp = /[%=><&]/gi;
                if(wordExp.test(inputText.value) ){
                alert("해당 특수문자는 입력하실 수 없습니다.");
                inputText.value = inputText.value.substring( 0 , inputText.value.length - 1 ); // 입력한 특수문자 한자리 지움
                
                }
            }

            //등록 버튼 이벤트 처리
            registBtn.onclick = function() {

                const titleValue = titleInput.value;
                const writerValue = writerInput.value;
                const contentValue = contentInput.value;
                const pwValue = pwInput.value;


                if(titleValue === ''){
                    alert('제목은 필수 항목');
                    $form.title.focus();
                    return;
                }    
                else if(contentValue === ''){
                    alert('내용은 필수 항목');
                    $form.content.focus();
                    return;
                }
                else if(writerValue === ''){
                    alert('작성자는 필수 항목');
                    $form.writer.focus();
                    return;
                }
                else if(pwValue === ''){
                    alert('비밀번호는 필수 항목');
                    $form.pw.focus();
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
                // 욕설이 포함된 경우, sql 문 막기
                else if (hasBadWords(titleValue) || hasBadWords(writerValue) || hasBadWords(contentValue)) {
                        alert('사용할 수 없는 단어가 포함되어 있습니다. 글을 등록할 수 없습니다.');
                        return;
                    }
                else{
                    console.log(titleValue);
                    $form.submit();
                }
            }
            
            //글자수 제한
            function handleInputLength(el, max) {
                const trimmedValue = el.value.trim();
                if(trimmedValue.length > max) {
                    el.value = el.value.substr(0, max);
                }
            }
            //글자 submit 전 trim
            function trimInput(el) {
                el.value = el.value.trim();
            }

            // //글 작성 시간제한
            // let isWritingDisabled = false;

            // function disableWritingFor10Seconds() {
            // isWritingDisabled = true;
            // registBtn.disabled = true;

            //     setTimeout(() => {
            //         isWritingDisabled = false;
            //         registBtn.disabled = false;
            //     }, 10000);
            // }

            // document.getElementById('writeButton').addEventListener('click', () => {
            //     if (!isWritingDisabled) {
            //         disableWritingFor10Seconds();
            //         // 글 작성 요청 보내는 코드를 추가
            //         const formData = new FormData();
            //         formData.append('content', document.getElementById('content').value); // 글 내용 등 필요한 데이터 추가

            //         // 서버로 요청 보내는 대신에 여기서 글 작성 처리
            //         // 예시로 콘솔에 "글 작성 요청 보냄"을 출력
            //         console.log('글 작성 요청 보냄');
            //     }
            // });
        

        
    
        

    </script>
  