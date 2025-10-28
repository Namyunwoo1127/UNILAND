<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UNILAND 관리자 - 문의관리</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
      background-color: #f5f5f5;
      color: #1a1a1a;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* 헤더 */
    header {
      background: white;
      border-bottom: 1px solid #e5e5e5;
      padding: 18px 0;
      position: sticky;
      top: 0;
      z-index: 100;
    }
    .header-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 24px;
    }
    .logo img { 
      height: 60px;
      object-fit: contain;
      cursor: pointer;
    }
    .btn-login {
      background: linear-gradient(90deg, #667eea, #764ba2);
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 25px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
    }
    .btn-login:hover { 
      background: linear-gradient(90deg, #5a67d8, #6b46c1);
      transform: translateY(-2px); 
    }

    /* 레이아웃 */
    .admin-container { flex: 1; display: flex; }

    /* 사이드바 */
    .sidebar {
      width: 240px;
      background: #ffffff;
      border-right: 1px solid #e5e5e5;
      padding-top: 24px;
    }
    .sidebar h3 {
      text-align: center;
      color: #667eea;
      margin-bottom: 20px;
      font-size: 18px;
      font-weight: 700;
    }
    .sidebar ul { list-style: none; }
    .sidebar li {
      padding: 14px 24px;
      color: #333;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: all 0.2s;
    }
    .sidebar li:hover { background: #f0f2ff; color: #667eea; }
    .sidebar li.active { background: #e6e8ff; color: #5568d3; font-weight: 600; }

    /* 메인 콘텐츠 */
    .main-content {
      flex: 1;
      padding: 32px;
      overflow-y: auto;
    }
    .page-header {
      margin-bottom: 30px;
    }
    .page-header h2 { 
      font-size: 28px; 
      font-weight: 700; 
      color: #1a1a1a;
      margin-bottom: 8px;
    }
    .page-header p {
      color: #718096;
      font-size: 14px;
    }

    /* 통계 바 */
    .stats-bar {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 30px;
    }
    .stat-card {
      background: white;
      padding: 24px;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      text-align: center;
      transition: transform 0.2s;
    }
    .stat-card:hover {
      transform: translateY(-4px);
    }
    .stat-number {
      font-size: 32px;
      font-weight: 700;
      color: #667eea;
      margin-bottom: 8px;
    }
    .stat-label {
      font-size: 14px;
      color: #718096;
    }

    /* 필터 섹션 */
    .filter-section {
      display: flex;
      gap: 15px;
      margin-bottom: 24px;
      flex-wrap: wrap;
      align-items: center;
      background: white;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
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
      transition: border-color 0.3s;
    }
    .filter-select:focus {
      outline: none;
      border-color: #667eea;
    }

    /* 문의 목록 */
    .inquiry-list {
      list-style: none;
    }
    .inquiry-item {
      background: white;
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

    /* 문의 헤더 */
    .inquiry-header {
      padding: 24px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
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
      font-weight: 700;
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

    .inquiry-type {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 600;
      margin-right: 10px;
    }
    .type-general {
      background: #e0e7ff;
      color: #667eea;
    }
    .type-property {
      background: #c6f6d5;
      color: #22543d;
    }
    .type-contract {
      background: #feebc8;
      color: #7c2d12;
    }

    .inquiry-title {
      font-size: 18px;
      font-weight: 600;
      color: #2d3748;
      margin: 12px 0;
    }
    .inquiry-content {
      color: #4a5568;
      font-size: 15px;
      line-height: 1.6;
    }

    /* 문의 오른쪽 */
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
    .badge-pending {
      background: #feebc8;
      color: #7c2d12;
    }
    .badge-answered {
      background: #c6f6d5;
      color: #22543d;
    }
    .btn-answer {
      padding: 8px 20px;
      background: #667eea;
      color: white;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
    }
    .btn-answer:hover {
      background: #5568d3;
      transform: translateY(-2px);
    }

    /* 문의 본문 */
    .inquiry-body {
      padding: 0 24px 24px;
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

    /* 답변 섹션 */
    .reply-section {
      background: #f7fafc;
      padding: 20px;
      border-radius: 8px;
    }
    .reply-title {
      font-size: 16px;
      font-weight: 600;
      color: #2d3748;
      margin-bottom: 15px;
      display: flex;
      align-items: center;
      gap: 8px;
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
      border-radius: 8px;
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
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
    }
    .btn-submit:hover {
      background: #5568d3;
      transform: translateY(-2px);
    }

    /* 답변 완료 */
    .answered-content {
      background: #c6f6d5;
      padding: 20px;
      border-radius: 8px;
    }
    .answered-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 12px;
    }
    .answered-title {
      font-size: 14px;
      font-weight: 600;
      color: #22543d;
    }
    .answered-date {
      font-size: 13px;
      color: #22543d;
    }
    .answered-text {
      color: #2d3748;
      font-size: 14px;
      line-height: 1.6;
    }

    /* 푸터 */
    footer {
      background: #2a2a2a;
      color: #999;
      padding: 40px 0;
      text-align: center;
      font-size: 13px;
    }

    /* 알림 메시지 */
    .alert {
      padding: 16px 20px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .alert-success {
      background: #c6f6d5;
      color: #22543d;
      border: 1px solid #9ae6b4;
    }
    .alert-error {
      background: #fed7d7;
      color: #742a2a;
      border: 1px solid #fc8181;
    }
  </style>
</head>
<body>
  <!-- 헤더 -->
  <header>
    <div class="header-container">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND 관리자">
      </div>
      <div class="auth-buttons">
        <button class="btn-login"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</button>
      </div>
    </div>
  </header>

  <div class="admin-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <h3>관리 메뉴</h3>
      <ul>
        <li><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li><i class="fa-solid fa-users"></i> 회원관리</li>
        <li><i class="fa-solid fa-building"></i> 매물관리</li>
        <li><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li class="active"><i class="fa-solid fa-envelope"></i> 문의관리</li>
        <li><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
      <div class="page-header">
        <h2>문의 관리</h2>
        <p>사용자 문의에 빠르게 답변하세요</p>
      </div>

      <!-- 알림 메시지 -->
      <c:if test="${not empty message}">
        <div class="alert alert-success">
          <i class="fa-solid fa-circle-check"></i> ${message}
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-error">
          <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
      </c:if>

      <!-- 통계 바 -->
      <div class="stats-bar">
        <div class="stat-card">
          <div class="stat-number">
            <c:choose>
              <c:when test="${not empty inquiryList}">
                ${inquiryList.size()}
              </c:when>
              <c:otherwise>0</c:otherwise>
            </c:choose>
          </div>
          <div class="stat-label">전체 문의</div>
        </div>
        <div class="stat-card">
          <div class="stat-number" style="color: #ed8936;">
            <c:set var="pendingCount" value="0"/>
            <c:forEach var="inquiry" items="${inquiryList}">
              <c:if test="${inquiry.status == 'PENDING'}">
                <c:set var="pendingCount" value="${pendingCount + 1}"/>
              </c:if>
            </c:forEach>
            ${pendingCount}
          </div>
          <div class="stat-label">미답변</div>
        </div>
        <div class="stat-card">
          <div class="stat-number" style="color: #48bb78;">
            <c:set var="answeredCount" value="0"/>
            <c:forEach var="inquiry" items="${inquiryList}">
              <c:if test="${inquiry.status == 'ANSWERED'}">
                <c:set var="answeredCount" value="${answeredCount + 1}"/>
              </c:if>
            </c:forEach>
            ${answeredCount}
          </div>
          <div class="stat-label">답변완료</div>
        </div>
        <div class="stat-card">
          <div class="stat-number" style="color: #4299e1;">0</div>
          <div class="stat-label">오늘 문의</div>
        </div>
      </div>

      <!-- 필터 섹션 -->
      <div class="filter-section">
        <div class="filter-group">
          <span class="filter-label">상태</span>
          <select class="filter-select">
            <option>전체</option>
            <option>미답변</option>
            <option>답변완료</option>
          </select>
        </div>
        <div class="filter-group">
          <span class="filter-label">문의유형</span>
          <select class="filter-select">
            <option>전체</option>
            <option>일반문의</option>
            <option>건의사항</option>
            <option>허위매물신고</option>
            <option>계약문의</option>
            <option>기타</option>
          </select>
        </div>
        <div class="filter-group">
          <span class="filter-label">정렬</span>
          <select class="filter-select">
            <option>최신순</option>
            <option>오래된순</option>
            <option>미답변 우선</option>
          </select>
        </div>
      </div>

      <!-- 문의 목록 -->
      <ul class="inquiry-list">
        <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
          <li class="inquiry-item ${inquiry.status == 'PENDING' ? 'new' : ''}">
            <div class="inquiry-header" onclick="toggleInquiry(this)">
              <div class="inquiry-left">
                <div class="inquiry-user-info">
                  <div class="inquiry-avatar">
                    ${inquiry.userName != null ? inquiry.userName.substring(0,1) : 'U'}
                  </div>
                  <div class="inquiry-user-detail">
                    <h3>${inquiry.userName != null ? inquiry.userName : '알 수 없음'} 님</h3>
                    <div class="inquiry-meta">
                      <span><i class="fa-solid fa-user"></i> ${inquiry.userId}</span>
                      <span><i class="fa-solid fa-clock"></i> 
                        <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                      </span>
                    </div>
                  </div>
                </div>
                <div>
                  <span class="inquiry-type type-${inquiry.inquiryType == 'GENERAL' ? 'general' : inquiry.inquiryType == 'PROPERTY' ? 'property' : 'contract'}">
                    ${inquiry.inquiryType == 'GENERAL' ? '일반문의' : inquiry.inquiryType == 'PROPERTY' ? '매물문의' : '계약문의'}
                  </span>
                  <c:if test="${not empty inquiry.category}">
                    <span class="inquiry-type type-general">${inquiry.category}</span>
                  </c:if>
                </div>
                <div class="inquiry-title">${inquiry.title}</div>
                <div class="inquiry-content">
                  ${inquiry.content.length() > 100 ? inquiry.content.substring(0, 100).concat('...') : inquiry.content}
                </div>
              </div>
              <div class="inquiry-right">
                <span class="inquiry-badge ${inquiry.status == 'PENDING' ? 'badge-pending' : 'badge-answered'}">
                  ${inquiry.status == 'PENDING' ? '미답변' : '답변완료'}
                </span>
                <c:if test="${inquiry.status == 'PENDING' && inquiry.inquiryType == 'ADMIN'}">
                  <button class="btn-answer" onclick="event.stopPropagation(); showReplyForm(this)">
                    <i class="fa-solid fa-reply"></i> 답변하기
                  </button>
                </c:if>
              </div>
            </div>
            <div class="inquiry-body">
              <div class="inquiry-divider"></div>
              
              <c:choose>
                <c:when test="${inquiry.status == 'PENDING'}">
                  <!-- 답변 작성 폼 -->
                  <div class="reply-section">
                    <div class="reply-title">
                      <i class="fa-solid fa-pen"></i> 답변 작성
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/inquiry-answer/${inquiry.inquiryId}" 
                          method="post" 
                          onsubmit="return validateAnswer(this)">
                      <textarea name="answer" 
                                class="reply-textarea" 
                                placeholder="고객님께 답변을 작성하세요..."
                                required></textarea>
                      <div class="reply-actions">
                        <button type="button" class="btn-cancel" onclick="event.stopPropagation(); hideReplyForm(this)">
                          취소
                        </button>
                        <button type="submit" class="btn-submit">
                          <i class="fa-solid fa-paper-plane"></i> 답변 전송
                        </button>
                      </div>
                    </form>
                  </div>
                </c:when>
                <c:otherwise>
                  <!-- 답변 완료 -->
                  <div class="answered-content">
                    <div class="answered-header">
                      <span class="answered-title">
                        <i class="fa-solid fa-check-circle"></i> 답변 완료
                      </span>
                      <span class="answered-date">
                        <fmt:formatDate value="${inquiry.answeredAt}" pattern="yyyy.MM.dd HH:mm"/>
                      </span>
                    </div>
                    <div class="answered-text">
                      ${inquiry.answer}
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </li>
        </c:forEach>
        
        <c:if test="${empty inquiryList}">
          <li style="text-align: center; padding: 80px 20px; background: white; border-radius: 12px;">
            <div style="font-size: 60px; margin-bottom: 20px;">📭</div>
            <h3 style="font-size: 20px; color: #2d3748; margin-bottom: 10px;">등록된 문의가 없습니다</h3>
            <p style="color: #718096;">문의가 등록되면 여기에 표시됩니다.</p>
          </li>
        </c:if>
      </ul>
    </main>
  </div>

  <!-- 푸터 -->
  <footer>
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    function toggleInquiry(element) {
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

    function validateAnswer(form) {
      const textarea = form.querySelector('textarea[name="answer"]');
      if (textarea.value.trim() === '') {
        alert('답변 내용을 입력해주세요.');
        return false;
      }
      if (textarea.value.trim().length < 3) {
        alert('답변 내용을 3자 이상 입력해주세요.');
        return false;
      }
      return confirm('답변을 전송하시겠습니까?');
    }

    // 사이드바 메뉴 클릭
    document.querySelectorAll('.sidebar li').forEach((item, index) => {
      item.addEventListener('click', function() {
        document.querySelectorAll('.sidebar li').forEach(li => li.classList.remove('active'));
        this.classList.add('active');

        const pages = [
          '${pageContext.request.contextPath}/admin/dashboard',
          '${pageContext.request.contextPath}/admin/user-management',
          '${pageContext.request.contextPath}/admin/property-management',
          '${pageContext.request.contextPath}/admin/content-management',
          '${pageContext.request.contextPath}/admin/inquiry-management',
          '${pageContext.request.contextPath}/admin/realtor-approval'
        ];
        
        if (pages[index]) {
          window.location.href = pages[index];
        }
      });
    });

    // 로고 클릭
    document.querySelector('.logo').addEventListener('click', function() {
      window.location.href = '${pageContext.request.contextPath}/uniland';
    });

    // 로그아웃
    document.querySelector('.btn-login').addEventListener('click', function() {
      if (confirm('로그아웃 하시겠습니까?')) {
        window.location.href = '${pageContext.request.contextPath}/auth/logout';
      }
    });

    // 알림 메시지 자동 사라지기
    setTimeout(function() {
      const alerts = document.querySelectorAll('.alert');
      alerts.forEach(alert => {
        alert.style.transition = 'opacity 0.5s';
        alert.style.opacity = '0';
        setTimeout(() => alert.remove(), 500);
      });
    }, 3000);
  </script>
</body>
</html>