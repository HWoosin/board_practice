/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.78
 * Generated at: 2023-08-09 07:45:33 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.freeboard;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class freeRegist_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write(" \r\n");
      out.write("	\r\n");
      out.write("    <!--개인 디자인 추가-->\r\n");
      out.write("    <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/css/bootstrap.css\" rel=\"stylesheet\">\r\n");
      out.write("    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js\"></script>\r\n");
      out.write("    <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/css/style.css\" rel=\"stylesheet\">\r\n");
      out.write("    <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/js/bootstrap.js\"></script>\r\n");
      out.write("\r\n");
      out.write("    <section>\r\n");
      out.write("       <div class=\"container\">\r\n");
      out.write("            <div class=\"row\">\r\n");
      out.write("                <div class=\"col-xs-12 content-wrap\">\r\n");
      out.write("                    <div class=\"titlebox\">\r\n");
      out.write("                        <p>자유게시판</p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    \r\n");
      out.write("                     <form action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/freeboard/regist\" method=\"post\" name=\"registForm\" onsubmit=\"return false\">   \r\n");
      out.write("                         \r\n");
      out.write("                            <div class=\"form-group\">\r\n");
      out.write("                                <label>작성자</label>\r\n");
      out.write("                                <input class=\"form-control\" id=\"writer\" name=\"writer\" placeholder=\"최대 15자 입력가능.\" oninput=\"handleWriterLength(this, 15)\" onblur=\"trimInput(this)\">\r\n");
      out.write("                            </div>    \r\n");
      out.write("                            <div class=\"form-group\">\r\n");
      out.write("                                <label>제목</label>\r\n");
      out.write("                                <input type=\"text\" class=\"form-control\" id=\"title\" name=\"title\" placeholder=\"최대 100자 입력가능.\" oninput=\"handleTitleLength(this, 100)\" onblur=\"trimInput(this)\">\r\n");
      out.write("                                <!-- <textarea class=\"form-control\" id=\"title\" rows=\"1\" placeholder=\"최대 100자 입력가능.\" name=\"title\" oninput=\"handleTitleLength(this, 100)\" onblur=\"trimInput(this)\"></textarea> -->\r\n");
      out.write("\r\n");
      out.write("                            </div>\r\n");
      out.write("\r\n");
      out.write("                            <div class=\"form-group\">\r\n");
      out.write("                                <label>내용</label>\r\n");
      out.write("                                <span id=\"textLengthCheck\">0 / 1000</span>\r\n");
      out.write("                                <textarea class=\"form-control\" id=\"content\" rows=\"10\" placeholder=\"최대 1000자 입력가능.\" name=\"content\" oninput=\"handleContentLength(this, 1000); countWords(this, 1000)\"></textarea>\r\n");
      out.write("                            </div>\r\n");
      out.write("                            \r\n");
      out.write("                            <div class=\"form-group\">\r\n");
      out.write("                                <label>비밀번호</label>\r\n");
      out.write("                                <input type=\"password\" class=\"form-control input-sm\" id=\"pw\" name=\"pw\" placeholder=\"(대/소)영문/특수문자 포함 8자~10자 입력가능.\" oninput=\"handlePWLength(this, 10)\" onblur=\"trimInput(this)\" onkeydown=\"preventSpace(event)\">\r\n");
      out.write("                            </div>\r\n");
      out.write("\r\n");
      out.write("                            <button type=\"button\" id=\"listBtn\" class=\"btn btn-dark\">목록</button>    \r\n");
      out.write("                            <button type=\"button\" id=\"registBtn\" class=\"btn btn-primary\">등록</button>\r\n");
      out.write("\r\n");
      out.write("                    </form>\r\n");
      out.write("                    \r\n");
      out.write("                </div>\r\n");
      out.write("            </div>    \r\n");
      out.write("       </div>\r\n");
      out.write("    </section>\r\n");
      out.write("    \r\n");
      out.write("    \r\n");
      out.write("    <script>\r\n");
      out.write("\r\n");
      out.write("            const registBtn = document.getElementById('registBtn');\r\n");
      out.write("            //목록 이동 처리\r\n");
      out.write("            document.getElementById('listBtn').onclick = function() {\r\n");
      out.write("                location.href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/freeboard/freeList\"\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            const $form = document.registForm;\r\n");
      out.write("            const titleInput = document.getElementById('title');\r\n");
      out.write("            const writerInput = document.getElementById('writer');\r\n");
      out.write("            const contentInput = document.getElementById('content');\r\n");
      out.write("            const pwInput = document.getElementById('pw');\r\n");
      out.write("\r\n");
      out.write("            function hasBadWords(inputText){\r\n");
      out.write("                const badWordsRegex = /(바보|멍청이|똥깨|씨발|개새끼|시발|OR|SELECT|INSERT|DELETE|UPDATE|CREATE|DROP|EXEC|UNION|FETCH|DECLARE|TRUNCATE)/gi;//파일처리하면 더 좋을것같음.\r\n");
      out.write("                return badWordsRegex.test(inputText);\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            //입력에 따라 textarea 변함\r\n");
      out.write("            const contentTextarea = document.getElementById('content');\r\n");
      out.write("            function adjustTextareaHeight() {\r\n");
      out.write("                contentTextarea.style.height = 'auto';\r\n");
      out.write("                contentTextarea.style.height = contentTextarea.scrollHeight + 'px';\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            contentTextarea.addEventListener('input', adjustTextareaHeight);\r\n");
      out.write("            window.addEventListener('load', adjustTextareaHeight);\r\n");
      out.write("\r\n");
      out.write("            //글자 수 세기\r\n");
      out.write("            function countWords(textarea, maxLength) {\r\n");
      out.write("                let text = textarea.value;\r\n");
      out.write("                let currentLength = text.length;\r\n");
      out.write("                let remainingLength = maxLength - currentLength;\r\n");
      out.write("                let lengthCheckSpan = document.getElementById('textLengthCheck');\r\n");
      out.write("                lengthCheckSpan.textContent = currentLength > maxLength ? maxLength + ' / ' + maxLength : currentLength + ' / ' + maxLength;\r\n");
      out.write("                \r\n");
      out.write("                if (currentLength > maxLength) {\r\n");
      out.write("                    textarea.value = textarea.value.substring(0, maxLength);\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            //글 등록\r\n");
      out.write("            registBtn.onclick = function() {\r\n");
      out.write("\r\n");
      out.write("                const titleValue = titleInput.value;\r\n");
      out.write("                const writerValue = writerInput.value;\r\n");
      out.write("                const contentValue = contentInput.value;\r\n");
      out.write("                const pwValue = pwInput.value;\r\n");
      out.write("                const passwordRegex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[$@!%*#?&])[a-zA-Z0-9$@!%*#?&]{8,10}$/; //최소 8 자 및 최대 10 자, 하나 이상의 대문자, 하나의 소문자, 하나의 숫자 및 하나의 특수 문자 정규식\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                if(writerValue === ''){\r\n");
      out.write("                    alert('작성자는 필수 항목');\r\n");
      out.write("                    $form.writer.focus();\r\n");
      out.write("                    return;\r\n");
      out.write("                }    \r\n");
      out.write("                else if(titleValue === ''){\r\n");
      out.write("                    alert('제목은 필수 항목');\r\n");
      out.write("                    $form.title.focus();\r\n");
      out.write("                    return;\r\n");
      out.write("                }\r\n");
      out.write("                else if(contentValue === ''){\r\n");
      out.write("                    alert('내용은 필수 항목');\r\n");
      out.write("                    $form.content.focus();\r\n");
      out.write("                    return;\r\n");
      out.write("                }\r\n");
      out.write("                else if(pwValue === ''){\r\n");
      out.write("                    alert('비밀번호는 필수 항목');\r\n");
      out.write("                    $form.pw.focus();\r\n");
      out.write("                    return;\r\n");
      out.write("                }\r\n");
      out.write("                // 앞뒤 공백을 제거하고 빈 칸 여부 판단\r\n");
      out.write("                else if (writerValue.trim() === '') {\r\n");
      out.write("                    alert('공백만으로 글을 작성할 수 없습니다.(작성자)');\r\n");
      out.write("                    return;\r\n");
      out.write("                    \r\n");
      out.write("                }\r\n");
      out.write("                else if (titleValue.trim() === '') {\r\n");
      out.write("                    alert('공백만으로 글을 작성할 수 없습니다.(제목)');\r\n");
      out.write("                    return;\r\n");
      out.write("                    \r\n");
      out.write("                } \r\n");
      out.write("                else if (contentValue.trim() === '') {\r\n");
      out.write("                    alert('공백만으로 글을 작성할 수 없습니다.(내용)');\r\n");
      out.write("                    return;\r\n");
      out.write("                    \r\n");
      out.write("                }\r\n");
      out.write("                else if (pwValue.trim() === '') {\r\n");
      out.write("                        alert('공백만으로 글을 작성할 수 없습니다.(비밀번호)');\r\n");
      out.write("                        return;\r\n");
      out.write("                        \r\n");
      out.write("                    }\r\n");
      out.write("                // 욕설이 포함된 경우, sql 문 막기\r\n");
      out.write("                else if (hasBadWords(titleValue) || hasBadWords(writerValue) || hasBadWords(contentValue)) {\r\n");
      out.write("                        alert('사용할 수 없는 단어가 포함되어 있습니다. 글을 등록할 수 없습니다.');\r\n");
      out.write("                        return;\r\n");
      out.write("                    }\r\n");
      out.write("                   \r\n");
      out.write("                else if (!passwordRegex.test(pwValue)) {\r\n");
      out.write("                        const pwErrorMsg = document.getElementById('pwErrorMsg');\r\n");
      out.write("                        alert('비밀번호는 (대/소)영문/특수문자 포함 8자~10자여야 합니다.');\r\n");
      out.write("                        pwInput.focus();\r\n");
      out.write("                        return;\r\n");
      out.write("                    }\r\n");
      out.write("                else{\r\n");
      out.write("                    console.log(titleValue);\r\n");
      out.write("                    $form.submit();\r\n");
      out.write("                }\r\n");
      out.write("\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            //작성자 글자수 제한\r\n");
      out.write("            function handleWriterLength(el, max) {\r\n");
      out.write("                const trimmedValue = el.value.trim();\r\n");
      out.write("                if(trimmedValue.length > max) {\r\n");
      out.write("                    el.value = el.value.substr(0, max);\r\n");
      out.write("                    alert('15자를 넘었습니다.')\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            //제목 글자수 제한\r\n");
      out.write("            function handleTitleLength(el, max) {\r\n");
      out.write("                const trimmedValue = el.value.trim();\r\n");
      out.write("                if(trimmedValue.length > max) {\r\n");
      out.write("                    el.value = el.value.substr(0, max);\r\n");
      out.write("                    alert('100자를 넘었습니다.')\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            //내용 글자수 제한\r\n");
      out.write("            function handleContentLength(el, max) {\r\n");
      out.write("                const trimmedValue = el.value.trim();\r\n");
      out.write("                if(trimmedValue.length > max) {\r\n");
      out.write("                    el.value = el.value.substr(0, max);\r\n");
      out.write("                    alert('1000자를 넘었습니다.')\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            //비밀번호 글자수 제한\r\n");
      out.write("            function handlePWLength(el, max) {\r\n");
      out.write("                const trimmedValue = el.value.trim();\r\n");
      out.write("                if(trimmedValue.length > max) {\r\n");
      out.write("                    el.value = el.value.substr(0, max);\r\n");
      out.write("                    alert('10자를 넘었습니다.')\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            //비밀번호칸에 스페이스바 입력 금지\r\n");
      out.write("            function preventSpace(event) {\r\n");
      out.write("                var keyCode = event.keyCode ? event.keyCode : event.which;\r\n");
      out.write("                if (keyCode === 32) {\r\n");
      out.write("                    event.preventDefault();\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            //글자 submit 전 trim\r\n");
      out.write("            function trimInput(el) {\r\n");
      out.write("                el.value = el.value.trim();\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    </script>\r\n");
      out.write("  ");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
