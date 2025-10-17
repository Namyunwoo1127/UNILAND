<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>받은 문의 관리 - UNILAND</title>
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

        header {
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-name {
            font-weight: 600;
            color: #2d3748;
        }

        .btn-logout {
            padding: 8px 20px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-logout:hover {
            background: #f7fafc;
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
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 40px;
        }

        .pagination button {
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            background: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .pagination button:hover {
            border-color: #667eea;
            color: #667eea;
        }

        .pagination button.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .pagination button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
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
    </style>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="logo">
                <div class="logo-icon">🏠</div>
                <span>UNILAND</span>
            </div>
            <div class="user-info">
                <span class="user-name">김부동산 중개사님</span>
                <button class="btn-logout">로그아웃</button>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <aside class="sidebar">
            <div class="sidebar-title">중개사 메뉴</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/realtor/realtor-dashboard"><span class="menu-icon">📊</span>대시보드</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-management"><span class="menu-icon">🏢</span>매물 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-register"><span class="menu-icon">➕</span>매물 등록</a></li>
                <li><a href="#" class="active"><span class="menu-icon">💬</span>받은 문의</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>받은 문의 관리</h1>
                <p>고객 문의에 빠르게 답변하세요</p>
            </div>

            <div class="content-section">
                <!-- 통계 바 -->
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-number">12</div>
                        <div class="stat-label">전체 문의</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" style="color: #ed8936;">5</div>
                        <div class="stat-label">미답변</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" style="color: #48bb78;">7</div>
                        <div class="stat-label">답변완료</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" style="color: #4299e1;">3</div>
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
                            <option>방문 문의</option>
                            <option>가격 문의</option>
                            <option>계약 문의</option>
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
                    <div class="search-box">
                        <input type="text" class="search-input" placeholder="문의자, 매물명으로 검색...">
                        <span class="search-icon">🔍</span>
                    </div>
                </div>

                <!-- 문의 리스트 -->
                <ul class="inquiry-list">
                    <!-- 새 문의 1 -->
                    <li class="inquiry-item new" onclick="toggleInquiry(this)">
                        <div class="inquiry-header">
                            <div class="inquiry-left">
                                <div class="inquiry-user-info">
                                    <div class="inquiry-avatar">김</div>
                                    <div class="inquiry-user-detail">
                                        <h3>김대학 님</h3>
                                        <div class="inquiry-meta">
                                            <span>📧 kim@email.com</span>
                                            <span>📞 010-1234-5678</span>
                                            <span>🕐 2024.01.16 14:30</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="inquiry-property">🏠 신촌역 5분거리 풀옵션 원룸</div>
                                <div>
                                    <span class="inquiry-type type-visit">방문 문의</span>
                                    <span class="inquiry-content">이번 주 주말에 방문 가능할까요? 학교에서 가까운 곳을 찾고 있습니다. 3월 초 입주 희망합니다.</span>
                                </div>
                            </div>
                            <div class="inquiry-right">
                                <span class="inquiry-badge badge-new">새 문의</span>
                                <button class="btn-reply" onclick="event.stopPropagation(); showReplyForm(this)">답변하기</button>
                            </div>
                        </div>
                        <div class="inquiry-body">
                            <div class="inquiry-divider"></div>
                            <div class="reply-section">
                                <div class="reply-title">💬 답변 작성</div>
                                <textarea class="reply-textarea" placeholder="고객님께 답변을 작성하세요..."></textarea>
                                <div class="reply-actions">
                                    <button class="btn-cancel" onclick="event.stopPropagation(); hideReplyForm(this)">취소</button>
                                    <button class="btn-submit" onclick="event.stopPropagation(); submitReply(this)">답변 전송</button>
                                </div>
                            </div>
                        </div>
                    </li>

                    <!-- 새 문의 2 -->
                    <li class="inquiry-item new">
                        <div class="inquiry-header" onclick="toggleInquiry(this.parentElement)">
                            <div class="inquiry-left">
                                <div class="inquiry-user-info">
                                    <div class="inquiry-avatar">박</div>
                                    <div class="inquiry-user-detail">
                                        <h3>박연세 님</h3>
                                        <div class="inquiry-meta">
                                            <span>📧 park@email.com</span>
                                            <span>📞 010-2345-6789</span>
                                            <span>🕐 2024.01.16 11:20</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="inquiry-property">🏠 신촌역 5분거리 풀옵션 원룸</div>
                                <div>
                                    <span class="inquiry-type type-price">가격 문의</span>
                                    <span class="inquiry-content">가격 협상 가능할까요? 보증금을 조금 더 올리고 월세를 낮출 수 있는지 궁금합니다.</span>
                                </div>
                            </div>
                            <div class="inquiry-right">
                                <span class="inquiry-badge badge-new">새 문의</span>
                                <button class="btn-reply" onclick="event.stopPropagation(); showReplyForm(this)">답변하기</button>
                            </div>
                        </div>
                        <div class="inquiry-body">
                            <div class="inquiry-divider"></div>
                            <div class="reply-section">
                                <div class="reply-title">💬 답변 작성</div>
                                <textarea class="reply-textarea" placeholder="고객님께 답변을 작성하세요..."></textarea>
                                <div class="reply-actions">
                                    <button class="btn-cancel" onclick="event.stopPropagation(); hideReplyForm(this)">취소</button>
                                    <button class="btn-submit" onclick="event.stopPropagation(); submitReply(this)">답변 전송</button>
                                </div>
                            </div>
                        </div>
                    </li>

                    <!-- 답변 완료 문의 -->
                    <li class="inquiry-item">
                        <div class="inquiry-header" onclick="toggleInquiry(this.parentElement)">
                            <div class="inquiry-left">
                                <div class="inquiry-user-info">
                                    <div class="inquiry-avatar">이</div>
                                    <div class="inquiry-user-detail">
                                        <h3>이학생 님</h3>
                                        <div class="inquiry-meta">
                                            <span>📧 lee@email.com</span>
                                            <span>📞 010-3456-7890</span>
                                            <span>🕐 2024.01.15 18:45</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="inquiry-property">🏢 혜화역 도보 7분 깨끗한 오피스텔</div>
                                <div>
                                    <span class="inquiry-type type-contract">계약 문의</span>
                                    <span class="inquiry-content">주차 가능한가요? 그리고 관리비에 포함되는 항목이 궁금합니다.</span>
                                </div>
                            </div>
                            <div class="inquiry-right">
                                <span class="inquiry-badge badge-replied">답변완료</span>
                            </div>
                        </div>
                        <div class="inquiry-body">
                            <div class="inquiry-divider"></div>
                            <div class="replied-content">
                                <div class="replied-header">
                                    <span class="replied-title">✅ 답변 완료</span>
                                    <span class="replied-date">2024.01.15 19:20</span>
                                </div>
                                <div class="replied-text">
                                    안녕하세요, 이학생님. 문의 주셔서 감사합니다.<br><br>
                                    네, 주차 가능합니다. 지하 주차장에 1대 주차 가능하며, 추가 비용은 없습니다.<br><br>
                                    관리비는 월 5만원이며, 수도/전기/인터넷이 포함되어 있습니다. 가스비와 난방비는 별도로 개별 정산됩니다.<br><br>
                                    방문 상담 원하시면 편하신 시간 알려주세요. 감사합니다.
                                </div>
                            </div>
                        </div>
                    </li>

                    <!-- 새 문의 3 -->
                    <li class="inquiry-item new">
                        <div class="inquiry-header" onclick="toggleInquiry(this.parentElement)">
                            <div class="inquiry-left">
                                <div class="inquiry-user-info">
                                    <div class="inquiry-avatar">최</div>
                                    <div class="inquiry-user-detail">
                                        <h3>최학생 님</h3>
                                        <div class="inquiry-meta">
                                            <span>📧 choi@email.com</span>
                                            <span>📞 010-4567-8901</span>
                                            <span>🕐 2024.01.15 16:30</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="inquiry-property">🏡 홍대 캠퍼스 앞 저렴한 원룸</div>
                                <div>
                                    <span class="inquiry-type type-etc">기타</span>
                                    <span class="inquiry-content">반려동물 키울 수 있나요? 소형견 1마리입니다.</span>
                                </div>
                            </div>
                            <div class="inquiry-right">
                                <span class="inquiry-badge badge-new">새 문의</span>
                                <button class="btn-reply" onclick="event.stopPropagation(); showReplyForm(this)">답변하기</button>
                            </div>
                        </div>
                        <div class="inquiry-body">
                            <div class="inquiry-divider"></div>
                            <div class="reply-section">
                                <div class="reply-title">💬 답변 작성</div>
                                <textarea class="reply-textarea" placeholder="고객님께 답변을 작성하세요..."></textarea>
                                <div class="reply-actions">
                                    <button class="btn-cancel" onclick="event.stopPropagation(); hideReplyForm(this)">취소</button>
                                    <button class="btn-submit" onclick="event.stopPropagation(); submitReply(this)">답변 전송</button>
                                </div>
                            </div>
                        </div>
                    </li>

                    <!-- 답변 완료 문의 2 -->
                    <li class="inquiry-item">
                        <div class="inquiry-header" onclick="toggleInquiry(this.parentElement)">
                            <div class="inquiry-left">
                                <div class="inquiry-user-info">
                                    <div class="inquiry-avatar">정</div>
                                    <div class="inquiry-user-detail">
                                        <h3>정대학 님</h3>
                                        <div class="inquiry-meta">
                                            <span>📧 jung@email.com</span>
                                            <span>📞 010-5678-9012</span>
                                            <span>🕐 2024.01.14 10:15</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="inquiry-property">🏠 이대역 도보 3분 원룸</div>
                                <div>
                                    <span class="inquiry-type type-visit">방문 문의</span>
                                    <span class="inquiry-content">내일 오후 2시에 방문 가능할까요?</span>
                                </div>
                            </div>
                            <div class="inquiry-right">
                                <span class="inquiry-badge badge-replied">답변완료</span>
                            </div>
                        </div>
                        <div class="inquiry-body">
                            <div class="inquiry-divider"></div>
                            <div class="replied-content">
                                <div class="replied-header">
                                    <span class="replied-title">✅ 답변 완료</span>
                                    <span class="replied-date">2024.01.14 11:30</span>
                                </div>
                                <div class="replied-text">
                                    안녕하세요, 정대학님.<br><br>
                                    네, 내일(15일) 오후 2시 방문 가능합니다. 이대역 2번 출구에서 도보 3분 거리입니다.<br><br>
                                    주소: 서울 서대문구 대현동 123-45<br>
                                    연락처: 010-1234-5678<br><br>
                                    방문 30분 전에 연락 주시면 감사하겠습니다. 뵙겠습니다!
                                </div>
                            </div>
                        </div>
                    </li>

                    <!-- 새 문의 4 -->
                    <li class="inquiry-item new">
                        <div class="inquiry-header" onclick="toggleInquiry(this.parentElement)">
                            <div class="inquiry-left">
                                <div class="inquiry-user-info">
                                    <div class="inquiry-avatar">강</div>
                                    <div class="inquiry-user-detail">
                                        <h3>강학생 님</h3>
                                        <div class="inquiry-meta">
                                            <span>📧 kang@email.com</span>
                                            <span>📞 010-6789-0123</span>
                                            <span>🕐 2024.01.14 09:00</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="inquiry-property">🏡 성신여대 도보 5분 투룸</div>
                                <div>
                                    <span class="inquiry-type type-contract">계약 문의</span>
                                    <span class="inquiry-content">단기 계약(6개월) 가능한가요? 교환학생 기간 동안만 살고 싶습니다.</span>
                                </div>
                            </div>
                            <div class="inquiry-right">
                                <span class="inquiry-badge badge-new">새 문의</span>
                                <button class="btn-reply" onclick="event.stopPropagation(); showReplyForm(this)">답변하기</button>
                            </div>
                        </div>
                        <div class="inquiry-body">
                            <div class="inquiry-divider"></div>
                            <div class="reply-section">
                                <div class="reply-title">💬 답변 작성</div>
                                <textarea class="reply-textarea" placeholder="고객님께 답변을 작성하세요..."></textarea>
                                <div class="reply-actions">
                                    <button class="btn-cancel" onclick="event.stopPropagation(); hideReplyForm(this)">취소</button>
                                    <button class="btn-submit" onclick="event.stopPropagation(); submitReply(this)">답변 전송</button>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button disabled>← 이전</button>
                    <button class="active">1</button>
                    <button>2</button>
                    <button>3</button>
                    <button>다음 →</button>
                </div>
            </div>
        </main>
    </div>

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

        function submitReply(button) {
            const inquiryItem = button.closest('.inquiry-item');
            const textarea = inquiryItem.querySelector('.reply-textarea');
            
            if (textarea.value.trim() === '') {
                alert('답변 내용을 입력해주세요.');
                return;
            }

            if (confirm('답변을 전송하시겠습니까?')) {
                // 답변 전송 로직
                alert('답변이 전송되었습니다.');
                
                // UI 업데이트
                inquiryItem.classList.remove('new');
                const badge = inquiryItem.querySelector('.inquiry-badge');
                badge.textContent = '답변완료';
                badge.className = 'inquiry-badge badge-replied';
                
                const replyButton = inquiryItem.querySelector('.btn-reply');
                if (replyButton) {
                    replyButton.remove();
                }
                
                // 답변 내용을 표시된 답변으로 변경
                const replySection = inquiryItem.querySelector('.reply-section');
                const replyText = textarea.value;
                const today = new Date().toLocaleDateString('ko-KR');
                
                replySection.innerHTML = `
                    <div class="replied-content">
                        <div class="replied-header">
                            <span class="replied-title">✅ 답변 완료</span>
                            <span class="replied-date">\${today}</span>
                        </div>
                        <div class="replied-text">\${replyText.replace(/\\n/g, '<br>')}</div>
                    </div>
                `;
                
                inquiryItem.classList.remove('expanded');
            }
        }
    </script>
</body>
</html>