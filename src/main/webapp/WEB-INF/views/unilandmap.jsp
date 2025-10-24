<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지도 검색 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dcf1c6a535cc727189e80cbf9ad7b43&libraries=services"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            color: #1a1a1a;
            overflow: hidden; 
        }

        /* 헤더 */
        header {
            background: white;
            border-bottom: 1px solid #e5e5e5;
            padding: 18px 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }

        .header-container {
            max-width: 100%;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 24px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 32px;
        }

        .logo {
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .logo img {
            height: 60px;
            object-fit: contain;
            object-position: center;
        }

        .filter-toggle-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 9px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-toggle-btn:hover {
            background: linear-gradient(135deg, #5568d3 0%, #6a4091 100%);
        }

        .filter-toggle-btn .arrow {
            transition: transform 0.3s;
        }

        .filter-toggle-btn.active .arrow {
            transform: rotate(180deg);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-info a, .user-info button {
            padding: 9px 20px;
            background: none;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #555;
        }

        .user-info a:hover, .user-info button:hover {
            color: #667eea;
            background: #f5f5f5;
        }

        .btn-mypage,
        .btn-dashboard {
            color: #667eea;
        }

        .btn-login {
            color: #555;
        }

        .btn-logout {
            color: #f56565;
        }

        .btn-logout:hover {
            color: #e53e3e;
            background: #fee;
        }

        .login-prompt {
            color: #4a5568;
            font-size: 14px;
        }

        /* 아코디언 필터 영역 */
        .accordion-filter {
            position: fixed;
            top: 62px;
            left: 0;
            right: 0;
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
            z-index: 999;
            
        }

        .accordion-filter.active {
            max-height: 400px;
            overflow-y: auto;
        }

        .filter-content {
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px 30px;
        }

        .filter-row {
            margin-bottom: 0;
        }

        .filter-row.full-width {
            grid-column: 1 / -1;
        }

        .filter-label {
            margin-top: 30px;
            font-size: 14px;
            color: #718096;
            font-weight: 600;
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #e2e8f0;
            background: white;
            color: #4a5568;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .filter-btn:hover {
            border-color: #cbd5e0;
        }

        .filter-btn.active {
            background: #2d3748;
            color: white;
            border-color: #2d3748;
        }

        .price-range {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .price-slider {
            width: 100%;
            position: relative;
            height: 50px;
        }

        .price-slider-base {
            position: absolute;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            top: 22px;
            width: 100%;
            pointer-events: none;
        }

        .price-slider-ticks {
            position: absolute;
            width: 100%;
            top: 28px;
            display: flex;
            justify-content: space-between;
            padding: 0 0;
            pointer-events: none;
        }

        .price-slider-tick {
            width: 1px;
            height: 8px;
            background: #cbd5e0;
        }

        .price-slider-tick:first-child,
        .price-slider-tick:last-child {
            background: transparent;
        }

        .price-slider-labels {
            position: absolute;
            width: 100%;
            top: 36px;
            display: flex;
            justify-content: space-between;
            padding: 0 0;
            pointer-events: none;
        }

        .price-slider-label {
            font-size: 10px;
            color: #a0aec0;
            transform: translateX(-50%);
        }

        .price-slider-label:first-child {
            transform: translateX(0);
        }

        .price-slider-label:last-child {
            transform: translateX(-100%);
        }

        .price-slider-track {
            position: absolute;
            height: 6px;
            background: #667eea;
            border-radius: 3px;
            top: 22px;
            pointer-events: none;
            z-index: 1;
        }

        .price-slider input[type="range"] {
            position: absolute;
            width: 100%;
            height: 6px;
            border-radius: 3px;
            background: transparent;
            outline: none;
            appearance: none;
            pointer-events: none;
            top: 22px;
            z-index: 2;
        }

        .price-slider input[type="range"]::-webkit-slider-thumb {
            appearance: none;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: #667eea;
            cursor: pointer;
            pointer-events: auto;
            border: 2px solid white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .price-slider input[type="range"]::-moz-range-thumb {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: #667eea;
            cursor: pointer;
            border: 2px solid white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            pointer-events: auto;
        }

        .price-display {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .price-display span {
            background: #f7fafc;
            padding: 4px 10px;
            border-radius: 4px;
            border: 1px solid #e2e8f0;
        }

        .search-dropdown {
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-input::placeholder {
            color: #a0aec0;
        }

        .dropdown-list {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid #e2e8f0;
            border-top: none;
            border-radius: 0 0 4px 4px;
            max-height: 200px;
            overflow-y: auto;
            display: none;
            z-index: 10;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .dropdown-list.active {
            display: block;
        }

        .dropdown-item {
            padding: 10px 15px;
            cursor: pointer;
            transition: background 0.2s;
            font-size: 14px;
            color: #4a5568;
        }

        .dropdown-item:hover {
            background: #f7fafc;
        }

        .dropdown-item.selected {
            background: #667eea;
            color: white;
            font-weight: 600;
        }

        .dropdown-item.no-results {
            color: #a0aec0;
            cursor: default;
        }

        .dropdown-item.no-results:hover {
            background: white;
        }

        .selected-tags {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .tag {
            background: #667eea;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .tag .remove {
            cursor: pointer;
            font-weight: bold;
        }

        .school-with-radius {
            display: flex;
            gap: 10px;
            align-items: flex-start;
        }

        .school-search {
            flex: 1;
        }

        .radius-select {
            width: 120px;
        }

        .radius-select select {
            width: 100%;
            padding: 10px 12px;
            border: 2px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            background: white;
        }

        .radius-select select:focus {
            outline: none;
            border-color: #667eea;
        }

        .radius-label {
            font-size: 12px;
            color: #718096;
            margin-bottom: 5px;
        }

        .price-input {
            flex: 1;
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
        }

        .price-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .apply-buttons {
            display: flex;
            gap: 10px;
            margin-top: 0;
            padding-top: 20px;
            border-top: 2px solid #e2e8f0;
            grid-column: 1 / -1;
        }

        .apply-buttons button {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-reset {
            background: #f7fafc;
            color: #4a5568;
        }

        .btn-reset:hover {
            background: #e2e8f0;
        }

        .btn-apply {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-apply:hover {
            background: linear-gradient(135deg, #5568d3 0%, #6b3f8f 100%);
        }

        /* 메인 레이아웃 */
        .main-layout {
            display: flex;
            margin-top: 62px;
            height: calc(100vh - 62px);
        }

        /* 왼쪽 사이드바 */
        .sidebar {
            width: 380px;
            background: white;
            box-shadow: 2px 0 8px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            z-index: 100;
        }

        .list-header {
            margin-top: 30px;
            padding: 15px 20px;
            background: white;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .list-header h2 {
            font-size: 16px;
            color: #2d3748;
        }

        .list-header .count {
            color: #667eea;
            font-weight: bold;
        }

        .sort-select {
            padding: 6px 10px;
            border: 2px solid #e2e8f0;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
        }

        .property-list-content {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
        }

        .property-card {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 6px;
            overflow: hidden;
            margin-bottom: 15px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .property-card:hover {
            border-color: #667eea;
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
        }

        .card-image {
            width: 100%;
            height: 180px;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .card-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(102, 126, 234, 0.9);
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 600;
        }

        .card-content {
            padding: 15px;
        }

        .card-title {
            font-size: 15px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .card-location {
            font-size: 13px;
            color: #718096;
            margin-bottom: 10px;
        }

        .card-price {
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .card-tags {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        .card-tags span {
            background: #f7fafc;
            color: #4a5568;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
        }

        /* 지도 영역 */
        .map-container {
            flex: 1;
            position: relative;
        }

        #map {
            width: 100%;
            height: 100%;
        }

        .map-controls {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            z-index: 10;
        }

        .control-btn {
            margin-top: 15px;
            background: white;
            border: none;
            padding: 12px 16px;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            transition: all 0.3s;
        }

        .control-btn:hover {
            background: #f7fafc;
            transform: translateY(-2px);
        }

        .property-counter {
            margin-top: 15px;
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: white;
            padding: 12px 24px;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            font-weight: 600;
            color: #2d3748;
            z-index: 10;
            font-size: 15px;
        }

        .property-counter span {
            color: #667eea;
            font-size: 18px;
        }

        .custom-overlay {
            position: relative;
            background: white;
            border: 2px solid #667eea;
            border-radius: 4px;
            padding: 6px 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            font-size: 13px;
            font-weight: 600;
            color: #2d3748;
            cursor: pointer;
        }

        .custom-overlay:after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 8px solid transparent;
            border-right: 8px solid transparent;
            border-top: 8px solid #667eea;
        }

        .custom-overlay:hover {
            background: #f7fafc;
        }

        .property-list-content::-webkit-scrollbar,
        .accordion-filter::-webkit-scrollbar {
            width: 8px;
        }

        .property-list-content::-webkit-scrollbar-track,
        .accordion-filter::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .property-list-content::-webkit-scrollbar-thumb,
        .accordion-filter::-webkit-scrollbar-thumb {
            background: #cbd5e0;
            border-radius: 4px;
        }

        .property-list-content::-webkit-scrollbar-thumb:hover,
        .accordion-filter::-webkit-scrollbar-thumb:hover {
            background: #a0aec0;
        }

        /* 상세정보 사이드바 */
        .detail-sidebar {
            position: fixed;
            top: 62px;
            left: 380px;
            width: 0;
            height: calc(100vh - 62px);
            background: white;
            box-shadow: 2px 0 16px rgba(0,0,0,0.15);
            z-index: 101;
            transition: width 0.3s ease-out;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .detail-sidebar.active {
            width: 500px;
        }

        .detail-header {
            margin-top:30px ;
            position: sticky;
            top: 0;
            background: white;
            padding: 20px;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
            width: 500px;
            flex-shrink: 0;
        }

        .detail-header h2 {
            font-size: 20px;
            color: #2d3748;
            font-weight: bold;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 28px;
            color: #718096;
            cursor: pointer;
            padding: 0;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: all 0.2s;
        }

        .close-btn:hover {
            background: #f7fafc;
            color: #2d3748;
        }

        .detail-content {
            padding: 0;
            width: 500px;
            flex-shrink: 0;
        }

        .detail-images {
            width: 500px;
            height: 300px;
            position: relative;
            background: #f0f0f0;
            flex-shrink: 0;
        }

        .detail-images img {
            width: 500px;
            height: 100%;
            object-fit: cover;
        }

        .detail-info {
            padding: 25px;
            width: 500px;
            flex-shrink: 0;
        }

        .detail-price {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 15px;
        }

        .detail-title {
            font-size: 22px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .detail-location {
            font-size: 15px;
            color: #718096;
            margin-bottom: 20px;
        }

        .detail-section {
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid #e2e8f0;
        }

        .detail-section:last-child {
            border-bottom: none;
        }

        .detail-section h3 {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 12px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background: #f7fafc;
            border-radius: 4px;
        }

        .detail-item-label {
            color: #718096;
            font-size: 14px;
        }

        .detail-item-value {
            color: #2d3748;
            font-weight: 600;
            font-size: 14px;
        }

        .detail-options {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .detail-option {
            background: #e0e7ff;
            color: #667eea;
            padding: 8px 14px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
        }

        .detail-description {
            color: #4a5568;
            line-height: 1.6;
            font-size: 14px;
        }

        .detail-actions {
            padding: 20px 25px;
            border-top: 2px solid #e2e8f0;
            display: flex;
            gap: 10px;
            position: sticky;
            bottom: 0;
            background: white;
            width: 500px;
            flex-shrink: 0;
        }

        .detail-actions button {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-contact {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-contact:hover {
            background: linear-gradient(135deg, #5568d3 0%, #6b3f8f 100%);
        }

        .btn-favorite {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-favorite:hover {
            background: #f7fafc;
        }
        .btn-detail {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-detail:hover {
            background: #667eea;
            color: white;
        }

        .detail-sidebar::-webkit-scrollbar {
            width: 8px;
        }

        .detail-sidebar::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .detail-sidebar::-webkit-scrollbar-thumb {
            background: #cbd5e0;
            border-radius: 4px;
        }

        .detail-sidebar::-webkit-scrollbar-thumb:hover {
            background: #a0aec0;
        }

        .sidebar-overlay {
            position: fixed;
            top: 62px;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.3);
            z-index: 100;
            display: none;
            transition: opacity 0.3s;
        }

        .sidebar-overlay.active {
            display: block;
        }
    </style>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="header-left">
                <div class="logo" onclick="location.href='${pageContext.request.contextPath}/'">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
                </div>
                <button class="filter-toggle-btn" onclick="toggleFilter()">
                    <i class="fa-solid fa-sliders"></i> 조건 보기
                    <span class="arrow">▼</span>
                </button>
            </div>
            <div class="user-info">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <a href="${pageContext.request.contextPath}/mypage" class="btn-mypage">
                            <i class="fa-solid fa-user"></i> ${sessionScope.loginUser.userName}님
                        </a>
                        <button class="btn-logout" onclick="logout()">
                            <i class="fa-solid fa-right-from-bracket"></i> 로그아웃
                        </button>
                    </c:when>
                    <c:when test="${not empty sessionScope.loginRealtor}">
                        <a href="${pageContext.request.contextPath}/realtor/realtor-dashboard" class="btn-dashboard">
                            <i class="fa-solid fa-chart-line"></i> ${sessionScope.loginRealtor.realtorName} 중개사님
                        </a>
                        <button class="btn-logout" onclick="logout()">
                            <i class="fa-solid fa-right-from-bracket"></i> 로그아웃
                        </button>
                    </c:when>
                    <c:otherwise>
                        <span class="login-prompt">로그인하여 더 많은 기능 이용하기</span>
                        <a href="${pageContext.request.contextPath}/auth/login?redirectUrl=/map" class="btn-login">
                            <i class="fa-solid fa-right-to-bracket"></i> 로그인
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <div class="accordion-filter" id="accordionFilter">
        <div class="filter-content">
            <div class="filter-row">
                <div class="filter-label">지역</div>
                <div class="search-dropdown">
                    <input type="text" class="search-input" id="regionSearch" placeholder="🔍 지역 검색 (예: 강남구, 마포구)" 
                           onfocus="showRegionDropdown()" oninput="filterRegions()">
                    <div class="dropdown-list" id="regionDropdown"></div>
                </div>
                <div class="selected-tags" id="selectedRegions"></div>
            </div>

            <div class="filter-row">
                <div class="filter-label">학교</div>
                <div class="school-with-radius">
                    <div class="school-search">
                        <div class="search-dropdown">
                            <input type="text" class="search-input" id="schoolSearch" placeholder="🔍 학교 검색 (예: 연세대, 홍익대)" 
                                onfocus="showSchoolDropdown()" oninput="filterSchools()">
                            <div class="dropdown-list" id="schoolDropdown"></div>
                        </div>
                        <div class="selected-tags" id="selectedSchools"></div>
                    </div>
                    <div class="radius-select">
                        <div class="radius-label">반경</div>
                        <select id="schoolRadius">
                            <option value="0.5">500m</option>
                            <option value="1">1km</option>
                            <option value="1.5">1.5km</option>
                            <option value="2" selected>2km</option>
                            <option value="3">3km</option>
                            <option value="5">5km</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="filter-row">
                <div class="filter-label">매물 유형</div>
                <div class="filter-buttons">
                    <button class="filter-btn active" onclick="toggleFilterBtn(this)">원룸</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">투룸</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">쓰리룸</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">오피스텔</button>
                </div>
            </div>

            <div class="filter-row">
                <div class="filter-label">학생 특화</div>
                <div class="filter-buttons">
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">학생 우대</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">단기 계약</button>
                </div>
            </div>

            <div class="filter-row">
                <div class="filter-label">보증금 (만원)</div>
                <div class="price-range">
                    <div class="price-display">
                        <span id="depositMinDisplay">0</span>
                        <span>~</span>
                        <span id="depositMaxDisplay">5,000</span>
                    </div>
                    <div class="price-slider">
                        <div class="price-slider-base"></div>
                        <div class="price-slider-ticks">
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                        </div>
                        <div class="price-slider-labels">
                            <span class="price-slider-label">0</span>
                            <span class="price-slider-label">500</span>
                            <span class="price-slider-label">1000</span>
                            <span class="price-slider-label">1500</span>
                            <span class="price-slider-label">2000</span>
                            <span class="price-slider-label">2500</span>
                            <span class="price-slider-label">3000</span>
                            <span class="price-slider-label">3500</span>
                            <span class="price-slider-label">4000</span>
                            <span class="price-slider-label">4500</span>
                            <span class="price-slider-label">5000</span>
                        </div>
                        <div class="price-slider-track" id="depositTrack"></div>
                        <input type="range" id="depositMin" min="0" max="5000" value="0" step="100" oninput="updateDepositDisplay()">
                        <input type="range" id="depositMax" min="0" max="5000" value="5000" step="100" oninput="updateDepositDisplay()">
                    </div>
                </div>
            </div>

            <div class="filter-row">
                <div class="filter-label">월세 (만원)</div>
                <div class="price-range">
                    <div class="price-display">
                        <span id="rentMinDisplay">0</span>
                        <span>~</span>
                        <span id="rentMaxDisplay">200</span>
                    </div>
                    <div class="price-slider">
                        <div class="price-slider-base"></div>
                        <div class="price-slider-ticks">
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                            <div class="price-slider-tick"></div>
                        </div>
                        <div class="price-slider-labels">
                            <span class="price-slider-label">0</span>
                            <span class="price-slider-label">20</span>
                            <span class="price-slider-label">40</span>
                            <span class="price-slider-label">60</span>
                            <span class="price-slider-label">80</span>
                            <span class="price-slider-label">100</span>
                            <span class="price-slider-label">120</span>
                            <span class="price-slider-label">140</span>
                            <span class="price-slider-label">160</span>
                            <span class="price-slider-label">180</span>
                            <span class="price-slider-label">200</span>
                        </div>
                        <div class="price-slider-track" id="rentTrack"></div>
                        <input type="range" id="rentMin" min="0" max="200" value="0" step="5" oninput="updateRentDisplay()">
                        <input type="range" id="rentMax" min="0" max="200" value="200" step="5" oninput="updateRentDisplay()">
                    </div>
                </div>
            </div>

            <div class="filter-row full-width">
                <div class="filter-label">냉난방</div>
                <div class="filter-buttons">
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">에어컨</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">히터</button>
                </div>
            </div>

            <div class="filter-row full-width" style="margin-top: 20px;">
                <div class="filter-label">주방</div>
                <div class="filter-buttons">
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">냉장고</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">전자레인지</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">인덕션</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">가스레인지</button>
                </div>
            </div>

            <div class="filter-row full-width" style="margin-top: 20px;">
                <div class="filter-label">가구/가전</div>
                <div class="filter-buttons">
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">세탁기</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">건조기</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">침대</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">책상</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">옷장</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">신발장</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">TV</button>
                </div>
            </div>

            <div class="filter-row full-width" style="margin-top: 20px;">
                <div class="filter-label">시설</div>
                <div class="filter-buttons">
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">주차가능</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">엘리베이터</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">보안시스템</button>
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">반려동물</button>
                </div>
            </div>

            <div class="apply-buttons">
                <button class="btn-reset" onclick="resetFilters()">초기화</button>
                <button class="btn-apply" onclick="applyFilters()">적용하기</button>
            </div>
        </div>
    </div>

    <div class="main-layout">
        <div class="sidebar">
            <div class="list-header">
                <h2>매물 <span class="count">24</span>개</h2>
                <select class="sort-select">
                    <option>추천순</option>
                    <option>최신순</option>
                    <option>가격낮은순</option>
                    <option>가격높은순</option>
                </select>
            </div>

            <div class="property-list-content">
                <div class="property-card" onclick="showPropertyDetail(1)">
                    <div class="card-image">
                        <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop" alt="원룸">
                        <span class="card-badge">학생 우대</span>
                    </div>
                    <div class="card-content">
                        <div class="card-title">신촌역 5분거리 풀옵션 원룸</div>
                        <div class="card-location">📍 서울 서대문구 창천동</div>
                        <div class="card-price">500/55</div>
                        <div class="card-tags">
                            <span>풀옵션</span>
                            <span>역세권</span>
                            <span>단기가능</span>
                        </div>
                    </div>
                </div>

                <div class="property-card" onclick="showPropertyDetail(2)">
                    <div class="card-image">
                        <img src="https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=300&fit=crop" alt="오피스텔">
                        <span class="card-badge">NEW</span>
                    </div>
                    <div class="card-content">
                        <div class="card-title">연희동 깨끗한 오피스텔</div>
                        <div class="card-location">📍 서울 서대문구 연희동</div>
                        <div class="card-price">1000/60</div>
                        <div class="card-tags">
                            <span>신축</span>
                            <span>주차</span>
                            <span>엘베</span>
                        </div>
                    </div>
                </div>

                <div class="property-card" onclick="showPropertyDetail(3)">
                    <div class="card-image">
                        <img src="https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop" alt="원룸">
                    </div>
                    <div class="card-content">
                        <div class="card-title">홍대 캠퍼스 앞 저렴한 원룸</div>
                        <div class="card-location">📍 서울 마포구 서교동</div>
                        <div class="card-price">300/45</div>
                        <div class="card-tags">
                            <span>저렴</span>
                            <span>학교근처</span>
                        </div>
                    </div>
                </div>

                <div class="property-card" onclick="showPropertyDetail(4)">
                    <div class="card-image">
                        <img src="https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400&h=300&fit=crop" alt="원룸">
                        <span class="card-badge">학생 우대</span>
                    </div>
                    <div class="card-content">
                        <div class="card-title">이대역 도보 3분 원룸</div>
                        <div class="card-location">📍 서울 서대문구 대현동</div>
                        <div class="card-price">700/55</div>
                        <div class="card-tags">
                            <span>역세권</span>
                            <span>풀옵션</span>
                        </div>
                    </div>
                </div>

                <div class="property-card" onclick="showPropertyDetail(5)">
                    <div class="card-image">
                        <img src="https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=400&h=300&fit=crop" alt="투룸">
                    </div>
                    <div class="card-content">
                        <div class="card-title">성신여대 도보 5분 투룸</div>
                        <div class="card-location">📍 서울 성북구 동선동</div>
                        <div class="card-price">500/65</div>
                        <div class="card-tags">
                            <span>투룸</span>
                            <span>단기가능</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="map-container">
            <div id="map"></div>
            
            <div class="property-counter">
                현재 지도에 <span id="propertyCount">24</span>개 매물
            </div>

            <div class="map-controls">
                <button class="control-btn" onclick="goToMyLocation()">
                    📍 현재 위치
                </button>
            </div>
        </div>
    </div>

    <div class="sidebar-overlay" id="sidebarOverlay" onclick="closePropertyDetail()"></div>

    <div class="detail-sidebar" id="detailSidebar">
        <div class="detail-header">
            <h2>매물 상세정보</h2>
            <button class="close-btn" onclick="closePropertyDetail()">×</button>
        </div>
        <div class="detail-content">
            <div class="detail-images">
                <img id="detailImage" src="" alt="매물 사진">
            </div>
            <div class="detail-info">
                <div class="detail-price" id="detailPrice">500/55</div>
                <div class="detail-title" id="detailTitle">신촌역 5분거리 풀옵션 원룸</div>
                <div class="detail-location" id="detailLocation">📍 서울 서대문구 창천동</div>

                <div class="detail-section">
                    <h3>기본 정보</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-item-label">방 종류</span>
                            <span class="detail-item-value" id="detailRoomType">원룸</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-item-label">전용면적</span>
                            <span class="detail-item-value">20㎡</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-item-label">층수</span>
                            <span class="detail-item-value">3층</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-item-label">관리비</span>
                            <span class="detail-item-value">5만원</span>
                        </div>
                    </div>
                </div>

                <div class="detail-section">
                    <h3>옵션</h3>
                    <div class="detail-options" id="detailOptions">
                        <span class="detail-option">에어컨</span>
                        <span class="detail-option">냉장고</span>
                        <span class="detail-option">세탁기</span>
                        <span class="detail-option">침대</span>
                        <span class="detail-option">책상</span>
                    </div>
                </div>

                <div class="detail-section">
                    <h3>상세 설명</h3>
                    <div class="detail-description" id="detailDescription">
                        신촌역에서 도보 5분 거리에 위치한 풀옵션 원룸입니다.
                        연세대, 이화여대 도보 통학 가능하며 주변 편의시설이 우수합니다.
                        최근 리모델링하여 깔끔한 상태이며, 보일러 개별 난방으로 관리비 부담이 적습니다.
                    </div>
                </div>
            </div>
        </div>
        <div class="detail-actions">
            <button class="btn-favorite">♡ 찜하기</button>
            <button class="btn-contact">중개사 문의하기</button>
            <button class="btn-detail" onclick="openDetailPage()">🔍 전체 상세보기</button>
        </div>
    </div>

    <script>
        // 카카오맵 초기화
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.5592, 126.9425), // 신촌역 중심
            level: 6
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 샘플 매물 데이터 (실제 위치 좌표)
        var properties = [
            { id: 1, lat: 37.5592, lng: 126.9425, title: "신촌역 원룸", price: "500/55" },          // 신촌역 (서대문구 창천동)
            { id: 2, lat: 37.5665, lng: 126.9361, title: "홍대 오피스텔", price: "1000/60" },      // 연희동
            { id: 3, lat: 37.5506, lng: 126.9229, title: "홍대 캠퍼스 원룸", price: "300/45" },    // 홍대 서교동
            { id: 4, lat: 37.5569, lng: 126.9464, title: "이대역 원룸", price: "700/55" },         // 이대역 (대현동)
            { id: 5, lat: 37.5928, lng: 127.0167, title: "성신여대 투룸", price: "500/65" }        // 성신여대 (동선동)
        ];

        var overlays = []; // 오버레이 저장용

        // 마커 표시 (커스텀 오버레이만 사용)
        properties.forEach(function(property) {
            var markerPosition = new kakao.maps.LatLng(property.lat, property.lng);

            var content = '<div class="custom-overlay" onclick="showPropertyDetail(' + property.id + ')">'
                + property.price + '</div>';

            var customOverlay = new kakao.maps.CustomOverlay({
                position: markerPosition,
                content: content,
                yAnchor: 1.5
            });

            customOverlay.setMap(map);
            overlays.push(customOverlay);
        });

        // 지역/학교 데이터
        var regions = ['강남구', '서초구', '송파구', '강동구', '마포구', '서대문구', '종로구', '성북구', '강서구', '양천구', '영등포구', '동작구', '관악구', '구로구', '금천구', '광진구', '성동구', '중랑구', '동대문구', '노원구', '도봉구', '은평구', '서대문구', '용산구', '중구'];
        var schools = ['연세대학교', '고려대학교', '서울대학교', '홍익대학교', '성균관대학교', '이화여자대학교', '한양대학교', '건국대학교', '동국대학교', '중앙대학교', '경희대학교', '서울시립대학교', '숙명여자대학교', '성신여자대학교', '국민대학교'];
        
        var selectedRegions = [];
        var selectedSchools = [];

        // 지역 드롭다운 표시
        function showRegionDropdown() {
            document.getElementById('regionDropdown').classList.add('active');
            filterRegions();
        }

        // 지역 필터링
        function filterRegions() {
            var input = document.getElementById('regionSearch').value.toLowerCase().trim();
            var dropdown = document.getElementById('regionDropdown');

            // 빈 입력이면 전체 목록 표시
            var filtered = input === '' ? regions : regions.filter(r => r.toLowerCase().includes(input));

            if (filtered.length === 0) {
                dropdown.innerHTML = '<div class="dropdown-item no-results">검색 결과 없음</div>';
            } else {
                var html = filtered.map(function(region) {
                    var selectedClass = selectedRegions.includes(region) ? 'selected' : '';
                    return '<div class="dropdown-item ' + selectedClass + '"' +
                           ' onclick="toggleRegion(\'' + region + '\')">' + region + '</div>';
                }).join('');
                dropdown.innerHTML = html;
            }
        }

        // 지역 선택/해제
        function toggleRegion(region) {
            if (selectedRegions.includes(region)) {
                selectedRegions = selectedRegions.filter(r => r !== region);
            } else {
                selectedRegions.push(region);
            }
            updateSelectedRegions();
            filterRegions() ;
        }

        // 선택된 지역 표시
        function updateSelectedRegions() {
            var container = document.getElementById('selectedRegions');
            container.innerHTML = selectedRegions.map(function(region) {
                return '<div class="tag">' + region + ' <span class="remove" onclick="toggleRegion(\'' + region + '\')">×</span></div>';
            }).join('');
        }

        // 학교 드롭다운 표시
        function showSchoolDropdown() {
            document.getElementById('schoolDropdown').classList.add('active');
            filterSchools();
        }

        // 학교 필터링
        function filterSchools() {
            var input = document.getElementById('schoolSearch').value.toLowerCase().trim();
            var dropdown = document.getElementById('schoolDropdown');

            // 빈 입력이면 전체 목록 표시
            var filtered = input === '' ? schools : schools.filter(s => s.toLowerCase().includes(input));

            if (filtered.length === 0) {
                dropdown.innerHTML = '<div class="dropdown-item no-results">검색 결과 없음</div>';
            } else {
                var html = filtered.map(function(school) {
                    var selectedClass = selectedSchools.includes(school) ? 'selected' : '';
                    return '<div class="dropdown-item ' + selectedClass + '"' +
                           ' onclick="toggleSchool(\'' + school + '\')">' + school + '</div>';
                }).join('');
                dropdown.innerHTML = html;
            }
        }

        // 학교 선택/해제
        function toggleSchool(school) {
            if (selectedSchools.includes(school)) {
                selectedSchools = selectedSchools.filter(s => s !== school);
            } else {
                selectedSchools.push(school);
            }
            updateSelectedSchools();
            filterSchools();
        }

        // 선택된 학교 표시
        function updateSelectedSchools() {
            var container = document.getElementById('selectedSchools');
            container.innerHTML = selectedSchools.map(function(school) {
                return '<div class="tag">' + school + ' <span class="remove" onclick="toggleSchool(\'' + school + '\')">×</span></div>';
            }).join('');
        }

        // 드롭다운 외부 클릭 시 닫기
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.search-dropdown')) {
                document.getElementById('regionDropdown').classList.remove('active');
                document.getElementById('schoolDropdown').classList.remove('active');
            }

            // 필터 외부 클릭 시 닫기
            if (!e.target.closest('.accordion-filter') && !e.target.closest('.filter-toggle-btn')) {
                var filter = document.getElementById('accordionFilter');
                var btn = document.querySelector('.filter-toggle-btn');
                if (filter.classList.contains('active')) {
                    filter.classList.remove('active');
                    btn.classList.remove('active');
                }
            }

            // 상세정보 슬라이드 외부 클릭 시 닫기
            if (!e.target.closest('.detail-sidebar') && !e.target.closest('.property-card') && !e.target.closest('.custom-overlay')) {
                var detailSidebar = document.getElementById('detailSidebar');
                var overlay = document.getElementById('sidebarOverlay');
                if (detailSidebar.classList.contains('active')) {
                    detailSidebar.classList.remove('active');
                    overlay.classList.remove('active');
                }
            }
        });

        // 보증금 슬라이더 업데이트
        function updateDepositDisplay() {
            var minVal = parseInt(document.getElementById('depositMin').value);
            var maxVal = parseInt(document.getElementById('depositMax').value);
            var minInput = document.getElementById('depositMin');
            var maxInput = document.getElementById('depositMax');

            // 최소값이 최대값보다 크면 조정
            if (minVal > maxVal) {
                if (event.target === minInput) {
                    minInput.value = maxVal;
                    minVal = maxVal;
                } else {
                    maxInput.value = minVal;
                    maxVal = minVal;
                }
            }

            // 값 표시 - 범위로 표시
            document.getElementById('depositMinDisplay').textContent = minVal.toLocaleString();
            document.getElementById('depositMaxDisplay').textContent = maxVal.toLocaleString();

            // 트랙 업데이트
            var percent1 = (minVal / 5000) * 100;
            var percent2 = (maxVal / 5000) * 100;
            var track = document.getElementById('depositTrack');
            track.style.left = percent1 + '%';
            track.style.width = (percent2 - percent1) + '%';
        }

        // 월세 슬라이더 업데이트
        function updateRentDisplay() {
            var minVal = parseInt(document.getElementById('rentMin').value);
            var maxVal = parseInt(document.getElementById('rentMax').value);
            var minInput = document.getElementById('rentMin');
            var maxInput = document.getElementById('rentMax');

            // 최소값이 최대값보다 크면 조정
            if (minVal > maxVal) {
                if (event.target === minInput) {
                    minInput.value = maxVal;
                    minVal = maxVal;
                } else {
                    maxInput.value = minVal;
                    maxVal = minVal;
                }
            }

            // 값 표시 - 범위로 표시
            document.getElementById('rentMinDisplay').textContent = minVal.toLocaleString();
            document.getElementById('rentMaxDisplay').textContent = maxVal.toLocaleString();

            // 트랙 업데이트
            var percent1 = (minVal / 200) * 100;
            var percent2 = (maxVal / 200) * 100;
            var track = document.getElementById('rentTrack');
            track.style.left = percent1 + '%';
            track.style.width = (percent2 - percent1) + '%';
        }

        // 필터 토글
        function toggleFilter() {
            var filter = document.getElementById('accordionFilter');
            var btn = document.querySelector('.filter-toggle-btn');

            filter.classList.toggle('active');
            btn.classList.toggle('active');
        }

        // 로그아웃
        function logout() {
            if(confirm('로그아웃 하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/auth/logout';
            }
        }

        // 필터 버튼 토글 (직방 스타일)
        function toggleFilterBtn(btn) {
            btn.classList.toggle('active');
        }

        // 필터 초기화
        function resetFilters() {
            // 지역/학교 초기화
            selectedRegions = [];
            selectedSchools = [];
            updateSelectedRegions();
            updateSelectedSchools();
            document.getElementById('regionSearch').value = '';
            document.getElementById('schoolSearch').value = '';
            document.getElementById('schoolRadius').value = '2';
            
            // 버튼 초기화
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            // 원룸은 기본 선택
            var roomTypeButtons = document.querySelectorAll('.filter-row')[2].querySelectorAll('.filter-btn');
            if (roomTypeButtons[0]) roomTypeButtons[0].classList.add('active');
            
            // 슬라이더 초기화
            document.getElementById('depositMin').value = '0';
            document.getElementById('depositMax').value = '5000';
            updateDepositDisplay();
            
            document.getElementById('rentMin').value = '0';
            document.getElementById('rentMax').value = '200';
            updateRentDisplay();
        }

        // 필터 적용
        function applyFilters() {
            // 선택된 필터 수집
            var filters = {
                regions: selectedRegions,
                schools: selectedSchools,
                schoolRadius: document.getElementById('schoolRadius').value,
                depositMin: document.getElementById('depositMin').value,
                depositMax: document.getElementById('depositMax').value,
                rentMin: document.getElementById('rentMin').value,
                rentMax: document.getElementById('rentMax').value,
                propertyTypes: [],
                options: []
            };
            
            document.querySelectorAll('.filter-btn.active').forEach(btn => {
                filters.propertyTypes.push(btn.textContent);
            });
            
            console.log('적용된 필터:', filters);
            alert('필터 적용 중...\n지역: ' + filters.regions.join(', ') + '\n학교: ' + filters.schools.join(', ') + ' (반경 ' + filters.schoolRadius + 'km)');
            
            // 필터 닫기
            toggleFilter();
        }

        // 현재 위치로 이동
        function goToMyLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var lat = position.coords.latitude;
                    var lon = position.coords.longitude;
                    var locPosition = new kakao.maps.LatLng(lat, lon);
                    map.setCenter(locPosition);
                });
            } else {
                alert('GPS를 지원하지 않습니다');
            }
        }

        kakao.maps.event.addListener(map, 'idle', function() {
            console.log('지도 영역 변경됨');
        });

        // 페이지 로드 시 슬라이더 초기화
        window.onload = function() {
            updateDepositDisplay();
            updateRentDisplay();
        };

        // 매물 상세정보 데이터
        var propertyDetails = {
            1: {
                title: '신촌역 5분거리 풀옵션 원룸',
                location: '📍 서울 서대문구 창천동',
                price: '500/55',
                image: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop',
                roomType: '원룸',
                description: '신촌역에서 도보 5분 거리에 위치한 풀옵션 원룸입니다. 연세대, 이화여대 도보 통학 가능하며 주변 편의시설이 우수합니다. 최근 리모델링하여 깔끔한 상태이며, 보일러 개별 난방으로 관리비 부담이 적습니다.',
                options: ['에어컨', '냉장고', '세탁기', '침대', '책상', '인터넷']
            },
            2: {
                title: '연희동 깨끗한 오피스텔',
                location: '📍 서울 서대문구 연희동',
                price: '1000/60',
                image: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=300&fit=crop',
                roomType: '오피스텔',
                description: '2023년 신축 오피스텔입니다. 주차 가능하며 엘리베이터, 택배보관함 등 편의시설이 완비되어 있습니다. 연세대학교 도보 10분 거리이며 조용한 주거환경이 장점입니다.',
                options: ['에어컨', '냉장고', '세탁기', '주차', '엘리베이터', '인터넷']
            },
            3: {
                title: '홍대 캠퍼스 앞 저렴한 원룸',
                location: '📍 서울 마포구 서교동',
                price: '300/45',
                image: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop',
                roomType: '원룸',
                description: '홍익대학교 캠퍼스 바로 앞에 위치한 저렴한 원룸입니다. 학교 통학이 매우 편리하며 홍대입구역도 가까워 교통이 편리합니다. 기본 옵션이 갖춰져 있어 바로 입주 가능합니다.',
                options: ['에어컨', '냉장고', '책상', '인터넷']
            },
            4: {
                title: '이대역 도보 3분 원룸',
                location: '📍 서울 서대문구 대현동',
                price: '700/55',
                image: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400&h=300&fit=crop',
                roomType: '원룸',
                description: '이대역 도보 3분 거리의 역세권 원룸입니다. 풀옵션으로 구비되어 있으며 남향으로 채광이 좋습니다. 이화여대 통학에 최적화된 위치입니다.',
                options: ['에어컨', '냉장고', '세탁기', '침대', '책상', '신발장', '인터넷']
            },
            5: {
                title: '성신여대 도보 5분 투룸',
                location: '📍 서울 성북구 동선동',
                price: '500/65',
                image: 'https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=400&h=300&fit=crop',
                roomType: '투룸',
                description: '성신여대 도보 5분 거리의 투룸입니다. 룸메이트와 함께 거주하기 좋으며 각 방마다 독립적인 공간이 확보됩니다. 단기 계약 가능합니다.',
                options: ['에어컨', '냉장고', '세탁기', '침대', '책상', '인터넷']
            }
        };

        // 상세정보 열기
        function showPropertyDetail(propertyId) {
            var property = propertyDetails[propertyId];
            if (!property) return;

            document.getElementById('detailTitle').textContent = property.title;
            document.getElementById('detailLocation').textContent = property.location;
            document.getElementById('detailPrice').textContent = property.price;
            document.getElementById('detailImage').src = property.image;
            document.getElementById('detailRoomType').textContent = property.roomType;
            document.getElementById('detailDescription').textContent = property.description;

            var optionsHtml = property.options.map(opt =>
                '<span class="detail-option">' + opt + '</span>'
            ).join('');
            document.getElementById('detailOptions').innerHTML = optionsHtml;

            document.getElementById('detailSidebar').classList.add('active');
            document.getElementById('sidebarOverlay').classList.add('active');
        }

        // 상세정보 닫기
        function closePropertyDetail() {
            document.getElementById('detailSidebar').classList.remove('active');
            document.getElementById('sidebarOverlay').classList.remove('active');
        }
        // 전체 상세 페이지로 이동
        function openDetailPage() {
            // 현재 보고 있는 매물 ID 가져오기 (임시로 1번)
            const propertyId = 1; // 나중에 실제 매물 ID로 변경
            // Spring Controller의 @GetMapping("/{id}") 패턴에 맞게 이동
            window.location.href = '${pageContext.request.contextPath}/property/' + propertyId;
        }
    </script>
</body>
</html>