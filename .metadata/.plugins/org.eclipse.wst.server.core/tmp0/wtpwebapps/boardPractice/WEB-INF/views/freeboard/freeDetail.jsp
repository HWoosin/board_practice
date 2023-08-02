﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp" %>

<section>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-9 write-wrap">
                <div class="titlebox">
                    <p>상세보기</p>
                </div>

                <form action="<c:url value='/freeboard/modify' />" method="post">
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
                        <input class="form-control ellipsis" name="title" value="${article.title}" readonly>
                    </div>

                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="10" name="content" readonly>${article.content}</textarea>
                    </div>

                    
                </form>
                <button class="btn btn-primary" id="updateBtn">변경</button>
                <button type="button" class="btn btn-dark"
                        onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
            </div>
        </div>
    </div>
</section>



<%@ include file="../include/footer.jsp" %>

<script>
	let bno = document.getElementById('bno');
	document.getElementById('updateBtn').onclick = function() {
		let pw = prompt('비밀번호를 입력하세요');
		
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
        .then(res => res.text()) //요청 완료 후 응답 정보에서 텍스트만 빼기
        .then(data => { //텍스트만 뺀 Promise 객체로부터 data전달받음.
            if (data === '1') {
            	console.log(data);
                location.href = '${pageContext.request.contextPath}/freeboard/modify';
            } else {
				alert('비밀번호 불일치');
				console.log(data);
                
            }
        });
	}
</script>


