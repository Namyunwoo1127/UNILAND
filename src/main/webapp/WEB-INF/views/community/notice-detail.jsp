<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기 - UNILAND</title>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background: #f5f5f5; margin: 0; padding: 0; }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            font-size: 26px;
            margin-bottom: 15px;
            color: #333;
        }
        .meta {
            color: #888;
            font-size: 14px;
            margin-bottom: 25px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .meta span { margin-right: 15px; }
        .content {
            font-size: 16px;
            line-height: 1.7;
            color: #333;
            white-space: pre-line;
            min-height: 200px;
            margin-bottom: 30px;
        }
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            margin-right: 5px;
        }
        .badge-important { background: #f56565; color: white; }
        .badge-new { background: #48bb78; color: white; }
        .btn-area {
            text-align: right;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 14px;
            text-decoration: none;
            margin-left: 10px;
            transition: background 0.2s;
        }
        .btn-back { background: #ccc; color: #fff; }
        .btn-back:hover { background: #b5b5b5; }
        .btn-edit { background: #667eea; color: #fff; }
        .btn-edit:hover { background: #5568d3; }
        .btn-delete { background: #f56565; color: #fff; }
        .btn-delete:hover { background: #e53e3e; }
        .alert {
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 4px;
        }
        .alert-error { background: #ffe8e8; color: #f56565; border: 1px solid #f56565; }
        .alert-success { background: #e8f5e9; color: #48bb78; border: 1px solid #48bb78; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <h1>
            <c:if test="${notice.noticeImportant == 'Y'}">
                <span class="badge badge-important">중요</span>
            </c:if>
            <c:if test="${notice.noticeIsnew == 'Y'}">
                <span class="badge badge-new">NEW</span>
            </c:if>
            ${notice.noticeSubject}
        </h1>

        <div class="meta">
            <span>작성자: ${notice.noticeWriter}</span>
            <span>작성일: <fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd HH:mm"/></span>
            <span>조회수: ${notice.viewCount}</span>
        </div>

        <!-- 공지 내용 -->
        <div class="content">
            ${notice.noticeContent}
        </div>

        <!-- 메시지 출력 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="btn-area">
            <a href="${pageContext.request.contextPath}/community/notice" class="btn btn-back">목록으로</a>

            <!-- 작성자 또는 관리자일 때만 수정/삭제 버튼 표시 -->
            <c:if test="${not empty sessionScope.loginUser && (sessionScope.loginUser.userId == 'admin')}">
            	<a href="${pageContext.request.contextPath}/admin/content-management" class="btn btn-back">관리자 목록으로</a>
                <a href="${pageContext.request.contextPath}/community/notice-update/${notice.noticeNo}" class="btn btn-edit">수정</a>
                <form action="${pageContext.request.contextPath}/community/notice/delete/${notice.noticeNo}" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                </form>
            </c:if>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
