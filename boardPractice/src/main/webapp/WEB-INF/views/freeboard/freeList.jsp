﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    

    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/js/bootstrap.js"></script>
    
    
    <section>
        <div class="container-fluid">
            <div class="row">
                <!--lg에서 9그리드, xs에서 전체그리드-->   
                <div class="col-lg-9 col-xs-12 board-table">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    <hr>
                    
                    <!--form select를 가져온다 -->
		        <form action="${pageContext.request.contextPath}/freeboard/freeList" name="listForm" onSubmit="return false;">
				    <div class="search-wrap">
		                       <button type="submit" id="searchBtn" class="btn btn-info search-btn">검색</button>
		                       <input type="text" id="searchInput" name="keyword" class="form-control search-input" value="${pc.paging.keyword}"oninput="handleInputLength(this, 100)" onblur="trimInput(this)">
		                       <select name="condition" class="form-control search-select">
		                            <option value="title" ${pc.paging.condition == 'title' ? 'selected': ''}>제목</option>
		                            <option value="content" ${pc.paging.condition == 'content' ? 'selected': ''}>내용</option>
		                            <option value="writer" ${pc.paging.condition == 'writer' ? 'selected': ''}>작성자</option>
		                            <option value="titleContent" ${pc.paging.condition == 'titleContent' ? 'selected': ''}>제목+내용</option>
		                       </select>
                               <p class="totalView">${pc.articleTotalCount}개의 글이 있습니다.</p>
		                    </div>
				</form>              
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th class="board-no">번호</th>
                                <th class="board-title">제목</th>
                                <th class="board-writer">작성자</th>
                                <th class="board-date">등록일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="num" value="${pc.articleTotalCount - ((pc.paging.pageNum-1) * pc.paging.cpp)}"/>
                            <c:forEach var="vo" items="${boardList}">
                            	<tr>
                                    <td>${num }</td>
	                            	<td style="text-align: left;">
	                            		<a href="${pageContext.request.contextPath}/freeboard/content/${vo.bno}?pageNum=${pc.paging.pageNum}&cpp=${pc.paging.cpp}&keyword=${pc.paging.keyword}&condition=${pc.paging.condition}">${vo.title}</a>

                                    </td>
	                            	<td>${vo.writer}</td>
	                            	<td>
	                            		<fmt:parseDate value="${vo.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
	                            		<fmt:formatDate value="${parsedDateTime}" pattern="yyyy년 MM월 dd일" />
	                            	</td>
	                            	
                            	</tr>
                                <c:set var="num" value="${num-1 }"></c:set>
                            </c:forEach>
                        </tbody>
                        
                    </table>


                    <!--페이지 네이션을 가져옴-->
		    <form action="${pageContext.request.contextPath}/freeboard/freeList?pageNum=${pc.paging.pageNum}&cpp=${pc.paging.cpp}" name="pageForm">
                    <div class="text-center">
                    <hr>
                    <ul id="pagination" class="pagination pagination-sm">
                        <c:if test="${pc.front}">
                        	<li><a href="#" data-pagenum="1">맨 처음</a></li>
                        </c:if>
                    	<c:if test="${pc.prev}">
                        	<li><a href="#" data-pagenum="${pc.beginPage-1}">이전</a></li>
                        </c:if>
                        <c:forEach var="num" begin="${pc.beginPage}" end="${pc.endPage}">
	                        <li  class="${pc.paging.pageNum == num ? 'active': ''}">
	                        	<a href="#" data-pagenum="${num}">${num}</a>
	                        </li>
	                      </c:forEach> 
                        <c:if test="${pc.next}">
                        	<li><a href="#" data-pagenum="${pc.endPage+1}">다음</a></li>
                        </c:if>
                        <c:if test="${pc.end}">
                        	<li><a href="#" data-pagenum="${pc.lastPage}">맨 끝</a></li>
                        </c:if>
                    </ul>
                    <button type="button" class="btn btn-info" onclick="location.href='${pageContext.request.contextPath}/freeboard/regist'">글쓰기</button>
                    <button type="button" class="btn btn-info" onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList'">목록</button>
                    </div>

                    <input type="hidden" name="pageNum" value="${pc.paging.pageNum}">
                    <input type="hidden" name="cpp" value="${pc.paging.cpp}">
                    <input type="hidden" name="keyword" value="${pc.paging.keyword}">
                    <input type="hidden" name="condition" value="${pc.paging.condition}">
					
		    </form>

                </div>
            </div>
        </div>
	</section>
	


    <script>

        //브라우저 창이 로딩이 완료된 후에 실행할 것을 보장하는 이벤트.
        window.onload = function(){
            //사용자가 페이지 관련 버튼을 클릭했을 때,
            //기존에는 각각의 a태그의 href에다가 각각 다른 url을 작성해서 보내줬다면,
            //이번에는 클릭한 그 버튼이 무엇인지를 확인해서 그 버튼에 맞는 페이지 정보를
            //자바스크립트로 끌고와서 요청을 보내준다.
            document.getElementById('pagination').addEventListener('click',e =>{
                if(!e.target.matches('a')){
                    return;
                }
                e.preventDefault();//a태그의 고유 기능 중지.

                //현재 이벤트가 발생한 요소(버튼)의
                //data-pagenum의 값을 얻어서 변수에 저장.
                const value = e.target.dataset.pagenum;
                //페이지 버튼들을 감싸고 있는 form태그를 지목하여
                //그 안에 숨겨져 있는 pageNum이라는 input태그의 value에
                //위에서 얻은 data-pagenum의 값을 삽입한 후 submit
                document.pageForm.pageNum.value = value;
                document.pageForm.submit();
            });
        }

        //검색할때 공백이랑 빈칸 막기
        const $form = document.listForm;
        const searchInput = document.getElementById('searchInput');
        const searchBtn = document.getElementById('searchBtn');

        function hasBadWords(inputText){
                const badWordsRegex = /(바보|멍청이|똥깨|씨발|개새끼|시발|OR|SELECT|INSERT|DELETE|UPDATE|CREATE|DROP|EXEC|UNION|FETCH|DECLARE|TRUNCATE)/gi;//파일처리하면 더 좋을것같음.
                return badWordsRegex.test(inputText);
        }

        function checkInput(){
            const searchValue = searchInput.value;
            if(searchValue === ''){
                alert('검색어를 작성해주세요.');
                return;
            }
            else if(searchValue.trim() === ''){
                alert('공백은 검색할 수 없습니다.');
                return;
            }
            // 욕설이 포함된 경우, sql 문 막기
            else if (hasBadWords(searchValue)) {
                        alert('사용할 수 없는 단어가 포함되어 있습니다. 글을 검색할 수 없습니다.');
                        return;
            }
            else{
                $form.submit();
            }
        }

        searchBtn.onclick = function(){
            checkInput();
        }

        // function checkWords(inputText){
        //         const wordExp = /[%=><&]/gi;
        //         if(wordExp.test(inputText.value) ){
        //         alert("해당 특수문자는 입력하실 수 없습니다.");
        //         inputText.value = inputText.value.substring( 0 , inputText.value.length - 1 ); // 입력한 특수문자 한자리 지움
                
        //         }
        //     }

        //글자수 제한
        function handleInputLength(el, max) {
                const trimmedValue = el.value.trim();
                if(trimmedValue.length > max) {
                    el.value = el.value.substr(0, max);
                    alert('사용할 수 있는 글자 수를 넘었습니다.')
                }
            }

        //글자 submit 전 trim
        function trimInput(el) {
                el.value = el.value.trim();
            }
    </script>