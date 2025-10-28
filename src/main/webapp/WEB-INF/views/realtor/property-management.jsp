<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매물 관리 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #333; background-color: #f8f9fa; }

        .main-layout { display: flex; max-width: 1400px; margin: 0 auto; min-height: calc(100vh - 80px); }
        .sidebar { width: 260px; background: white; padding: 30px 0; box-shadow: 2px 0 8px rgba(0,0,0,0.05); }
        .sidebar-title { padding: 0 25px 20px; font-size: 18px; font-weight: bold; color: #2d3748; border-bottom: 2px solid #e2e8f0; }
        .sidebar-menu { list-style: none; padding: 20px 0; }
        .sidebar-menu li { margin: 5px 0; }
        .sidebar-menu a { display: flex; align-items: center; gap: 12px; padding: 14px 25px; color: #4a5568; text-decoration: none; transition: all 0.3s; font-weight: 500; }
        .sidebar-menu a:hover { background: #f7fafc; color: #667eea; }
        .sidebar-menu a.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-right: 4px solid #667eea; }
        .menu-icon { font-size: 20px; width: 24px; text-align: center; }

        .main-content { flex: 1; padding: 40px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .page-header-left h1 { font-size: 32px; color: #2d3748; margin-bottom: 10px; }
        .page-header-left p { color: #718096; font-size: 16px; }
        .btn-register { padding: 14px 28px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: all 0.3s; display: flex; align-items: center; gap: 8px; }
        .btn-register:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4); }

        .content-section { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }

        .filter-section { display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap; align-items: center; }
        .filter-group { display: flex; align-items: center; gap: 10px; }
        .filter-label { font-size: 14px; font-weight: 600; color: #4a5568; }
        .filter-select { padding: 10px 15px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; cursor: pointer; background: white; transition: border-color 0.3s; }
        .filter-select:focus { outline: none; border-color: #667eea; }

        .search-box { flex: 1; position: relative; max-width: 400px; }
        .search-input { width: 100%; padding: 10px 40px 10px 15px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; transition: border-color 0.3s; }
        .search-input:focus { outline: none; border-color: #667eea; }
        .search-icon { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: #a0aec0; }

        .stats-bar { display: flex; gap: 30px; padding: 20px; background: #f7fafc; border-radius: 8px; margin-bottom: 30px; }
        .stat-item { display: flex; align-items: center; gap: 10px; }
        .stat-item-icon { width: 40px; height: 40px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .stat-item-icon.primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .stat-item-icon.success { background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); color: white; }
        .stat-item-icon.warning { background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%); color: white; }
        .stat-item-icon.gray { background: #e2e8f0; color: #4a5568; }
        .stat-item-info span { display: block; font-size: 12px; color: #718096; }
        .stat-item-info strong { font-size: 20px; color: #2d3748; }

        .property-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; }
        .property-grid:has(.empty-state) { display: block; }

        .property-card { background: white; border: 2px solid #e2e8f0; border-radius: 12px; overflow: hidden; transition: all 0.3s; cursor: pointer; }
        .property-card:hover { border-color: #667eea; transform: translateY(-5px); box-shadow: 0 8px 24px rgba(102, 126, 234, 0.2); }

        .card-image { width: 100%; height: 200px; position: relative; padding: 0; overflow: hidden; } 
        .card-image img { width: 100%; height: 100%; object-fit: cover; }
        .card-image .fallback-icon { width: 100%; height: 100%; background: linear-gradient(135deg, #e0e7ff 0%, #f3e8ff 100%); display: flex; align-items: center; justify-content: center; font-size: 60px; color: #667eea; }

        .card-badge { position: absolute; top: 12px; left: 12px; padding: 6px 12px; border-radius: 6px; font-size: 12px; font-weight: 600; z-index: 10;}
        .badge-active { background: #c6f6d5; color: #22543d; }
        .badge-reserved { background: #feebc8; color: #7c2d12; }
        .badge-completed { background: #e2e8f0; color: #2d3748; }
        .badge-gray { background: #f7fafc; color: #4a5568; }

        .card-stats { position: absolute; top: 12px; right: 12px; display: flex; gap: 8px; z-index: 10; }
        .stat-pill { background: rgba(255,255,255,0.9); padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: 600; display: flex; align-items: center; gap: 4px; }

        .card-content { padding: 20px; }
        .card-title { font-size: 18px; font-weight: 600; color: #2d3748; margin-bottom: 8px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .card-location { font-size: 14px; color: #718096; margin-bottom: 12px; display: flex; align-items: center; gap: 5px; }
        .card-price { font-size: 22px; font-weight: bold; color: #667eea; margin-bottom: 15px; }
        
        /* card-info 가운데 정렬 CSS */
        .card-info { 
            display: flex; 
            gap: 15px; 
            margin-bottom: 15px; 
            font-size: 13px; 
            color: #4a5568; 
            justify-content: center; /* 핵심: 가운데 정렬 */
        }
        .card-info span { display: flex; align-items: center; gap: 5px; }

        .card-actions { display: flex; gap: 10px; padding-top: 15px; border-top: 1px solid #e2e8f0; }
        .btn-card { flex: 1; padding: 10px; border: none; border-radius: 6px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.3s; }
        .btn-edit { background: #667eea; color: white; }
        .btn-edit:hover { background: #5568d3; }
        .btn-status { background: #f7fafc; color: #4a5568; border: 2px solid #e2e8f0; }
        .btn-status:hover { background: #e2e8f0; }
        .btn-delete { background: #fff5f5; color: #f56565; border: 2px solid #feb2b2; }
        .btn-delete:hover { background: #fed7d7; }

        .empty-state { text-align: center; padding: 80px 20px; }
        .empty-icon { font-size: 80px; margin-bottom: 20px; }
        .empty-state h3 { font-size: 24px; color: #2d3748; margin-bottom: 10px; }
        .empty-state p { color: #718096; margin-bottom: 30px; }

        .pagination { display: flex; justify-content: center; align-items: center; gap: 10px; margin-top: 40px; }
        .pagination button { padding: 10px 15px; border: 2px solid #e2e8f0; background: white; border-radius: 6px; cursor: pointer; font-weight: 600; transition: all 0.3s; }
        .pagination button:hover { border-color: #667eea; color: #667eea; }
        .pagination button.active { background: #667eea; color: white; border-color: #667eea; }
        .pagination button:disabled { opacity: 0.5; cursor: not-allowed; }

        /* MODAL 스타일 */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            display: none; /* 초기 숨김 */
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }
        .modal-content h3 {
            font-size: 20px;
            color: #2d3748;
            margin-bottom: 15px;
        }
        .status-button-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 20px;
        }
        .status-button-group button {
            padding: 12px;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-modal-active { background: #48bb78; color: white; }
        .btn-modal-reserved { background: #ed8936; color: white; }
        .btn-modal-completed { background: #a0aec0; color: white; }
        
        .btn-modal-cancel { 
            background: #f7fafc; 
            color: #4a5568; 
            margin-top: 10px; 
            border: none;
            transition: background 0.2s, color 0.2s;
        }
        .btn-modal-cancel:hover {
            background: #e2e8f0;
            color: #2d3748;
        }

        .btn-modal-active:hover { background: #38a169; }
        .btn-modal-reserved:hover { background: #dd6b20; }
        .btn-modal-completed:hover { background: #718096; }
    </style>
</head>
<body>
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
                        <strong>${allCount != null ? allCount : 0}</strong>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-item-icon success">✅</div>
                    <div class="stat-item-info">
                        <span>판매중</span>
                        <strong>${activeCount != null ? activeCount : 0}</strong>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-item-icon warning">⏳</div>
                    <div class="stat-item-info">
                        <span>예약중</span>
                        <strong>${reservedCount != null ? reservedCount : 0}</strong>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-item-icon gray">🔒</div>
                    <div class="stat-item-info">
                        <span>거래완료</span>
                        <strong>${completedCount != null ? completedCount : 0}</strong>
                    </div>
                </div>
            </div>

            <form id="filterForm" action="${pageContext.request.contextPath}/realtor/property-management" method="GET">
                <div class="filter-section">
                    <div class="filter-group">
                        <span class="filter-label">상태</span>
                        <select class="filter-select" name="STATUS" onchange="submitFilter()">
                            <option value="ALL" ${param.STATUS == 'ALL' || param.STATUS == null ? 'selected' : ''}>전체</option>
                            <option value="ACTIVE" ${param.STATUS == 'ACTIVE' ? 'selected' : ''}>판매중</option>
                            <option value="RESERVED" ${param.STATUS == 'RESERVED' ? 'selected' : ''}>예약중</option>
                            <option value="COMPLETED" ${param.STATUS == 'COMPLETED' ? 'selected' : ''}>거래완료</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <span class="filter-label">매물유형</span>
                        <select class="filter-select" name="PROPERTY_TYPE" onchange="submitFilter()">
                            <option value="ALL" ${param.PROPERTY_TYPE == 'ALL' || param.PROPERTY_TYPE == null ? 'selected' : ''}>전체</option>
                            <option value="ONEROOM" ${param.PROPERTY_TYPE == 'ONEROOM' ? 'selected' : ''}>원룸</option>
                            <option value="TWOROOM" ${param.PROPERTY_TYPE == 'TWOROOM' ? 'selected' : ''}>투룸</option>
                            <option value="THREEROOM" ${param.PROPERTY_TYPE == 'THREEROOM' ? 'selected' : ''}>쓰리룸</option>
                            <option value="OFFICETEL" ${param.PROPERTY_TYPE == 'OFFICETEL' ? 'selected' : ''}>오피스텔</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <span class="filter-label">정렬</span>
                        <select class="filter-select" name="sort" onchange="submitFilter()">
                            <option value="NEWEST" ${param.sort == 'NEWEST' || param.sort == null ? 'selected' : ''}>최신순</option>
                            <option value="PRICE_ASC" ${param.sort == 'PRICE_ASC' ? 'selected' : ''}>가격 낮은순</option>
                            <option value="PRICE_DESC" ${param.sort == 'PRICE_DESC' ? 'selected' : ''}>가격 높은순</option>
                        </select>
                    </div>
                    <div class="search-box">
                        <input type="text" class="search-input" name="searchKeyword" placeholder="매물명, 주소로 검색..." value="${param.searchKeyword != null ? param.searchKeyword : ''}"
                               onkeyup="if(window.event.keyCode==13) submitFilter()">
                        <span class="search-icon" onclick="submitFilter()">🔍</span>
                    </div>
                </div>
            </form>

            <div class="property-grid">
                <c:choose>
                    <c:when test="${empty propertyList}">
                        <div class="empty-state" style="grid-column: 1 / -1;">
                            <span class="empty-icon">😥</span>
                            <h3>등록된 매물이 없습니다</h3>
                            <p>페이지 상단의 **매물 등록하기** 버튼을 이용해 새로운 매물을 등록해 보세요.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="property" items="${propertyList}">
                            <%-- 매물 유형 한글 변환 로직 (출력용) --%>
                            <c:set var="propertyTypeKorean">
                                <c:choose>
                                    <c:when test="${property.propertyType eq 'ONEROOM' || property.propertyType eq 'oneRoom'}">원룸</c:when>
                                    <c:when test="${property.propertyType eq 'TWOROOM' || property.propertyType eq 'twoRoom'}">투룸</c:when>
                                    <c:when test="${property.propertyType eq 'THREEROOM' || property.propertyType eq 'threeRoom'}">쓰리룸</c:when>
                                    <c:when test="${property.propertyType eq 'OFFICETEL' || property.propertyType eq 'officetel'}">오피스텔</c:when>
                                    <c:otherwise>${property.propertyType}</c:otherwise>
                                </c:choose>
                            </c:set>

                            <%-- 면적을 평으로 변환 --%>
                            <c:set var="areaPyung" value="${property.contractArea * 0.3025}"/>

                            <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/realtor/property-detail?id=${property.propertyNo}'">
                                
                                <div class="card-image">
                                    <c:choose>
                                        <c:when test="${not empty property.thumbnailPath}">
                                            <img src="${pageContext.request.contextPath}${property.thumbnailPath}" 
                                                 alt="${property.propertyName} 썸네일" 
                                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop'">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="fallback-icon">🏠</div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:choose>
                                        <c:when test="${property.status eq 'ACTIVE'}"><span class="card-badge badge-active">판매중</span></c:when>
                                        <c:when test="${property.status eq 'RESERVED'}"><span class="card-badge badge-reserved">예약중</span></c:when>
                                        <c:when test="${property.status eq 'COMPLETED'}"><span class="card-badge badge-completed">거래완료</span></c:when>
                                        <c:otherwise><span class="card-badge badge-gray">${property.status}</span></c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="card-content">
                                    <div class="card-title">${property.propertyName}</div>
                                    <div class="card-location">📍 ${property.roadAddress}</div>
                                    <div class="card-price">
                                        <c:if test="${property.deposit > 0}">${property.deposit}</c:if>
                                        <c:if test="${property.monthlyRent > 0}">/${property.monthlyRent}</c:if>
                                    </div>
                                    <div class="card-info">
                                        <span>${property.typeIcon} ${propertyTypeKorean}</span>
                                        <span>📏 <fmt:formatNumber value="${areaPyung}" pattern="0.0"/>평</span>
                                        <span>📅 <fmt:formatDate value="${property.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    </div>
                                    <div class="card-actions">
                                        <button class="btn-card btn-edit" onclick="event.stopPropagation(); location.href='${pageContext.request.contextPath}/realtor/property-edit?id=${property.propertyNo}'">수정</button>
                                        <button class="btn-card btn-status" onclick="event.stopPropagation(); showStatusModal(${property.propertyNo}, '${property.status}')">상태변경</button>
                                        <button class="btn-card btn-delete" onclick="event.stopPropagation(); deleteProperty(${property.propertyNo})">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="pagination">
                <c:if test="${pager.currentPage > 1}">
                    <button onclick="location.href='?page=${pager.currentPage - 1}&${filterParams}'">← 이전</button>
                </c:if>
                <c:forEach var="pageNo" begin="${pager.startPage}" end="${pager.endPage}">
                    <button class="${pageNo eq pager.currentPage ? 'active' : ''}" onclick="location.href='?page=${pageNo}&${filterParams}'">${pageNo}</button>
                </c:forEach>
                <c:if test="${pager.currentPage < pager.maxPage}">
                    <button onclick="location.href='?page=${pager.currentPage + 1}&${filterParams}'">다음 →</button>
                </c:if>
            </div>
            <c:if test="${pager.maxPage == 0 || pager.maxPage == 1}">
                <style>.pagination { display: none; }</style>
            </c:if>
        </div>
    </main>
</div>

<%-- 상태 변경 MODAL HTML 구조 --%>
<div id="statusModal" class="modal-overlay">
    <div class="modal-content">
        <h3 id="modalTitle">매물 상태 변경</h3>
        <p>현재 상태: <strong id="currentStatusDisplay"></strong></p>
        <p>변경할 상태를 선택하세요:</p>
        
        <div class="status-button-group">
            <button class="btn-modal-active" data-status="ACTIVE">판매중</button>
            <button class="btn-modal-reserved" data-status="RESERVED">예약중</button>
            <button class="btn-modal-completed" data-status="COMPLETED">거래완료</button>
        </div>
        <button class="btn-modal-cancel" onclick="hideStatusModal()">취소</button>
    </div>
</div>

<script>
    // 전역 변수로 현재 처리 중인 매물 ID 저장
    let currentPropertyId = null;

    // Helper function to map status code to display name
    const statusMap = { 'ACTIVE': '판매중', 'RESERVED': '예약중', 'COMPLETED': '거래완료' };

    /**
     * 상태 변경 모달을 띄우는 함수
     */
    function showStatusModal(propertyId, currentStatus) {
        currentPropertyId = propertyId;
        const currentStatusDisplay = statusMap[currentStatus] || currentStatus;

        document.getElementById('currentStatusDisplay').textContent = currentStatusDisplay;
        
        // ⭐ 수정 완료: 매물 번호만 표시
        document.getElementById('modalTitle').textContent = `매물 ${propertyId} 상태 변경`; 
        
        document.getElementById('statusModal').style.display = 'flex';
    }

    /**
     * 상태 변경 모달을 숨기는 함수
     */
    function hideStatusModal() {
        document.getElementById('statusModal').style.display = 'none';
        currentPropertyId = null; // ID 초기화
    }

    /**
     * 상태 변경 요청을 AJAX로 처리하는 함수
     * @param {string} newStatus 변경할 상태 코드 (ACTIVE, RESERVED, COMPLETED)
     */
    function changeStatus(newStatus) {
        if (!currentPropertyId) return;

        fetch('${pageContext.request.contextPath}/realtor/property/change-status', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'propertyId=' + currentPropertyId + '&newStatus=' + newStatus
        })
        .then(response => response.json())
        .then(data => {
            hideStatusModal();
            if (data.success) {
                alert(data.message || "매물 상태가 성공적으로 변경되었습니다.");
                location.reload(); 
            } else {
                alert(data.message || "매물 상태 변경에 실패했습니다.");
            }
        })
        .catch(error => {
            console.error('상태 변경 요청 중 오류 발생:', error);
            hideStatusModal();
            alert('서버 통신 중 오류가 발생했습니다.');
        });
    }

    function deleteProperty(propertyId) {
        if (confirm(`[${propertyId}번 매물] 정말로 이 매물을 삭제하시겠습니까?`)) {
            
            fetch('${pageContext.request.contextPath}/realtor/property/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'propertyId=' + propertyId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message || "매물이 성공적으로 삭제되었습니다.");
                    location.reload(); 
                } else {
                    alert(data.message || "매물 삭제에 실패했습니다.");
                }
            })
            .catch(error => {
                console.error('삭제 요청 중 오류 발생:', error);
                alert('서버 통신 중 오류가 발생했습니다.');
            });
        }
    }

    /**
     * 필터링 폼을 제출하여 매물 목록을 갱신합니다.
     */
    function submitFilter() {
        const form = document.getElementById('filterForm');
        form.submit();
    }
    
    // DOMContentLoaded: 모달 버튼 이벤트 리스너 및 검색 아이콘 이벤트 등록
    document.addEventListener('DOMContentLoaded', () => {
        const searchIcon = document.querySelector('.search-icon');
        if (searchIcon) {
            searchIcon.addEventListener('click', submitFilter);
        }

        // 모달 내 상태 변경 버튼에 이벤트 리스너 등록
        document.querySelectorAll('.status-button-group button').forEach(button => {
            button.addEventListener('click', function() {
                const newStatus = this.getAttribute('data-status');
                changeStatus(newStatus);
            });
        });
        
        // 오버레이 클릭 시 모달 닫기
        document.getElementById('statusModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hideStatusModal();
            }
        });
    });
</script>
</body>
</html>