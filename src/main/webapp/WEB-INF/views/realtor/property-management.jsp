<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매물 관리 - UNILAND</title>
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

        /* ---------------------------------------------------- */
        /* 헤더 관련 CSS는 외부 파일(realtor-header.jsp)에 있다고 가정하고 제거되었습니다. */
        /* ---------------------------------------------------- */

        .main-layout {
            display: flex;
            max-width: 1400px;
            margin: 0 auto;
            min-height: calc(100vh - 80px); /* 헤더 높이에 맞게 조정이 필요할 수 있습니다. */
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-header-left h1 {
            font-size: 32px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .page-header-left p {
            color: #718096;
            font-size: 16px;
        }

        .btn-register {
            padding: 14px 28px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .content-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
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

        .stats-bar {
            display: flex;
            gap: 30px;
            padding: 20px;
            background: #f7fafc;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .stat-item-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .stat-item-icon.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-item-icon.success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }

        .stat-item-icon.warning {
            background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%);
            color: white;
        }

        .stat-item-icon.gray {
            background: #e2e8f0;
            color: #4a5568;
        }

        .stat-item-info span {
            display: block;
            font-size: 12px;
            color: #718096;
        }

        .stat-item-info strong {
            font-size: 20px;
            color: #2d3748;
        }

        .property-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .property-card {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s;
            cursor: pointer;
        }

        .property-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.2);
        }

        .card-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #e0e7ff 0%, #f3e8ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            position: relative;
        }

        .card-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-active {
            background: #c6f6d5;
            color: #22543d;
        }

        .badge-reserved {
            background: #feebc8;
            color: #7c2d12;
        }

        .badge-completed {
            background: #e2e8f0;
            color: #2d3748;
        }

        .card-stats {
            position: absolute;
            top: 12px;
            right: 12px;
            display: flex;
            gap: 8px;
        }

        .stat-pill {
            background: rgba(255,255,255,0.9);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .card-content {
            padding: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .card-location {
            font-size: 14px;
            color: #718096;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .card-price {
            font-size: 22px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 15px;
        }

        .card-info {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 13px;
            color: #4a5568;
        }

        .card-info span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .card-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }

        .btn-card {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-edit {
            background: #667eea;
            color: white;
        }

        .btn-edit:hover {
            background: #5568d3;
        }

        .btn-status {
            background: #f7fafc;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-status:hover {
            background: #e2e8f0;
        }

        .btn-delete {
            background: #fff5f5;
            color: #f56565;
            border: 2px solid #feb2b2;
        }

        .btn-delete:hover {
            background: #fed7d7;
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
            margin-bottom: 30px;
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
    </style>
</head>
<body>
    <%-- 
        ✅ 외부 파일(realtor-header.jsp)을 포함하여 헤더를 추가합니다. 
        원래 있던 <header> 태그와 관련 CSS는 모두 제거되었습니다. 
    --%>
    <jsp:include page="/WEB-INF/views/common/realtor-header.jsp" />

    <div class="main-layout">
        <aside class="sidebar">
            <div class="sidebar-title">중개사 메뉴</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/realtor/realtor-dashboard"><span class="menu-icon">📊</span>대시보드</a></li>
                <li><a href="#" class="active"><span class="menu-icon">🏢</span>매물 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-register"><span class="menu-icon">➕</span>매물 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/inquiry-management"><span class="menu-icon">💬</span>받은 문의</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <div class="page-header-left">
                    <h1>매물 관리</h1>
                    <p>등록한 매물을 관리하고 수정하세요</p>
                </div>
                <button class="btn-register" onclick="location.href='${pageContext.request.contextPath}/realtor/property-register'">
                    ➕ 매물 등록하기
                </button>
            </div>

            <div class="content-section">
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-item-icon primary">🏠</div>
                        <div class="stat-item-info">
                            <span>전체 매물</span>
                            <strong>24</strong>
                        </div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-item-icon success">✅</div>
                        <div class="stat-item-info">
                            <span>판매중</span>
                            <strong>18</strong>
                        </div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-item-icon warning">⏳</div>
                        <div class="stat-item-info">
                            <span>예약중</span>
                            <strong>3</strong>
                        </div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-item-icon gray">🔒</div>
                        <div class="stat-item-info">
                            <span>거래완료</span>
                            <strong>3</strong>
                        </div>
                    </div>
                </div>

                <div class="filter-section">
                    <div class="filter-group">
                        <span class="filter-label">상태</span>
                        <select class="filter-select">
                            <option>전체</option>
                            <option>판매중</option>
                            <option>예약중</option>
                            <option>거래완료</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <span class="filter-label">매물유형</span>
                        <select class="filter-select">
                            <option>전체</option>
                            <option>원룸</option>
                            <option>투룸</option>
                            <option>쓰리룸</option>
                            <option>오피스텔</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <span class="filter-label">정렬</span>
                        <select class="filter-select">
                            <option>최신순</option>
                            <option>조회수 높은순</option>
                            <option>가격 낮은순</option>
                            <option>가격 높은순</option>
                        </select>
                    </div>
                    <div class="search-box">
                        <input type="text" class="search-input" placeholder="매물명, 주소로 검색...">
                        <span class="search-icon">🔍</span>
                    </div>
                </div>

                <div class="property-grid">
                    <div class="property-card">
                        <div class="card-image">
                            🏠
                            <span class="card-badge badge-active">판매중</span>
                            <div class="card-stats">
                                <span class="stat-pill">👁️ 142</span>
                                <span class="stat-pill">❤️ 23</span>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-title">신촌역 5분거리 풀옵션 원룸</div>
                            <div class="card-location">📍 서대문구 창천동</div>
                            <div class="card-price">500/55</div>
                            <div class="card-info">
                                <span>🏠 원룸</span>
                                <span>📏 20㎡</span>
                                <span>📅 2024.01.15</span>
                            </div>
                            <div class="card-actions">
                                <button class="btn-card btn-edit" onclick="location.href='${pageContext.request.contextPath}/realtor/property-edit'">수정</button>
                                <button class="btn-card btn-status">상태변경</button>
                                <button class="btn-card btn-delete">삭제</button>
                            </div>
                        </div>
                    </div>

                    <div class="property-card">
                        <div class="card-image">
                            🏢
                            <span class="card-badge badge-reserved">예약중</span>
                            <div class="card-stats">
                                <span class="stat-pill">👁️ 89</span>
                                <span class="stat-pill">❤️ 15</span>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-title">혜화역 도보 7분 깨끗한 오피스텔</div>
                            <div class="card-location">📍 종로구 명륜동</div>
                            <div class="card-price">1000/60</div>
                            <div class="card-info">
                                <span>🏢 오피스텔</span>
                                <span>📏 25㎡</span>
                                <span>📅 2024.01.12</span>
                            </div>
                            <div class="card-actions">
                                <button class="btn-card btn-edit">수정</button>
                                <button class="btn-card btn-status">상태변경</button>
                                <button class="btn-card btn-delete">삭제</button>
                            </div>
                        </div>
                    </div>

                    <div class="property-card">
                        <div class="card-image">
                            🏡
                            <span class="card-badge badge-completed">거래완료</span>
                            <div class="card-stats">
                                <span class="stat-pill">👁️ 203</span>
                                <span class="stat-pill">❤️ 34</span>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-title">홍대 캠퍼스 앞 저렴한 원룸</div>
                            <div class="card-location">📍 마포구 서교동</div>
                            <div class="card-price">300/45</div>
                            <div class="card-info">
                                <span>🏠 원룸</span>
                                <span>📏 18㎡</span>
                                <span>📅 2024.01.08</span>
                            </div>
                            <div class="card-actions">
                                <button class="btn-card btn-edit">수정</button>
                                <button class="btn-card btn-status">상태변경</button>
                                <button class="btn-card btn-delete">삭제</button>
                            </div>
                        </div>
                    </div>

                    <div class="property-card">
                        <div class="card-image">
                            🏠
                            <span class="card-badge badge-active">판매중</span>
                            <div class="card-stats">
                                <span class="stat-pill">👁️ 67</span>
                                <span class="stat-pill">❤️ 12</span>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-title">이대역 도보 3분 원룸</div>
                            <div class="card-location">📍 서대문구 대현동</div>
                            <div class="card-price">700/55</div>
                            <div class="card-info">
                                <span>🏠 원룸</span>
                                <span>📏 22㎡</span>
                                <span>📅 2024.01.10</span>
                            </div>
                            <div class="card-actions">
                                <button class="btn-card btn-edit">수정</button>
                                <button class="btn-card btn-status">상태변경</button>
                                <button class="btn-card btn-delete">삭제</button>
                            </div>
                        </div>
                    </div>

                    <div class="property-card">
                        <div class="card-image">
                            🏢
                            <span class="card-badge badge-active">판매중</span>
                            <div class="card-stats">
                                <span class="stat-pill">👁️ 124</span>
                                <span class="stat-pill">❤️ 28</span>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-title">건대입구역 초역세권 원룸</div>
                            <div class="card-location">📍 광진구 화양동</div>
                            <div class="card-price">500/50</div>
                            <div class="card-info">
                                <span>🏠 원룸</span>
                                <span>📏 19㎡</span>
                                <span>📅 2024.01.09</span>
                            </div>
                            <div class="card-actions">
                                <button class="btn-card btn-edit">수정</button>
                                <button class="btn-card btn-status">상태변경</button>
                                <button class="btn-card btn-delete">삭제</button>
                            </div>
                        </div>
                    </div>

                    <div class="property-card">
                        <div class="card-image">
                            🏡
                            <span class="card-badge badge-active">판매중</span>
                            <div class="card-stats">
                                <span class="stat-pill">👁️ 95</span>
                                <span class="stat-pill">❤️ 18</span>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="card-title">성신여대 도보 5분 투룸</div>
                            <div class="card-location">📍 성북구 동선동</div>
                            <div class="card-price">500/65</div>
                            <div class="card-info">
                                <span>🏡 투룸</span>
                                <span>📏 30㎡</span>
                                <span>📅 2024.01.07</span>
                            </div>
                            <div class="card-actions">
                                <button class="btn-card btn-edit">수정</button>
                                <button class="btn-card btn-status">상태변경</button>
                                <button class="btn-card btn-delete">삭제</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="pagination">
                    <button disabled>← 이전</button>
                    <button class="active">1</button>
                    <button>2</button>
                    <button>3</button>
                    <button>4</button>
                    <button>다음 →</button>
                </div>
            </div>
        </main>
    </div>
</body>
</html>