﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
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
                        <!-- <input class="form-control ellipsis" name="writer" value="${article.writer}" readonly> -->
                        <textarea class="form-control ellipsis" id="writer" rows="1" name="writer" readonly><c:out value="${article.writer}"></c:out></textarea>

                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <!-- <input class="form-control ellipsis" id="title" name="title" value="${article.title}" readonly onclick="showTextArea()"> -->
                        <textarea class="form-control ellipsis" id="title" rows="1" name="title" readonly  onclick="showTextArea()"><c:out value="${article.title}"></c:out></textarea>
                    </div>

                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" id="content" rows="10" name="content" readonly><c:out value="${article.content}"></c:out></textarea>
                    </div>

                    
                </form>
                <button class="btn btn-primary" id="updateBtn">변경</button>

                <!-- 계층을 위해 해당값을 넘겨주기 위함-->
                <input type="hidden" name="bno" value="${article.bno}">
                <input type="hidden" name="originBno" value="${article.originBno}">
                <input type="hidden" name="groupOrd" value="${article.groupOrd}">
                <input type="hidden" name="groupLayer" value="${article.groupLayer}">

                <button type="button" class="btn btn-primary" id="replyBtn"
                        onclick="location.href='${pageContext.request.contextPath}/freeboard/replyBoard?bno=${article.bno}&originBno=${article.originBno}&groupOrd=${article.groupOrd}&groupLayer=${article.groupLayer}'">
                    답글작성
                </button>

                <button type="button" class="btn btn-dark"
                        onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
            </div>
        </div>
    </div>
</section>

<!-- 댓글 영역 시작부분 -->
<section style="margin-top: 80px;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-9 write-wrap">
                <form class="reply-wrap">
                    <!-- <div class="reply-image">
                        <img src="${pageContext.request.contextPath}/img/profile.png">
                    </div> -->
                    <!--form-control은 부트스트랩의 클래스입니다-->
                    <div class="reply-content">
                        <textarea class="form-control" rows="3" id="reply" placeholder="댓글은 100자까지 입력가능합니다." oninput="handleContentLength(this, 100)" onblur="trimInput(this)"></textarea>
                        <div class="reply-group">
                            <div class="reply-input">
                                <input type="text" class="form-control" id="replyId" placeholder="이름" oninput="handleNameLength(this, 15)" onblur="trimInput(this)">
                                <input type="password" class="form-control" id="replyPw" placeholder="비밀번호" oninput="handlePWLength(this, 15)" onblur="trimInput(this)" onkeydown="preventSpace(event)">
                            </div>

                            <button type="button" id="replyRegist" class="right btn btn-info">등록하기</button>
                        </div>

                    </div>
                </form>

                <!--여기에 접근 반복-->
                <div id="replyList">
                    <!-- 자바스크립트 단에서 반복문을 이용해서 댓글의 개수만큼 반복 표현. -->

                </div>
            </div>
        </div>
    </div>
</section>

<!-- 모달 -->
<div class="modal fade" id="replyModal" role="dialog">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn btn-default pull-right" id="closeModal" data-dismiss="modal">닫기</button>
                <h4 class="modal-title">댓글 수정</h4>
            </div>
            <div class="modal-body">
                <!-- 수정폼 id값을 확인하세요-->
                <div class="reply-content">
                    <textarea class="form-control" rows="4" id="modalReply" placeholder="댓글은 100자까지 입력가능합니다." oninput="handleContentLength(this, 100)" onblur="trimInput(this)"></textarea>
                    <div class="reply-group">
                        <div class="reply-input">
                            <input type="hidden" id="modalRno">
                            <input type="password" class="form-control" placeholder="비밀번호" id="modalPw" oninput="handlePWLength(this, 15)" onblur="trimInput(this)" onkeydown="preventSpace(event)">
                        </div>
                        <button class="right btn btn-info" id="modalModBtn">수정하기</button>
                        <button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
                    </div>
                </div>
                <!-- 수정폼끝 -->
            </div>
        </div>
    </div>
</div>


