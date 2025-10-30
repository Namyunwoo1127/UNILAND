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
            min-height: calc(100vh - 80px);
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
            grid-template-columns: repeat(3, 1fr);
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
                    <div class="stat-value" id="totalProperties">${allCount }</div>
                    <div class="stat-change" id="propertyChange">계산 중...</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-title">거래 완료</span>
                        <div class="stat-icon success">✅</div>
                    </div>
                    <div class="stat-value" id="completedDeals">${completedCount }</div>
                    <div class="stat-change" id="dealChange">계산 중...</div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-title">새 문의</span>
                        <div class="stat-icon warning">📩</div>
                    </div>
                    <div class="stat-value" id="newInquiries">${stats.pendingCount}</div>
                    <div class="stat-change" id="inquiryChange">계산 중...</div>
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
                        <p class="action-desc" id="inquiryActionDesc">대기 중인 문의 확인</p>
                    </div>
                </div>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">최근 등록 매물</h2>
                    <span class="view-all" onclick="location.href='${pageContext.request.contextPath}/realtor/property-management'">전체보기 →</span>
                </div>
                <table class="property-table">
                    <thead>
                        <tr>
                            <th>매물정보</th>
                            <th>거래유형</th>
                            <th>가격</th>
                            <th>상태</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody id="recentPropertiesBody">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px; color: #a0aec0;">
                                등록된 매물이 없습니다
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">최근 문의</h2>
                    <span class="view-all" onclick="location.href='${pageContext.request.contextPath}/realtor/inquiry-management'">전체보기 →</span>
                </div>
                <ul class="inquiry-list" id="recentInquiriesList">
                    <li style="text-align: center; padding: 40px; color: #a0aec0;">
                        받은 문의가 없습니다
                    </li>
                </ul>
            </div>
        </main>
    </div>

    <script>
        // 대시보드 데이터 로드
        document.addEventListener('DOMContentLoaded', function() {
            loadDashboardStats();
            loadRecentProperties();
            loadRecentInquiries();
        });

        // 통계 데이터 로드
        function loadDashboardStats() {
            // 실제로는 서버에서 데이터를 가져와야 합니다
            // 여기서는 샘플 데이터로 시뮬레이션합니다
            fetch('${pageContext.request.contextPath}/api/realtor/dashboard/stats')
                .then(response => response.json())
                .then(data => {
                    updateStatCard('totalProperties', data.totalProperties, data.propertyChange);
                    updateStatCard('completedDeals', data.completedDeals, data.dealChange);
                    updateStatCard('newInquiries', data.newInquiries, data.inquiryChange);
                    
                    // 문의 카운트 업데이트
                    document.getElementById('inquiryActionDesc').textContent = 
                        `대기 중인 문의 ${data.newInquiries}건`;
                })
                .catch(error => {
                    console.error('통계 데이터 로드 실패:', error);
                    // 에러 시 기본값 표시
                    setDefaultStats();
                });
        }

        // 통계 카드 업데이트
        function updateStatCard(id, value, change) {
            document.getElementById(id).textContent = value;
            const changeElement = document.getElementById(id.replace(/[A-Z]/g, m => '-' + m.toLowerCase()) + '-change');
            if (changeElement) {
                changeElement.textContent = change;
                if (change.includes('-')) {
                    changeElement.classList.add('negative');
                }
            }
        }

        // 기본 통계값 설정
        function setDefaultStats() {
            document.getElementById('totalProperties').textContent = '24';
            document.getElementById('propertyChange').textContent = '↑ 지난주 대비 +3';
            document.getElementById('completedDeals').textContent = '8';
            document.getElementById('dealChange').textContent = '↑ 이번 달 +2';
            document.getElementById('newInquiries').textContent = '12';
            document.getElementById('inquiryChange').textContent = '↑ 오늘 +5';
            document.getElementById('inquiryActionDesc').textContent = '대기 중인 문의 12건';
        }

        // 최근 매물 로드
        function loadRecentProperties() {
            fetch('${pageContext.request.contextPath}/api/realtor/properties/recent?limit=5')
                .then(response => response.json())
                .then(data => {
                    const tbody = document.getElementById('recentPropertiesBody');
                    if (data && data.length > 0) {
                        tbody.innerHTML = data.map(property => `
                            <tr onclick="location.href='${pageContext.request.contextPath}/realtor/property-detail/${property.id}'">
                                <td>
                                    <div class="property-title">${property.title}</div>
                                    <div class="property-location">${property.location}</div>
                                </td>
                                <td>${property.dealType}</td>
                                <td class="property-price">${formatPrice(property.price)}</td>
                                <td><span class="status-badge ${property.status}">${getStatusText(property.status)}</span></td>
                                <td>${formatDate(property.createdAt)}</td>
                            </tr>
                        `).join('');
                    }
                })
                .catch(error => {
                    console.error('최근 매물 로드 실패:', error);
                });
        }

        // 최근 문의 로드
        function loadRecentInquiries() {
            fetch('${pageContext.request.contextPath}/api/realtor/inquiries/recent?limit=5')
                .then(response => response.json())
                .then(data => {
                    const list = document.getElementById('recentInquiriesList');
                    if (data && data.length > 0) {
                        list.innerHTML = data.map(inquiry => `
                            <li class="inquiry-item" onclick="location.href='${pageContext.request.contextPath}/realtor/inquiry-detail/${inquiry.id}'">
                                <div class="inquiry-header">
                                    <div class="inquiry-user">
                                        <div class="inquiry-avatar">${inquiry.userName.charAt(0)}</div>
                                        <div class="inquiry-info">
                                            <h4>${inquiry.userName}</h4>
                                            <span class="inquiry-date">${formatDate(inquiry.createdAt)}</span>
                                        </div>
                                    </div>
                                    <span class="inquiry-badge ${inquiry.status}">' + (inquiry.status === 'new' ? '새 문의' : '답변완료') + '</span>
                                </div>
                                <p class="inquiry-content">${inquiry.content}</p>
                            </li>
                        `).join('');
                    }
                })
                .catch(error => {
                    console.error('최근 문의 로드 실패:', error);
                });
        }

        // 유틸리티 함수들
        function formatPrice(price) {
            if (price >= 100000000) {
                return (price / 100000000).toFixed(1) + '억';
            } else if (price >= 10000) {
                return (price / 10000).toFixed(0) + '만';
            }
            return price.toLocaleString() + '원';
        }

        function formatDate(dateString) {
            const date = new Date(dateString);
            const now = new Date();
            const diff = now - date;
            const days = Math.floor(diff / (1000 * 60 * 60 * 24));
            
            if (days === 0) return '오늘';
            if (days === 1) return '어제';
            if (days < 7) return days + '일 전';
            
            return date.toLocaleDateString('ko-KR', { month: 'short', day: 'numeric' });
        }

        function getStatusText(status) {
            const statusMap = {
                'active': '판매중',
                'reserved': '예약중',
                'completed': '거래완료'
            };
            return statusMap[status] || status;
        }

        // 페이지 로드 시 기본 통계 표시 (API 응답 전까지)
        setDefaultStats();
        
        document.addEventListener("DOMContentLoaded", () => {
            fetch("/realtor/api/dashboard")
                .then(response => response.json())
                .then(data => {
                    if (!data.success) {
                        alert(data.message);
                        return;
                    }

                    // 1. 매물 통계 표시
                    document.getElementById("totalProperties").textContent = data.totalProperties;
                    document.getElementById("activeProperties").textContent = data.activeProperties;
                    document.getElementById("completedDeals").textContent = data.completedDeals;
                    document.getElementById("reservedProperties").textContent = data.reservedProperties;

                    // 2. 최근 매물 표시
                    const recentPropContainer = document.getElementById("recentProperties");
                    recentPropContainer.innerHTML = "";
                    data.recentProperties.forEach(prop => {
                        const li = document.createElement("li");
                        li.textContent = `${prop.propertyName} (${prop.status}) - ${prop.deposit}/${prop.monthlyRent}`;
                        recentPropContainer.appendChild(li);
                    });

                    // 3. 최근 문의 표시
                    const recentInquiryContainer = document.getElementById("recentInquiries");
                    recentInquiryContainer.innerHTML = "";
                    data.recentInquiries.forEach(inq => {
                        const li = document.createElement("li");
                        li.textContent = `${inq.userName}: ${inq.title} [${inq.status}]`;
                        recentInquiryContainer.appendChild(li);
                    });

                })
                .catch(err => console.error("대시보드 데이터 로드 실패:", err));
        });
    </script>
</body>
</html>