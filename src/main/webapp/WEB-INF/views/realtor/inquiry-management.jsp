<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>받은 문의 관리 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            background-color: #f8f9fa;
        }
        
        .main-layout {
            display: flex;
            max-width: 1400px;
            margin: 0 auto;
            min-height: calc(100vh - 80px); 
        }

        .sidebar {
            width: 260px;
            background: white;
            padding: 30px 0;
            box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        }

        .sidebar-title {
            padding: 0 25px 20px;
            font-size: 18px;
            font-weight: bold;
            color: #2d3748;
            border-bottom: 2px solid #e2e8f0;
        }

        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
        }

        .sidebar-menu li {
            margin: 5px 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 25px;
            color: #4a5568;
            text-decoration: none;
            transition: all 0.3s;
            font-weight: 500;
        }

        .sidebar-menu a:hover {
            background: #f7fafc;
            color: #667eea;
        }

        .sidebar-menu a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-right: 4px solid #667eea;
        }

        .menu-icon {
            font-size: 20px;
            width: 24px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 32px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #718096;
            font-size: 16px;
        }

        .content-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .stats-bar {
            display: flex;
            gap: 20px;
            padding: 20px;
            background: #f7fafc;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .stat-item {
            flex: 1;
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: 8px;
        }

        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            color: #718096;
        }

        .filter-section {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-label {
            font-size: 14px;
            font-weight: 600;
            color: #4a5568;
        }

        .filter-select {
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: white;
            transition: border-color 0.3s;
        }

        .filter-select:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-box {
            flex: 1;
            position: relative;
            max-width: 400px;
        }

        .search-input {
            width: 100%;
            padding: 10px 40px 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .inquiry-list {
            list-style: none;
        }

        .inquiry-item {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s;
        }

        .inquiry-item:hover {
            border-color: #cbd5e0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .inquiry-item.new {
            border-color: #667eea;
            background: #f7fafc;
        }

        .inquiry-header {
            padding: 20px;
            background: white;
            display: flex;
            justify-content: space-between;
            align-items: start;
            cursor: pointer;
        }

        .inquiry-item.new .inquiry-header {
            background: #f7fafc;
        }

        .inquiry-left {
            flex: 1;
        }

        .inquiry-user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .inquiry-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 20px;
        }

        .inquiry-user-detail h3 {
            font-size: 16px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .inquiry-meta {
            display: flex;
            gap: 15px;
            font-size: 13px;
            color: #718096;
        }

        .inquiry-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .inquiry-property {
            background: #e0e7ff;
            color: #667eea;
            padding: 8px 15px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
            display: inline-block;
        }

        .inquiry-type {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-right: 10px;
        }

        .type-visit {
            background: #c6f6d5;
            color: #22543d;
        }

        .type-price {
            background: #feebc8;
            color: #7c2d12;
        }

        .type-contract {
            background: #e0e7ff;
            color: #434190;
        }

        .type-etc {
            background: #e2e8f0;
            color: #2d3748;
        }

        .inquiry-content {
            color: #4a5568;
            font-size: 15px;
            line-height: 1.6;
            margin-top: 10px;
        }

        .inquiry-right {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
        }

        .inquiry-badge {
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }

        .badge-new {
            background: #feebc8;
            color: #7c2d12;
        }

        .badge-replied {
            background: #c6f6d5;
            color: #22543d;
        }

        .btn-reply {
            padding: 8px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-reply:hover {
            background: #5568d3;
        }

        .inquiry-body {
            padding: 0 20px 20px;
            background: white;
            display: none;
        }

        .inquiry-item.expanded .inquiry-body {
            display: block;
        }

        .inquiry-divider {
            height: 2px;
            background: #e2e8f0;
            margin: 20px 0;
        }

        .reply-section {
            background: #f7fafc;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .reply-title {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .reply-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            min-height: 150px;
            resize: vertical;
            font-family: inherit;
            margin-bottom: 15px;
        }

        .reply-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .reply-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-cancel {
            padding: 10px 24px;
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #f7fafc;
        }

        .btn-submit {
            padding: 10px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background: #5568d3;
        }

        .replied-content {
            background: #c6f6d5;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .replied-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .replied-title {
            font-size: 14px;
            font-weight: 600;
            color: #22543d;
        }

        .replied-date {
            font-size: 13px;
            color: #22543d;
        }

        .replied-text {
            color: #2d3748;
            font-size: 14px;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #718096;
        }
        
        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 14px;
        }
        
        .alert-error {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
            border: 1px solid #f56565;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/realtor-header.jsp" />

    <div class="main-layout">
        <aside class="sidebar">
            <div class="sidebar-title">중개사 메뉴</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/realtor/realtor-dashboard"><span class="menu-icon">📊</span>대시보드</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-management"><span class="menu-icon">🏢</span>매물 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-register"><span class="menu-icon">➕</span>매물 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/inquiry-management" class="active"><span class="menu-icon">💬</span>받은 문의</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>받은 문의 관리</h1>
                <p>고객 문의에 빠르게 답변하세요</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <div class="content-section">
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-number">${stats.totalCount}</div>
                        <div class="stat-label">전체 문의</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" style="color: #ed8936;">${stats.pendingCount}</div>
                        <div class="stat-label">미답변</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" style="color: #48bb78;">${stats.answeredCount}</div>
                        <div class="stat-label">답변완료</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" style="color: #4299e1;">${stats.todayCount}</div>
                        <div class="stat-label">오늘 문의</div>
                    </div>
                </div>

                <div class="filter-section">
                    <div class="filter-group">
                        <span class="filter-label">상태</span>
                        <select class="filter-select" id="statusFilter">
                            <option value="">전체</option>
                            <option value="PENDING">미답변</option>
                            <option value="ANSWERED">답변완료</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <span class="filter-label">문의유형</span>
                        <select class="filter-select" id="categoryFilter">
                            <option value="">전체</option>
                            <option value="VISIT">방문 문의</option>
                            <option value="PRICE">가격 문의</option>
                            <option value="CONTRACT">계약 문의</option>
                            <option value="ETC">기타</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <span class="filter-label">정렬</span>
                        <select class="filter-select" id="sortFilter">
                            <option value="latest">최신순</option>
                            <option value="oldest">오래된순</option>
                            <option value="pending">미답변 우선</option>
                        </select>
                    </div>
                    <div class="search-box">
                        <input type="text" class="search-input" id="searchInput" placeholder="문의자, 매물명으로 검색...">
                        <span class="search-icon">🔍</span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty inquiries}">
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <h3>받은 문의가 없습니다</h3>
                            <p>고객이 문의를 남기면 여기에 표시됩니다</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="inquiry-list" id="inquiryList">
                            <c:forEach var="inquiry" items="${inquiries}">
                                <li class="inquiry-item ${inquiry.status == 'PENDING' ? 'new' : ''}" data-inquiry-id="${inquiry.inquiryId}" data-status="${inquiry.status}" data-category="${inquiry.category}">
                                    <div class="inquiry-header" onclick="toggleInquiry(this.parentElement)">
                                        <div class="inquiry-left">
                                            <div class="inquiry-user-info">
                                                <div class="inquiry-avatar">
                                                    ${inquiry.userName.substring(0, 1)}
                                                </div>
                                                <div class="inquiry-user-detail">
                                                    <h3>${inquiry.userName} 님</h3>
                                                    <div class="inquiry-meta">
                                                        <span>📞 ${inquiry.userPhone}</span>
                                                        <span>🕐 <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <c:if test="${not empty inquiry.propertyName}">
                                                <div class="inquiry-property">🏠 ${inquiry.propertyName}</div>
                                            </c:if>
                                            
                                            <div>
                                                <c:choose>
                                                    <c:when test="${inquiry.category == 'VISIT'}">
                                                        <span class="inquiry-type type-visit">방문 문의</span>
                                                    </c:when>
                                                    <c:when test="${inquiry.category == 'PRICE'}">
                                                        <span class="inquiry-type type-price">가격 문의</span>
                                                    </c:when>
                                                    <c:when test="${inquiry.category == 'CONTRACT'}">
                                                        <span class="inquiry-type type-contract">계약 문의</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inquiry-type type-etc">기타</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="inquiry-content">${inquiry.title}</span>
                                            </div>
                                        </div>
                                        <div class="inquiry-right">
                                            <c:choose>
                                                <c:when test="${inquiry.status == 'PENDING'}">
                                                    <span class="inquiry-badge badge-new">새 문의</span>
                                                    <button class="btn-reply" onclick="event.stopPropagation(); showReplyForm(this)">답변하기</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inquiry-badge badge-replied">답변완료</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <div class="inquiry-body">
                                        <div class="inquiry-divider"></div>
											<div style="margin-bottom: 20px;">
                                            <div style="background: #f7fafc; padding: 15px; border-radius: 8px;">
                                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                                                    <h4 style="font-size: 14px; color: #4a5568; font-weight: 600;">문의 내용</h4>
                                                    <span style="font-size: 13px; color: #718096;">
                                                        <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                                                    </span>
                                                </div>
                                                <div style="white-space: pre-wrap; line-height: 1.6;">${inquiry.content}</div>
                                            </div>
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${inquiry.status == 'PENDING'}">
                                                <div class="reply-section">
                                                    <div class="reply-title">💬 답변 작성</div>
                                                    <textarea class="reply-textarea" placeholder="고객님께 답변을 작성하세요..."></textarea>
                                                    <div class="reply-actions">
                                                        <button class="btn-cancel" onclick="event.stopPropagation(); hideReplyForm(this)">취소</button>
                                                        <button class="btn-submit" onclick="event.stopPropagation(); submitReply(this, ${inquiry.inquiryId})">답변 전송</button>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="replied-content">
                                                    <div class="replied-header">
                                                        <span class="replied-title">✅ 답변 완료</span>
                                                        <span class="replied-date">
                                                            <fmt:formatDate value="${inquiry.answeredAt}" pattern="yyyy.MM.dd HH:mm"/>
                                                        </span>
                                                    </div>
                                                    <div class="replied-text">${inquiry.answer}</div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script>
        function toggleInquiry(element) {
            const inquiryId = element.dataset.inquiryId;
            const isExpanded = element.classList.contains('expanded');
            
            if (!isExpanded && element.classList.contains('new')) {
                // 읽음 처리
                markAsRead(inquiryId);
            }
            
            element.classList.toggle('expanded');
        }

        function showReplyForm(button) {
            const inquiryItem = button.closest('.inquiry-item');
            inquiryItem.classList.add('expanded');
        }

        function hideReplyForm(button) {
            const inquiryItem = button.closest('.inquiry-item');
            inquiryItem.classList.remove('expanded');
        }

        function submitReply(button, inquiryId) {
            const inquiryItem = button.closest('.inquiry-item');
            const textarea = inquiryItem.querySelector('.reply-textarea');
            const answer = textarea.value.trim();
            
            if (answer === '') {
                alert('답변 내용을 입력해주세요.');
                return;
            }

            if (!confirm('답변을 전송하시겠습니까?')) {
                return;
            }

            // AJAX로 답변 전송
            fetch('${pageContext.request.contextPath}/realtor/inquiry/answer', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'inquiryId=' + inquiryId + '&answer=' + encodeURIComponent(answer)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('답변이 전송되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || '답변 전송에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }

        function markAsRead(inquiryId) {
            fetch('${pageContext.request.contextPath}/realtor/inquiry/read', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'inquiryId=' + inquiryId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('읽음 처리 완료');
                }
            })
            .catch(error => {
                console.error('읽음 처리 실패:', error);
            });
        }

        // 필터링 기능
        document.getElementById('statusFilter').addEventListener('change', filterInquiries);
        document.getElementById('categoryFilter').addEventListener('change', filterInquiries);
        document.getElementById('searchInput').addEventListener('input', filterInquiries);

        function filterInquiries() {
            const statusFilter = document.getElementById('statusFilter').value;
            const categoryFilter = document.getElementById('categoryFilter').value;
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            
            const inquiryItems = document.querySelectorAll('.inquiry-item');
            
            inquiryItems.forEach(item => {
                const status = item.dataset.status;
                const category = item.dataset.category;
                const text = item.textContent.toLowerCase();
                
                let show = true;
                
                if (statusFilter && status !== statusFilter) show = false;
                if (categoryFilter && category !== categoryFilter) show = false;
                if (searchText && !text.includes(searchText)) show = false;
                
                item.style.display = show ? 'block' : 'none';
            });
        }
    </script>
</body>
</html>