<script>
    //입력에 따라 textarea 변함
    const contentTextarea = document.getElementById('content');
        function adjustTextareaHeight() {
            contentTextarea.style.height = 'auto';
            contentTextarea.style.height = contentTextarea.scrollHeight + 'px';
        }

        contentTextarea.addEventListener('input', adjustTextareaHeight);
        window.addEventListener('load', adjustTextareaHeight);

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
//이름 글자수 제한
function handleNameLength(el, max) {
            const trimmedValue = el.value.trim();
            if(trimmedValue.length > max) {
                el.value = el.value.substr(0, max);
                alert('10자를 넘었습니다.')
            }
        }
        //내용 글자수 제한
        function handleContentLength(el, max) {
            const trimmedValue = el.value.trim();
            if(trimmedValue.length > max) {
                el.value = el.value.substr(0, max);
                alert('100자를 넘었습니다.')
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


//댓글등록
window.onload = function () {

    document.getElementById('replyRegist').onclick = () => {

        console.log('댓글 등록 이벤트 발생!');

        const bno = '${article.bno}'; //현재 게시글 번호
        const reply = document.getElementById('reply').value;
        const replyId = document.getElementById('replyId').value;
        const replyPw = document.getElementById('replyPw').value;

        if (reply === '' || replyId === '' || replyPw === '') {
            alert('이름, 비밀번호, 내용을 입력하세요!');
            return;
        }
        // 앞뒤 공백을 제거하고 빈 칸 여부 판단
        else if (replyId.trim() === '') {
            alert('공백만으로 글을 작성할 수 없습니다.(작성자)');
            return;
                    
        }
        else if (reply.trim() === '') {
            alert('공백만으로 글을 작성할 수 없습니다.(내용)');
            return;
            
        }
        else if (replyPw.trim() === '') {
            alert('공백만으로 글을 작성할 수 없습니다.(비밀번호)');
            return;
                        
        }

        //요청에 관련된 정보 객체
        const reqObj = {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                'bno': bno,
                'reply': reply,
                'replyId': replyId,
                'replyPw': replyPw
            })
        };

        fetch('${pageContext.request.contextPath}/reply/regist', reqObj)
            .then(res => res.text())
            .then(data => {
                console.log('통신 성공!: ' + data);
                document.getElementById('reply').value = '';
                document.getElementById('replyId').value = '';
                document.getElementById('replyPw').value = '';
                //등록 완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현.
                getList(true);
            });

    } //댓글 등록 이벤트 끝.리스트

    //댓글리스트 불러오기
    let strAdd = ''; //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수
        const $replyList = document.getElementById('replyList');

        //게시글 상세보기 화면에 처음 진입했을 시 댓글 리스트를 한 번 불러오자.
        getList(true);

        function getList(reset) {
            strAdd = '';
            const bno = '${article.bno}'; //게시글 번호

            //get방식으로 댓글 목록을 요청(비동기)
            fetch('${pageContext.request.contextPath}/reply/getList/' + bno)
                .then(res => res.json())
                .then(data => {
                    console.log(data);

                    let total = data.total; //총 댓글 수
                    let replyList = data.list; //댓글 리스트

                    //insert, update, delete 작업 후에는
                    //댓글 내용 태그를 누적하고 있는 strAdd 변수를 초기화해서
                    //마치 화면이 리셋된 것처럼 보여줘야 합니다.
                    if (reset) {
                        while ($replyList.firstChild) {
                            $replyList.firstChild.remove();
                        }
                    }

                    //응답 데이터의 길이가 0과 같거나 더 작으면 함수를 종료.
                    if (replyList.length <= 0) return;

                    //replyList의 개수만큼 태그를 문자열 형태로 직접 그림.
                    //중간에 들어갈 글쓴이, 날짜, 댓글 내용은 목록에서 꺼내서 표현.
                    for (let i = 0; i < replyList.length; i++) {
                        strAdd += `
                        <div class='reply-wrap'>
                        <div class='reply-content'>
                            <div class='reply-group'>
                                <pre class='left replyId` + i + `' style="display:inline; font-weight:bold"></pre>
                                <a href='` + replyList[i].rno + `' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a> &nbsp;
                                <a href='` + replyList[i].rno + `' class='right replyModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                            </div>
                            <pre class='clearfix reply` + i + `'></pre>
                        </div>
                    </div>`;

                    }

                    //id가 replyList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
                    if (!reset) {
						document.getElementById('replyList').insertAdjacentHTML('beforeend', strAdd);
						for (let i = 0; i < replyList.length; i++) {
							document.querySelector(`.replyId` + i).insertAdjacentText('beforeend', replyList[i].replyId);
							document.querySelector(`.reply` + i).insertAdjacentText('beforeend', replyList[i].reply);
						}
					} else {
						document.getElementById('replyList').insertAdjacentHTML('afterbegin', strAdd);
						for (let i = 0; i < replyList.length; i++) {
							document.querySelector(`.replyId` + i).insertAdjacentText('beforeend', replyList[i].replyId);
							document.querySelector(`.reply` + i).insertAdjacentText('beforeend', replyList[i].reply);
						}
					}


                });
        } // end getList();

        //수정, 삭제
        document.getElementById('replyList').addEventListener('click', e => {
            e.preventDefault(); //태그의 고유 기능을 중지.

            //1. 이벤트가 발생한 target이 a태그가 아니라면 이벤트 종료.
            if (!e.target.matches('a')) {
                return;
            }

            //2. a태그가 두 개(수정, 삭제)이므로 어떤 링크인지를 확인.
            //댓글이 여러 개 -> 수정, 삭제가 발생하는 댓글이 몇 번인지도 확인.
            const rno = e.target.getAttribute('href');
            console.log('댓글 번호: ' + rno);
            //모달 내부에 숨겨진 input 태그에 댓글 번호를 담아주자.
            document.getElementById('modalRno').value = rno;

            const content = e.target.parentNode.nextElementSibling.textContent;
            console.log('댓글 내용: ' + content);

            //3. 모달 창 하나를 이용해서 상황에 따라 수정 / 삭제 모달을 구분하기 위해
            //조건문을 작성. (모달 하나로 수정, 삭제를 같이 처리. 그러기 위해 디자인 조정.)
            if (e.target.classList.contains('replyModify')) {
                //수정 버튼을 눌렀으므로 수정 모달 형식을 꾸며주겠다.
                document.querySelector('.modal-title').textContent = '댓글 수정';
                document.getElementById('modalReply').style.display = 'inline'; //댓글창
                document.getElementById('modalReply').value = content;
                document.getElementById('modalModBtn').style.display = 'inline';
                document.getElementById('modalDelBtn').style.display = 'none';

                //제이쿼리를 이용해서 bootstrap 모달을 여는 방법.
                $('#replyModal').modal('show');

            } else {
                //삭제 버튼을 눌렀으므로 삭제 모달 형식으로 꾸며줌.
                document.querySelector('.modal-title').textContent = '댓글 삭제';
                document.getElementById('modalReply').style.display = 'none'; //댓글창
                document.getElementById('modalModBtn').style.display = 'none';
                document.getElementById('modalDelBtn').style.display = 'inline';
                $('#replyModal').modal('show');
            }
        }); //수정 or 삭제 버튼 클릭 이벤트 끝.

        //닫기누르면 비번칸 초기화
        document.getElementById('closeModal').onclick = () =>{
            const replyPw = document.getElementById('modalPw').value='';
        }


        //수정 처리 함수. (수정 모달을 열어서 수정 내용을 작성 후 수정 버튼을 클릭했을 때)
        document.getElementById('modalModBtn').onclick = () => {

            const reply = document.getElementById('modalReply').value;
            const rno = document.getElementById('modalRno').value;
            const replyPw = document.getElementById('modalPw').value;

            if (reply === '' || replyPw === '') {
                alert('내용, 비밀번호를 확인하세요!');
                return;
            }

            //요청에 관련된 정보 객체
            const reqObj = {
                method: 'put',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    // 'rno':rno,
                    'reply': reply,
                    'replyPw': replyPw
                })
            };

            fetch('${pageContext.request.contextPath}/reply/' + rno, reqObj)
                .then(res => res.text())
                .then(data => {
                    if (data === 'pwFail') {
                        alert('비밀번호를 확인하세요.');
                        document.getElementById('modalPw').value = '';
                        document.getElementById('modalPw').focus();
                    } else {
                        document.getElementById('modalReply').value = '';
                        document.getElementById('modalPw').value = '';
                        //제이쿼리 문법으로 bootstrap 모달 닫아주기
                        $('#replyModal').modal('hide');
                        getList(true);
                    }
                });
        } //end update event

        // 삭제 이벤트
        document.getElementById('modalDelBtn').onclick = () => {

        const rno = document.getElementById('modalRno').value;
        const replyPw = document.getElementById('modalPw').value;

        if (replyPw === '') {
            alert('비밀번호를 확인하세요!');
            return;
        }

            const confirmDelete = confirm('정말로 삭제하시겠습니까?');

            if (confirmDelete) {
                fetch('${pageContext.request.contextPath}/reply/' + rno, {
                    method: 'delete',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        'replyPw': replyPw
                    })
                })
                .then(res => res.text())
                .then(data => {
                    if (data === 'delSuccess') {
                        document.getElementById('modalPw').value = '';
                        $('#replyModal').modal('hide');
                        getList(true);
                    } else {
                        alert('비밀번호가 틀렸습니다.');
                        document.getElementById('modalPw').value = '';
                        document.getElementById('modalPw').focus();
                    }
                });
            } else {
                // 사용자가 취소를 클릭한 경우 아무 작업 없음
            }
        };


}
</script>


