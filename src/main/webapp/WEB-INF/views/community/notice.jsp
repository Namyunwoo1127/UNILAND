<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 - UNILAND</title>
    <style>
        /* 기본 스타일 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background: #f5f5f5; }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        h1 {
            font-size: 28px;
            margin-bottom: 30px;
            color: #333;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .alert-error {
            background: #ffe8e8;
            color: #f56565;
            border: 1px solid #f56565;
        }
        
        .alert-success {
            background: #e8f5e9;
            color: #48bb78;
            border: 1px solid #48bb78;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        table thead {
            background: #f8f8f8;
        }
        
        table th, table td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #e5e5e5;
        }
        
        table th {
            font-weight: 600;
            color: #666;
        }
        
        table tbody tr {
            cursor: pointer;
            transition: background 0.2s;
        }
        
        table tbody tr:hover {
            background: #f8f8f8;
        }
        
        .notice-title {
            text-align: left !important;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-important {
            background: #f56565;
            color: white;
        }
        
        .badge-new {
            background: #48bb78;
            color: white;
        }
        
        .no-data {
            text-align: center;
            padding: 60px 0;
            color: #999;
            font-size: 16px;
        }
        
        .btn-area {
            text-align: right;
            margin-top: 20px;
        }
        
        .btn-write {
            display: inline-block;
            padding: 12px 24px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: background 0.2s;
        }
        
        .btn-write:hover {
            background: #5568d3;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
    <div class="container">
        <h1>📢 공지사항</h1>
        
        <!-- 에러 메시지 -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <!-- 성공 메시지 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <!-- 공지사항 목록 -->
        <div class="notice-list">
            <c:choose>
                <c:when test="${not empty noticeList}">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 10%">번호</th>
                                <th style="width: 50%">제목</th>
                                <th style="width: 15%">작성자</th>
                                <th style="width: 10%">조회수</th>
                                <th style="width: 15%">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="notice" items="${noticeList}">
                                <tr onclick="location.href='${pageContext.request.contextPath}/community/notice/${notice.noticeNo}'">
                                    <td>${notice.noticeNo}</td>
                                    <td class="notice-title">
                                        <c:if test="${notice.noticeImportant == 'Y'}">
                                            <span class="badge badge-important">중요</span>
                                        </c:if>
                                        <c:if test="${notice.noticeIsnew == 'Y'}">
                                            <span class="badge badge-new">NEW</span>
                                        </c:if>
                                        <span>${notice.noticeSubject}</span>
                                    </td>
                                    <td>${notice.noticeWriter}</td>
                                    <td>${notice.viewCount}</td>
                                    <td><fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="no-data">등록된 공지사항이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 작성 버튼 -->
        <c:if test="${not empty sessionScope.loginUser && (sessionScope.loginUser.userId == 'admin')}">
            <div class="btn-area">
                <a href="${pageContext.request.contextPath}/community/notice-write" class="btn-write">공지사항 작성</a>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>