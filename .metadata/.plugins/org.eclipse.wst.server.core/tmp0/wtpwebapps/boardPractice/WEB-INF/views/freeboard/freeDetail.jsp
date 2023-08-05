<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                    <p>상세보기</p>
                </div>

                <form action="${pageContext.request.contextPath}/freeboard/modify" method="post"  name="detailForm">
                    <div>
                        <label>작성일</label>
                            <p>
                               <fmt:parseDate value="${article.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                    var="parsedDateTime" type="both" />
                               <fmt:formatDate value="${parsedDateTime}" pattern="yyyy년 MM월 dd일" />
                            </p>

                    </div>
                    <div class="form-group">
                        <input class="form-control" id="bno" name="bno" value="${article.bno}" type="hidden">
                    </div>
                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control ellipsis" name="writer" value="${article.writer}" readonly>
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input class="form-control ellipsis" id="title" name="title" value="${article.title}" readonly onclick="showTextArea()">
                        <!-- <div class="form-group">
                        <textarea class="form-control" id="titleBox" name="content" style="display: none;" readonly onclick="showInputArea()"></textarea>
                    </div> -->
                    </div>

                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" id="content" rows="10" name="content" readonly>${article.content}</textarea>
                    </div>

                    
                </form>
                <button class="btn btn-primary" id="updateBtn">변경</button>
                <button type="button" class="btn btn-dark"
                        onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
            </div>
        </div>
    </div>
</section>


<script>
    //입력에 따라 textarea 변함
    const contentTextarea = document.getElementById('content');
        function adjustTextareaHeight() {
            contentTextarea.style.height = 'auto';
            contentTextarea.style.height = contentTextarea.scrollHeight + 'px';
        }

        contentTextarea.addEventListener('input', adjustTextareaHeight);
        window.addEventListener('load', adjustTextareaHeight);

        // const titleInput = document.getElementById('title');
        // function showTextArea() {
        //     const textarea = document.getElementById('titleBox');
        //     textarea.style.display = 'block';
        //     textarea.value = '';
        //     textarea.value = titleInput.value;
        //     textarea.style.height = 'auto';
        //     textarea.style.height = textarea.scrollHeight + 'px';
        //     titleInput.style.display = 'none';
        // }
        // function showInputArea() {
        //     const textarea = document.getElementById('titleBox');
        //     textarea.style.display = 'none';
        //     document.getElementById('title').style.display = 'block';
        // }

        const titleInput = document.getElementById('title');
        titleInput.onclick = function(){
            alert(titleInput.value);
        }

    const $form = document.detailForm;
	let bno = document.getElementById('bno').value;
	document.getElementById('updateBtn').onclick = function() {
    enterPassword();
};

function enterPassword() {
    let pw = prompt('비밀번호를 입력하세요');

    if (pw === null) {
        return;
    } else {
        const data = {
            bno: bno,
            pw: pw
        };

        fetch('${pageContext.request.contextPath}/freeboard/check', {
            method: 'post',
            headers: {
                'Content-type': 'application/JSON'
            },
            body: JSON.stringify(data)
        })
        .then(res => res.text()) // 요청 완료 후 응답 정보에서 텍스트만 빼기
        .then(data => { // 텍스트만 뺀 Promise 객체로부터 data전달받음.
            if (data === '1') {
                console.log(data);
                $form.submit();
            } else {
                alert('비밀번호가 틀렸습니다. 다시 입력해주세요.');
                console.log(data);
                enterPassword(); // Prompt again for the password
            }
        });
    }
}
</script>


