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
    .inquiry-item.hidden {
      display: none;
    }
    /* 중개사 문의 강조 */
    .inquiry-item.realtor {
      border-color: #f687b3;
      background: #fff5f7;
    }
    .inquiry-item.realtor .inquiry-header {
      background: #fff5f7;
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
    /* 문의 타입별 색상 */
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
    .type-admin {
      background: #e0e7ff;
      color: #667eea;
    }
    /* 카테고리별 색상 */
    .category-general {
      background: #bee3f8;
      color: #2c5282;
    }
    .category-suggestion {
      background: #d9f99d;
      color: #365314;
    }
    .category-report {
      background: #fecaca;
      color: #991b1b;
    }
    .category-etc {
      background: #e9d5ff;
      color: #6b21a8;
    }
    .type-realtor {
      background: #c6f6d5;
      color: #22543d;
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
      white-space: pre-wrap;
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
          <select class="filter-select" id="statusFilter" onchange="applyFilters()">
            <option value="">전체</option>
            <option value="PENDING">미답변</option>
            <option value="ANSWERED">답변완료</option>
          </select>
        </div>
        
        <div class="filter-group">
          <span class="filter-label">대상</span>
          <%-- ▼▼▼ [수정됨] onchange 이벤트 변경 ▼▼▼ --%>
          <select class="filter-select" id="typeFilter" onchange="onTypeFilterChange()">
            <option value="">전체</option>
            <option value="ADMIN">관리자 문의</option>
            <option value="REALTOR">중개사 문의</option>
          </select>
        </div>
        
        <div class="filter-group">
          <span class="filter-label">카테고리</span>
          <select class="filter-select" id="categoryFilter" onchange="applyFilters()">
            <option value="">전체</option>
            <%-- ▼▼▼ [수정됨] data-type 속성 추가 ▼▼▼ --%>
            <option value="일반문의" data-type="ADMIN">일반문의</option>
            <option value="건의사항" data-type="ADMIN">건의사항</option>
            <option value="허위매물신고" data-type="ADMIN">허위매물신고</option>
            <option value="VISIT" data-type="REALTOR">방문 문의</option>
            <option value="PRICE" data-type="REALTOR">가격 문의</option>
            <option value="CONTRACT" data-type="REALTOR">계약 문의</option>
            <option value="기타" data-type="ADMIN">기타</option>
          </select>
        </div>
        <div class="filter-group">
          <span class="filter-label">정렬</span>
          <select class="filter-select" id="sortFilter" onchange="applyFilters()">
            <option value="latest">최신순</option>
            <option value="oldest">오래된순</option>
            <option value="pending">미답변 우선</option>
          </select>
        </div>
      </div>

      <!-- 문의 목록 -->
      <ul class="inquiry-list" id="inquiryList">
        <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
          <li class="inquiry-item ${inquiry.status == 'PENDING' ? 'new' : ''}" 
		    data-status="${inquiry.status}"
		    data-category="${inquiry.category}"
		    data-type="${inquiry.inquiryType}"
		    data-created="${inquiry.createdAt.time}">
            <div class="inquiry-header" onclick="toggleInquiry(this)">
              <div class="inquiry-left">
                <div class="inquiry-user-info">
                  <div class="inquiry-avatar">
                    ${inquiry.userName != null ? inquiry.userName.substring(0,1) : 'U'}
                  </div>
                  <div class="inquiry-user-detail">
                    <h3>
                      ${inquiry.userName != null ? inquiry.userName : '알 수 없음'} 님
                    </h3>
                    <div class="inquiry-meta">
                      <span><i class="fa-solid fa-user"></i> ${inquiry.userId}</span>
                      <span><i class="fa-solid fa-clock"></i> 
                        <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                      </span>
                    </div>
                  </div>
                </div>
                <div>
				<c:choose>
				  <c:when test="${inquiry.inquiryType == 'GENERAL'}">
				    <span class="inquiry-type type-general">일반문의</span>
				  </c:when>
				  <c:when test="${inquiry.inquiryType == 'PROPERTY'}">
				    <span class="inquiry-type type-property">매물문의</span>
				  </c:when>
				  <c:when test="${inquiry.inquiryType == 'CONTRACT'}">
				    <span class="inquiry-type type-contract">계약문의</span>
				  </c:when>
				  <c:when test="${inquiry.inquiryType == 'REALTOR'}">
				    <span class="inquiry-type type-realtor"><i class="fa-solid fa-user-tie"></i> 중개사문의</span>
				  </c:when>
				  <c:when test="${inquiry.inquiryType == 'ADMIN'}">
				    <span class="inquiry-type type-admin"><i class="fa-solid fa-user-shield"></i> 관리자문의</span>
				  </c:when>
				</c:choose>
                  
                  <c:if test="${not empty inquiry.category}">
				  <c:choose>
				    <%-- 관리자 문의 카테고리 --%>
				    <c:when test="${inquiry.category == '일반문의'}">
				      <span class="inquiry-type category-general">${inquiry.category}</span>
				    </c:when>
				    <c:when test="${inquiry.category == '건의사항'}">
				      <span class="inquiry-type category-suggestion">${inquiry.category}</span>
				    </c:when>
				    <c:when test="${inquiry.category == '허위매물신고'}">
				      <span class="inquiry-type category-report">${inquiry.category}</span>
				    </c:when>
				    
				    <%-- ▼▼▼ [수정됨] 중개사 문의 카테고리 한글화 ▼▼▼ --%>
				    <c:when test="${inquiry.category == 'VISIT'}">
				      <span class="inquiry-type category-general">방문 문의</span>
				    </c:when>
				    <c:when test="${inquiry.category == 'PRICE'}">
				      <span class="inquiry-type category-general">가격 문의</span>
				    </c:when>
				    <c:when test="${inquiry.category == 'CONTRACT'}">
				      <span class="inquiry-type category-general">계약 문의</span>
				    </c:when>
				    <%-- ▲▲▲ [수정됨] 중개사 문의 카TEGORY 한글화 ▲▲▲ --%>
				    
				    <%-- 기타 카테고리 --%>
				    <c:otherwise>
				      <span class="inquiry-type category-etc">${inquiry.category}</span>
				    </c:otherwise>
				  </c:choose>
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
                <%-- 1. 미답변(PENDING) 상태일 때 --%>
                <c:when test="${inquiry.status == 'PENDING'}">
                  
                  <%-- 1-1. 미답변이면서 '관리자 문의(ADMIN)'일 때만 답변 폼 표시 --%>
                  <c:choose>
                    <c:when test="${inquiry.inquiryType == 'ADMIN'}">
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
                    
                    <%-- 1-2. 미답변이면서 '중개사 문의(REALTOR)' 등일 때 (여기가 추가된 부분) --%>
                    <c:otherwise>
                      <div style="background: #fff3cd; padding: 15px; border-radius: 6px; text-align: center; color: #856404; border: 1px solid #ffeaa7;">
                          <i class="fa-solid fa-hourglass-half"></i> 
                          
                          <c:choose>
                            <c:when test="${inquiry.inquiryType == 'REALTOR'}">
                              중개사 답변을 기다리고 있습니다. (관리자가 답변할 수 없습니다)
                            </c:when>
                            <c:otherwise>
                              답변을 기다리고 있습니다.
                            </c:otherwise>
                          </c:choose>
                      </div>
                    </c:otherwise>
                  </c:choose>

                </c:when>
                
                <%-- 2. 답변완료(ANSWERED) 상태일 때 --%>
                <c:otherwise>
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
      const inquiryItem = element.closest('.inquiry-item');
      inquiryItem.classList.toggle('expanded');
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
    
    // 관리자, 중개사에 따라 카테고리 값을 바뀌게 하는 함수
    function onTypeFilterChange() {
        const typeFilter = document.getElementById('typeFilter');
        const categoryFilter = document.getElementById('categoryFilter');
        const selectedType = typeFilter.value; // "ADMIN", "REALTOR", ""
        
        const categoryOptions = categoryFilter.querySelectorAll('option');
        
        // 현재 선택된 카테고리 값이 숨겨지는지 확인하기 위한 변수
        let currentCategoryValue = categoryFilter.value;
        let isCurrentCategoryVisible = false;

        // 1번 인덱스부터 시작 (0번 "전체" 옵션은 건너뜀)
        for (let i = 1; i < categoryOptions.length; i++) {
          const option = categoryOptions[i];
          const optionType = option.dataset.type; // "ADMIN" 또는 "REALTOR"
          
          // '대상'이 "전체"이거나, 옵션 타입이 '대상'의 값과 일치하면 보여줌
          if (selectedType === "" || optionType === selectedType) {
            option.style.display = ""; // 보이기
            if (option.value === currentCategoryValue) {
              isCurrentCategoryVisible = true;
            }
          } else {
            option.style.display = "none"; // 숨기기
          }
        }
        
        // 만약 이전에 선택했던 카테고리가 숨겨졌다면, 카테고리 선택을 "전체"로 리셋
        if (!isCurrentCategoryVisible && currentCategoryValue !== "") {
          categoryFilter.value = "";
        }
        
        // 마지막으로, 리스트 필터링 적용
        applyFilters();
      }
    
    // 필터 적용 함수
	function applyFilters() {
	  const statusFilter = document.getElementById('statusFilter').value;
	  const typeFilter = document.getElementById('typeFilter').value; // [추가]
	  const categoryFilter = document.getElementById('categoryFilter').value;
	  const sortFilter = document.getElementById('sortFilter').value;
	  
	  const inquiryItems = Array.from(document.querySelectorAll('.inquiry-item'));
	  
	  // 필터링
	  inquiryItems.forEach(item => {
	    let showItem = true;
	    
	    if (statusFilter && item.dataset.status !== statusFilter) {
	      showItem = false;
	    }
	    
	    if (typeFilter && item.dataset.type !== typeFilter) { // [추가]
	      showItem = false;
	    }
	    
	    if (categoryFilter && item.dataset.category !== categoryFilter) {
	      showItem = false;
	    }
	    
	    if (showItem) {
	      item.classList.remove('hidden');
	    } else {
	      item.classList.add('hidden');
	    }
	  });
	  
	  // 정렬 (기존과 동일)
	  const visibleItems = inquiryItems.filter(item => !item.classList.contains('hidden'));
	  
	  if (sortFilter === 'latest') {
	    visibleItems.sort((a, b) => parseInt(b.dataset.created) - parseInt(a.dataset.created));
	  } else if (sortFilter === 'oldest') {
	    visibleItems.sort((a, b) => parseInt(a.dataset.created) - parseInt(b.dataset.created));
	  } else if (sortFilter === 'pending') {
	    visibleItems.sort((a, b) => {
	      if (a.dataset.status === 'PENDING' && b.dataset.status !== 'PENDING') return -1;
	      if (a.dataset.status !== 'PENDING' && b.dataset.status === 'PENDING') return 1;
	      return parseInt(b.dataset.created) - parseInt(a.dataset.created);
	    });
	  }
	  
	  const inquiryList = document.getElementById('inquiryList');
	  visibleItems.forEach(item => {
	    inquiryList.appendChild(item);
	  });
	}
  </script>
</body>
</html>