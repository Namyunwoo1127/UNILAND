<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중개사 대시보드 - UNILAND</title>
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
            min-width: 1400px;
            overflow-x: auto;
        }

        /* ---------------------------------------------------- */
        /* 헤더 관련 CSS는 외부 파일(realtor-header.jsp)에 있다고 가정하고 제거되었습니다. */
        /* ---------------------------------------------------- */
        
        /* 메인 레이아웃 */
        .main-layout {
            display: flex;
            max-width: 1400px;
            min-width: 1400px;
            margin: 0 auto;
            min-height: calc(100vh - 80px); /* 헤더 높이에 맞게 조정이 필요할 수 있습니다. */
        }

        /* 사이드바 */
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

        /* 메인 콘텐츠 */
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

        /* 통계 카드 그리드 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-title {
            font-size: 14px;
            color: #718096;
            font-weight: 500;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .stat-icon.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-icon.success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }

        .stat-icon.warning {
            background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%);
            color: white;
        }

        .stat-icon.info {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
        }

        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .stat-change {
            font-size: 13px;
            color: #48bb78;
        }

        .stat-change.negative {
            color: #f56565;
        }

        /* 콘텐츠 섹션 */
        .content-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d3748;
        }

        .view-all {
            color: #667eea;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: color 0.3s;
        }

        .view-all:hover {
            color: #5568d3;
        }

        .property-table {
            width: 100%;
            border-collapse: collapse;
        }

        .property-table thead {
            background: #f7fafc;
        }

        .property-table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #4a5568;
            font-size: 14px;
            border-bottom: 2px solid #e2e8f0;
        }

        .property-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #e2e8f0;
            color: #2d3748;
        }

        .property-table tr:hover {
            background: #f7fafc;
        }

        .property-thumb {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            background: #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .property-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .property-location {
            font-size: 13px;
            color: #718096;
        }

        .property-price {
            font-weight: 600;
            color: #667eea;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-badge.active {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-badge.reserved {
            background: #feebc8;
            color: #7c2d12;
        }

        .status-badge.completed {
            background: #e2e8f0;
            color: #2d3748;
        }

        .table-actions {
            display: flex;
            gap: 10px;
        }

        .btn-table {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
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

        .btn-delete {
            background: #f56565;
            color: white;
        }

        .btn-delete:hover {
            background: #e53e3e;
        }

        .inquiry-list {
            list-style: none;
        }

        .inquiry-item {
            padding: 20px;
            border-bottom: 1px solid #e2e8f0;
            transition: background 0.3s;
            cursor: pointer;
        }

        .inquiry-item:hover {
            background: #f7fafc;
        }

        .inquiry-item:last-child {
            border-bottom: none;
        }

        .inquiry-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 10px;
        }

        .inquiry-user {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .inquiry-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .inquiry-info h4 {
            font-size: 15px;
            color: #2d3748;
            margin-bottom: 3px;
        }

        .inquiry-date {
            font-size: 12px;
            color: #a0aec0;
        }

        .inquiry-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .inquiry-badge.new {
            background: #feebc8;
            color: #7c2d12;
        }

        .inquiry-badge.replied {
            background: #c6f6d5;
            color: #22543d;
        }

        .inquiry-content {
            color: #4a5568;
            font-size: 14px;
            line-height: 1.6;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .action-card {
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid #e2e8f0;
        }

        .action-card:hover {
            transform: translateY(-5px);
            border-color: #667eea;
            box-shadow: 0 4px 16px rgba(102, 126, 234, 0.2);
        }

        .action-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 15px;
            border-radius: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
        }

        .action-title {
            font-size: 18px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .action-desc {
            font-size: 14px;
            color: #718096;
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
                <li><a href="#" class="active"><span class="menu-icon">📊</span>대시보드</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-management"><span class="menu-icon">🏢</span>매물 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-register"><span class="menu-icon">➕</span>매물 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/inquiry-management"><span class="menu-icon">💬</span>받은 문의</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>대시보드</h1>
                <p>중개사 활동 현황을 한눈에 확인하세요</p>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-title">전체 매물</span>
                        <div class="stat-icon primary">🏠</div>
                    </div>
                    <div class="stat-value">24</div>
                    <div class="stat-change">↑ 지난주 대비 +3</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-title">거래 완료</span>
                        <div class="stat-icon success">✅</div>
                    </div>
                    <div class="stat-value">8</div>
                    <div class="stat-change">↑ 이번 달 +2</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-title">새 문의</span>
                        <div class="stat-icon warning">📩</div>
                    </div>
                    <div class="stat-value">12</div>
                    <div class="stat-change">↑ 오늘 +5</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-title">조회수</span>
                        <div class="stat-icon info">👁️</div>
                    </div>
                    <div class="stat-value">1.2K</div>
                    <div class="stat-change">↑ 이번 주 +15%</div>
                </div>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">빠른 액션</h2>
                </div>
                <div class="quick-actions">
                    <div class="action-card" onclick="location.href='${pageContext.request.contextPath}/realtor/property-register'">
                        <div class="action-icon">➕</div>
                        <h3 class="action-title">매물 등록</h3>
                        <p class="action-desc">새로운 매물을 등록하세요</p>
                    </div>
                    <div class="action-card" onclick="location.href='${pageContext.request.contextPath}/realtor/inquiry-management'">
                        <div class="action-icon">💬</div>
                        <h3 class="action-title">문의 답변</h3>
                        <p class="action-desc">대기 중인 문의 12건</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>