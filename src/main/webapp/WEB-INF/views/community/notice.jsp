<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif; color: #1a1a1a; background-color: #f5f5f5; line-height: 1.6; }
        .main-container { max-width: 1200px; margin: 0 auto; padding: 40px 24px; }
        .page-header { text-align: center; margin-bottom: 50px; }
        .page-title { font-size: 36px; font-weight: 700; color: #1a1a1a; margin-bottom: 12px; }
        .page-subtitle { font-size: 16px; color: #666; }
        .content-wrapper { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); padding: 30px; }
        .info-box { background: #ebf8ff; border-left: 4px solid #4299e1; padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        .info-box-title { font-size: 16px; font-weight: 600; color: #2c5282; margin-bottom: 8px; display: flex; align-items: center; gap: 8px; }
        .info-box-content { font-size: 14px; color: #2d3748; line-height: 1.6; }
        .controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 2px solid #e5e5e5; }
        .total-count { font-size: 15px; color: #666; }
        .total-count strong { color: #667eea; font-size: 18px; }
        .search-box { display: flex; gap: 10px; max-width: 400px; }
        .search-input { flex: 1; padding: 12px 18px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; transition: border-color 0.2s; }
        .search-input:focus { outline: none; border-color: #667eea; }
        .btn-search { padding: 12px 24px; background: #667eea; color: white; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-search:hover { background: #5568d3; }
        .notice-table { width: 100%; border-collapse: collapse; }
        .notice-table thead { background: #f7fafc; border-top: 2px solid #667eea; border-bottom: 2px solid #e2e8f0; }
        .notice-table th { padding: 16px; text-align: center; font-weight: 600; color: #4a5568; font-size: 14px; }
        .notice-table th.col-number { width: 80px; }
        .notice-table th.col-title { text-align: left; }
        .notice-table th.col-date { width: 120px; }
        .notice-table th.col-views { width: 100px; }
        .notice-table tbody tr { border-bottom: 1px solid #e2e8f0; cursor: pointer; transition: background 0.2s; }
        .notice-table tbody tr:hover { background: #f7fafc; }
        .notice-table tbody tr.important { background: #fff5f5; }
        .notice-table tbody tr.important:hover { background: #fed7d7; }
        .notice-table td { padding: 18px 16px; text-align: center; font-size: 14px; color: #4a5568; }
        .notice-table td.col-title { text-align: left; }
        .notice-number { font-weight: 600; color: #667eea; }
        .notice-badge { display: inline-flex; align-items: center; gap: 4px; color: white; padding: 4px 10px; border-radius: 4px; font-size: 12px; font-weight: 600; margin-right: 8px; }
        .notice-badge.important { background: linear-gradient(135deg, #f56565 0%, #c53030 100%); }
        .notice-badge.new { background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); }
        .notice-title { display: inline; font-weight: 500; color: #1a1a1a; transition: color 0.2s; }
        .notice-table tbody tr:hover .notice-title { color: #667eea; }
        .notice-date { color: #999; }
        .notice-views { color: #666; }
        .pagination { display: flex; justify-content: center; align-items: center; gap: 10px; margin-top: 40px; }
        .pagination button { padding: 10px 15px; border: 2px solid #e2e8f0; background: white; border-radius: 6px; cursor: pointer; font-weight: 600; color: #4a5568; transition: all 0.2s; }
        .pagination button:hover { border-color: #667eea; color: #667eea; }
        .pagination button.active { background: #667eea; color: white; border-color: #667eea; }
        .pagination button:disabled { opacity: 0.5; cursor: not-allowed; }
        .empty-state { text-align: center; padding: 80px 20px; }
        .empty-icon { font-size: 80px; margin-bottom: 20px; opacity: 0.3; }
        .empty-state h3 { font-size: 24px; color: #2d3748; margin-bottom: 10px; }
        .empty-state p { color: #718096; }
        @media (max-width: 968px) {
            .notice-table { display: block; overflow-x: auto; }
            .notice-table th.col-views, .notice-table td.col-views { display: none; }
            .controls { flex-direction: column; gap: 15px; align-items: stretch; }
            .search-box { max-width: 100%; }
        }
        @media (max-width: 768px) {
            .page-title { font-size: 28px; }
            .notice-table th.col-date, .notice-table td.col-date { display: none; }
            .notice-table th.col-number, .notice-table td.col-number { width: 60px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title">📢 공지사항</h1>
            <p class="page-subtitle">UNILAND의 새로운 소식과 업데이트를 확인하세요</p>
        </div>

        <div class="content-wrapper">
            <div class="info-box">
                <div class="info-box-title">
                    <i class="fa-solid fa-circle-info"></i>
                    공지사항 안내
                </div>
                <div class="info-box-content">
                    중요한 공지사항은 상단에 고정되어 표시됩니다.
                    서비스 이용에 필요한 정보를 놓치지 마세요!
                </div>
            </div>

            <div class="controls">
                <div class="total-count">
                    전체 <strong>${totalCount}</strong>개
                </div>
                <form action="${pageContext.request.contextPath}/community/notice" method="get" class="search-box">
                    <input type="text" name="keyword" class="search-input"
                           placeholder="공지사항 검색" value="${keyword}">
                    <button type="submit" class="btn-search">
                        <i class="fa-solid fa-magnifying-glass"></i> 검색
                    </button>
                </form>
            </div>

            <table class="notice-table">
                <thead>
                    <tr>
                        <th class="col-number">번호</th>
                        <th class="col-title">제목</th>
                        <th class="col-date">작성일</th>
                        <th class="col-views">조회수</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty noticeList}">
                        <c:forEach var="notice" items="${noticeList}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/community/notice/${notice.noticeNo}'"
                                class="${notice.important ? 'important' : ''}">
                                <td class="col-number">
                                    <c:choose>
                                        <c:when test="${notice.important}">
                                            <span class="notice-number">
                                                <i class="fa-solid fa-thumbtack"></i>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="notice-number">${notice.noticeNo}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="col-title">
                                    <c:if test="${notice.important}">
                                        <span class="notice-badge important">
                                            <i class="fa-solid fa-exclamation"></i> 필독
                                        </span>
                                    </c:if>
                                    <c:if test="${notice.isNew}">
                                        <span class="notice-badge new">
                                            <i class="fa-solid fa-star"></i> NEW
                                        </span>
                                    </c:if>
                                    <span class="notice-title">${notice.noticeSubject}</span>
                                </td>
                                <td class="col-date">
                                    <span class="notice-date">
                                        <fmt:formatDate value="${notice.noticeCreateAt}" pattern="yyyy.MM.dd"/>
                                    </span>
                                </td>
                                <td class="col-views">
                                    <span class="notice-views">${notice.viewCount}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="empty-state">
                                <div class="empty-icon">📭</div>
                                <h3>등록된 공지사항이 없습니다</h3>
                                <p>새로운 공지사항이 등록되면 알려드릴게요.</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
            </table>

            <!-- 페이지네이션 -->
            <c:if test="${not empty noticeList and totalPages > 1}">
                <div class="pagination">
                    <!-- 이전 버튼 -->
                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <button onclick="location.href='?page=${currentPage - 1}<c:if test="${not empty keyword}">&keyword=${keyword}</c:if>'">
                                <i class="fa-solid fa-chevron-left"></i> 이전
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button disabled><i class="fa-solid fa-chevron-left"></i> 이전</button>
                        </c:otherwise>
                    </c:choose>

                    <!-- 페이지 번호 -->
                    <c:forEach var="i" begin="${startNavi}" end="${endNavi}">
                        <button onclick="location.href='?page=${i}<c:if test="${not empty keyword}">&keyword=${keyword}</c:if>'"
                                class="${i == currentPage ? 'active' : ''}">
                            ${i}
                        </button>
                    </c:forEach>

                    <!-- 다음 버튼 -->
                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <button onclick="location.href='?page=${currentPage + 1}<c:if test="${not empty keyword}">&keyword=${keyword}</c:if>'">
                                다음 <i class="fa-solid fa-chevron-right"></i>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button disabled>다음 <i class="fa-solid fa-chevron-right"></i></button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        // 엔터키로 검색
        document.querySelector('.search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                this.closest('form').submit();
            }
        });
    </script>
</body>
</html>