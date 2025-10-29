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
            padding: 10px 18px;
            background: white;
            color: #2d3748;
            border: 2px solid #cbd5e0;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-toggle-btn:hover {
            background: #f7fafc;
            border-color: #a0aec0;
        }

        .filter-toggle-btn.active {
            background: #f7fafc;
            border-color: #4a5568;
        }

        .filter-toggle-btn .arrow {
            transition: transform 0.3s;
            font-size: 12px;
            color: #718096;
        }

        .filter-toggle-btn.active .arrow {
            transform: rotate(180deg);
        }

        /* 매물 검색창 */
        .property-search-box {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .property-search-box input {
            border: none;
            border-bottom: 2px solid #e2e8f0;
            outline: none;
            font-size: 14px;
            width: 200px;
            padding: 8px 4px;
            color: #2d3748;
            background: transparent;
            transition: border-color 0.2s;
        }

        .property-search-box input:focus {
            border-bottom-color: #667eea;
        }

        .property-search-box input::placeholder {
            color: #a0aec0;
        }

        .property-search-icon {
            color: #718096;
            font-size: 14px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .property-search-icon:hover {
            color: #667eea;
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
                <div class="property-search-box">
                    <i class="fa-solid fa-search property-search-icon" onclick="searchPropertyByName()"></i>
                    <input type="text" id="propertyNameSearch" placeholder="매물 이름 검색" onkeypress="if(event.key === 'Enter') searchPropertyByName()">
                </div>
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
                    <button class="filter-btn" onclick="toggleFilterBtn(this)">원룸</button>
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
                <h2>매물 <span class="count" id="sidebarCount">0</span>개</h2>
                <select class="sort-select">
                    <option>추천순</option>
                    <option>최신순</option>
                    <option>가격낮은순</option>
                    <option>가격높은순</option>
                </select>
            </div>

            <div class="property-list-content" id="propertyListContent">
                <!-- 매물 목록이 JavaScript로 동적 생성됩니다 -->
            </div>
        </div>

        <div class="map-container">
            <div id="map"></div>
            
            <div class="property-counter">
                현재 지도에 <span id="propertyCount"><c:out value="${properties.size()}" default="0"/></span>개 매물
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
                <div class="detail-price" id="detailPrice"></div>
                <div class="detail-title" id="detailTitle"></div>
                <div class="detail-location" id="detailLocation"></div>

                <div class="detail-section">
                    <h3>기본 정보</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-item-label">방 종류</span>
                            <span class="detail-item-value" id="detailRoomType"></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-item-label">전용면적</span>
                            <span class="detail-item-value" id="detailArea"></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-item-label">층수</span>
                            <span class="detail-item-value" id="detailFloor"></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-item-label">관리비</span>
                            <span class="detail-item-value" id="detailMaintenanceFee"></span>
                        </div>
                    </div>
                </div>

                <div class="detail-section">
                    <h3>옵션</h3>
                    <div class="detail-options" id="detailOptions">
                    </div>
                </div>

                <div class="detail-section">
                    <h3>상세 설명</h3>
                    <div class="detail-description" id="detailDescription">
                    </div>
                </div>
                
                <div class="detail-report-section">
					<button class="btn-report" onclick="checkLoginAndGoToReport()">
						<i class="fa-solid fa-flag"></i> 허위매물 신고하기
					</button>
				</div>
                
            </div>
        </div>
		<div class="detail-actions">
            <button class="btn-favorite" id="btnFavorite" onclick="toggleWishlist()">♡ 찜하기</button>
            <button class="btn-contact" onclick="checkLoginAndGoToContact()">중개사 문의하기</button>
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

        // 실제 DB 데이터 (서버에서 전달)
        var properties = [
            <c:forEach items="${properties}" var="property" varStatus="status">
            {
                id: ${property.propertyNo},
                lat: ${property.latitude != null ? property.latitude : 37.5592},
                lng: ${property.longitude != null ? property.longitude : 126.9425},
                title: '${property.propertyName}',
                price: '${property.deposit}/${property.monthlyRent}',
                propertyType: '${property.propertyType}',
                district: '${property.district}',
                roadAddress: '${property.roadAddress}',
                thumbnailPath: '${not empty property.thumbnailPath ? property.thumbnailPath : ""}',
                studentPref: '${property.studentPref}',
                shortCont: '${property.shortCont}',
                contractArea: ${property.contractArea != null ? property.contractArea : 0},
                floor: ${property.floor != null ? property.floor : 0},
                maintenanceFee: ${property.maintenanceFee != null ? property.maintenanceFee : 0},
                options: {
                    airConditioner: '${property.propertyOption != null ? property.propertyOption.airConditioner : "N"}',
                    heater: '${property.propertyOption != null ? property.propertyOption.heater : "N"}',
                    refrigerator: '${property.propertyOption != null ? property.propertyOption.refrigerator : "N"}',
                    microwave: '${property.propertyOption != null ? property.propertyOption.microwave : "N"}',
                    induction: '${property.propertyOption != null ? property.propertyOption.induction : "N"}',
                    gasStove: '${property.propertyOption != null ? property.propertyOption.gasStove : "N"}',
                    washer: '${property.propertyOption != null ? property.propertyOption.washer : "N"}',
                    dryer: '${property.propertyOption != null ? property.propertyOption.dryer : "N"}',
                    bed: '${property.propertyOption != null ? property.propertyOption.bed : "N"}',
                    desk: '${property.propertyOption != null ? property.propertyOption.desk : "N"}',
                    wardrobe: '${property.propertyOption != null ? property.propertyOption.wardrobe : "N"}',
                    shoeRack: '${property.propertyOption != null ? property.propertyOption.shoeRack : "N"}',
                    tv: '${property.propertyOption != null ? property.propertyOption.tv : "N"}',
                    parking: '${property.propertyOption != null ? property.propertyOption.parking : "N"}',
                    elevator: '${property.propertyOption != null ? property.propertyOption.elevator : "N"}',
                    security: '${property.propertyOption != null ? property.propertyOption.security : "N"}',
                    petAllowed: '${property.propertyOption != null ? property.propertyOption.petAllowed : "N"}'
                }
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        var overlays = []; // 오버레이 저장용
        var currentPropertyId = null; // ★ 1. 현재 선택된 매물 ID를 저장할 변수

        // 같은 좌표의 마커를 흩뿌리기 위한 함수
        function addJitter(properties) {
            var coordMap = {}; // 좌표별 카운트

            return properties.map(function(prop) {
                var key = prop.lat.toFixed(4) + '_' + prop.lng.toFixed(4);

                if (!coordMap[key]) {
                    coordMap[key] = 0;
                } else {
                    coordMap[key]++;
                }

                // 같은 좌표가 있으면 약간씩 오프셋 추가 (약 10-30미터 정도)
                var offsetLat = (coordMap[key] % 3 - 1) * 0.0001; // 약 11m
                var offsetLng = (Math.floor(coordMap[key] / 3) % 3 - 1) * 0.0001;

                return {
                    id: prop.id,
                    lat: prop.lat + offsetLat,
                    lng: prop.lng + offsetLng,
                    title: prop.title,
                    price: prop.price,
                    propertyType: prop.propertyType,
                    district: prop.district,
                    roadAddress: prop.roadAddress,
                    thumbnailPath: prop.thumbnailPath,
                    studentPref: prop.studentPref,
                    shortCont: prop.shortCont,
                    options: prop.options
                };
            });
        }

        // 좌표 오프셋 적용
        var adjustedProperties = addJitter(properties);

        // 마커 표시 (커스텀 오버레이만 사용)
        adjustedProperties.forEach(function(property) {
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
        var regions = ['강남구', '서초구', '송파구', '강동구', '마포구', '서대문구', '종로구', '성북구', '강서구', '양천구', '영등포구', '동작구', '관악구', '구로구', '금천구', '광진구', '성동구', '중랑구', '동대문구', '노원구', '도봉구', '은평구', '용산구', '중구'];

        // 학교 좌표 데이터 (학교명: {위도, 경도})
        var schoolCoordinates = {
            '연세대학교': { lat: 37.5665, lng: 126.9387 },
            '고려대학교': { lat: 37.5906, lng: 127.0267 },
            '서울대학교': { lat: 37.4601, lng: 126.9520 },
            '홍익대학교': { lat: 37.5509, lng: 126.9227 },
            '성균관대학교': { lat: 37.5943, lng: 126.9895 },
            '이화여자대학교': { lat: 37.5616, lng: 126.9468 },
            '한양대학교': { lat: 37.5559, lng: 127.0448 },
            '건국대학교': { lat: 37.5412, lng: 127.0786 },
            '동국대학교': { lat: 37.5582, lng: 126.9989 },
            '중앙대학교': { lat: 37.5040, lng: 126.9570 },
            '경희대학교': { lat: 37.5971, lng: 127.0519 },
            '서울시립대학교': { lat: 37.5838, lng: 127.0581 },
            '숙명여자대학교': { lat: 37.5450, lng: 126.9654 },
            '성신여자대학교': { lat: 37.5927, lng: 127.0187 },
            '국민대학교': { lat: 37.6108, lng: 126.9958 }
        };

        var schools = Object.keys(schoolCoordinates);

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
                           ' onclick="toggleRegion(\'' + region + '\', event)">' + region + '</div>';
                }).join('');
                dropdown.innerHTML = html;
            }
        }

        // 지역 선택/해제
        function toggleRegion(region, event) {
            if (event) {
                event.stopPropagation(); // 이벤트 버블링 방지
            }
            if (selectedRegions.includes(region)) {
                selectedRegions = selectedRegions.filter(r => r !== region);
            } else {
                selectedRegions.push(region);
            }
            updateSelectedRegions();
            filterRegions();

            // 드롭다운 닫기
            document.getElementById('regionDropdown').classList.remove('active');
        }

        // 선택된 지역 표시
        function updateSelectedRegions() {
            var container = document.getElementById('selectedRegions');
            container.innerHTML = selectedRegions.map(function(region) {
                return '<div class="tag">' + region + ' <span class="remove" onclick="toggleRegion(\'' + region + '\', event)">×</span></div>';
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
                           ' onclick="toggleSchool(\'' + school + '\', event)">' + school + '</div>';
                }).join('');
                dropdown.innerHTML = html;
            }
        }

        // 학교 선택/해제
        function toggleSchool(school, event) {
            if (event) {
                event.stopPropagation(); // 이벤트 버블링 방지
            }
            if (selectedSchools.includes(school)) {
                selectedSchools = selectedSchools.filter(s => s !== school);
            } else {
                selectedSchools.push(school);
            }
            updateSelectedSchools();
            filterSchools();

            // 드롭다운 닫기
            document.getElementById('schoolDropdown').classList.remove('active');
        }

        // 선택된 학교 표시
        function updateSelectedSchools() {
            var container = document.getElementById('selectedSchools');
            container.innerHTML = selectedSchools.map(function(school) {
                return '<div class="tag">' + school + ' <span class="remove" onclick="toggleSchool(\'' + school + '\', event)">×</span></div>';
            }).join('');
        }

        // 드롭다운 외부 클릭 시 닫기
        document.addEventListener('click', function(e) {
            // 드롭다운은 외부 클릭 시에만 닫고, 내부 클릭 시엔 유지
            if (!e.target.closest('.search-dropdown')) {
                document.getElementById('regionDropdown').classList.remove('active');
                document.getElementById('schoolDropdown').classList.remove('active');
            }

            // 필터 외부 클릭 시 닫기 (단, 드롭다운 클릭은 제외)
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

        // 매물 이름 검색
        function searchPropertyByName() {
            const searchInput = document.getElementById('propertyNameSearch');
            const searchText = searchInput.value.toLowerCase().trim();

            if (searchText === '') {
                alert('검색어를 입력해주세요.');
                return;
            }

            // 검색어에 맞는 매물 필터링
            const matchedProperties = properties.filter(property => {
                const propertyName = property.title ? property.title.toLowerCase() : '';
                return propertyName.includes(searchText);
            });

            if (matchedProperties.length === 0) {
                alert('검색 결과가 없습니다.');
                return;
            }

            // 사이드바에 검색된 매물만 표시
            renderPropertyList(matchedProperties);

            // 첫 번째 매물 위치로 지도 이동
            const firstProperty = matchedProperties[0];
            const moveLatLng = new kakao.maps.LatLng(firstProperty.lat, firstProperty.lng);
            map.setCenter(moveLatLng);
            map.setLevel(5); // 적당한 줌 레벨로 설정

            // 검색 결과 알림
            alert(matchedProperties.length + '개의 매물을 찾았습니다.');
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

            // 모든 버튼 초기화 (원룸도 체크 해제)
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });

            // 슬라이더 초기화
            document.getElementById('depositMin').value = '0';
            document.getElementById('depositMax').value = '5000';
            updateDepositDisplay();

            document.getElementById('rentMin').value = '0';
            document.getElementById('rentMax').value = '200';
            updateRentDisplay();
        }

        // 매물 유형 매핑 (화면 텍스트 -> DB 값)
        var propertyTypeMapping = {
            '원룸': 'oneRoom',
            '투룸': 'twoRoom',
            '쓰리룸': 'threeRoom',
            '오피스텔': 'officetel'
        };

        // 필터 적용
        function applyFilters() {
            // 선택된 필터 수집
            var propertyTypes = [];
            var filterButtons = document.querySelectorAll('.filter-row')[2].querySelectorAll('.filter-btn');
            filterButtons.forEach(btn => {
                if (btn.classList.contains('active')) {
                    var displayText = btn.textContent.trim();
                    // DB에 저장된 값으로 변환
                    var dbValue = propertyTypeMapping[displayText] || displayText;
                    propertyTypes.push(dbValue);
                }
            });

            // 학생 특화 필터
            var studentPrefButtons = document.querySelectorAll('.filter-row')[3].querySelectorAll('.filter-btn');
            var studentPref = studentPrefButtons[0] && studentPrefButtons[0].classList.contains('active') ? true : null;
            var shortCont = studentPrefButtons[1] && studentPrefButtons[1].classList.contains('active') ? true : null;

            // 옵션 필터
            var optionButtons = {
                airConditioner: null,
                heater: null,
                refrigerator: null,
                microwave: null,
                induction: null,
                gasStove: null,
                washer: null,
                dryer: null,
                bed: null,
                desk: null,
                wardrobe: null,
                shoeRack: null,
                tv: null,
                parking: null,
                elevator: null,
                security: null,
                petAllowed: null
            };

            // 냉난방
            var coolingHeatingButtons = document.querySelectorAll('.filter-row')[4].querySelectorAll('.filter-btn');
            if (coolingHeatingButtons[0]) {
                optionButtons.airConditioner = coolingHeatingButtons[0].classList.contains('active') ? true : null;
            }
            if (coolingHeatingButtons[1]) {
                optionButtons.heater = coolingHeatingButtons[1].classList.contains('active') ? true : null;
            }

            // 주방
            var kitchenButtons = document.querySelectorAll('.filter-row')[5].querySelectorAll('.filter-btn');
            if (kitchenButtons[0]) {
                optionButtons.refrigerator = kitchenButtons[0].classList.contains('active') ? true : null;
            }
            if (kitchenButtons[1]) {
                optionButtons.microwave = kitchenButtons[1].classList.contains('active') ? true : null;
            }
            if (kitchenButtons[2]) {
                optionButtons.induction = kitchenButtons[2].classList.contains('active') ? true : null;
            }
            if (kitchenButtons[3]) {
                optionButtons.gasStove = kitchenButtons[3].classList.contains('active') ? true : null;
            }

            // 가구/가전
            var furnitureButtons = document.querySelectorAll('.filter-row')[6].querySelectorAll('.filter-btn');
            if (furnitureButtons[0]) {
                optionButtons.washer = furnitureButtons[0].classList.contains('active') ? true : null;
            }
            if (furnitureButtons[1]) {
                optionButtons.dryer = furnitureButtons[1].classList.contains('active') ? true : null;
            }
            if (furnitureButtons[2]) {
                optionButtons.bed = furnitureButtons[2].classList.contains('active') ? true : null;
            }
            if (furnitureButtons[3]) {
                optionButtons.desk = furnitureButtons[3].classList.contains('active') ? true : null;
            }
            if (furnitureButtons[4]) {
                optionButtons.wardrobe = furnitureButtons[4].classList.contains('active') ? true : null;
            }
            if (furnitureButtons[5]) {
                optionButtons.shoeRack = furnitureButtons[5].classList.contains('active') ? true : null;
            }
            if (furnitureButtons[6]) {
                optionButtons.tv = furnitureButtons[6].classList.contains('active') ? true : null;
            }

            // 시설
            var facilityButtons = document.querySelectorAll('.filter-row')[7].querySelectorAll('.filter-btn');
            if (facilityButtons[0]) {
                optionButtons.parking = facilityButtons[0].classList.contains('active') ? true : null;
            }
            if (facilityButtons[1]) {
                optionButtons.elevator = facilityButtons[1].classList.contains('active') ? true : null;
            }
            if (facilityButtons[2]) {
                optionButtons.security = facilityButtons[2].classList.contains('active') ? true : null;
            }
            if (facilityButtons[3]) {
                optionButtons.petAllowed = facilityButtons[3].classList.contains('active') ? true : null;
            }

            // 보증금/월세 값 가져오기
            var depositMin = parseInt(document.getElementById('depositMin').value);
            var depositMax = parseInt(document.getElementById('depositMax').value);
            var rentMin = parseInt(document.getElementById('rentMin').value);
            var rentMax = parseInt(document.getElementById('rentMax').value);

            // 필터 요청 객체 생성 (null 값 제외)
            var filterRequest = {};

            // 지역 필터
            if (selectedRegions.length > 0) {
                filterRequest.regions = selectedRegions;
            }

            // 학교 필터 (학교 좌표 포함)
            if (selectedSchools.length > 0) {
                filterRequest.schoolLocations = selectedSchools.map(school => ({
                    name: school,
                    latitude: schoolCoordinates[school].lat,
                    longitude: schoolCoordinates[school].lng
                }));
                filterRequest.schoolRadius = parseFloat(document.getElementById('schoolRadius').value);
            }

            // 보증금 필터 (기본값이 아닐 때만)
            if (depositMin !== 0 || depositMax !== 5000) {
                filterRequest.depositMin = depositMin;
                filterRequest.depositMax = depositMax;
            }

            // 월세 필터 (기본값이 아닐 때만)
            if (rentMin !== 0 || rentMax !== 200) {
                filterRequest.rentMin = rentMin;
                filterRequest.rentMax = rentMax;
            }

            // 매물 유형 필터
            if (propertyTypes.length > 0) {
                filterRequest.propertyTypes = propertyTypes;
            }

            // 학생 특화 필터
            if (studentPref === true) {
                filterRequest.studentPref = true;
            }
            if (shortCont === true) {
                filterRequest.shortCont = true;
            }

            // 옵션 필터 (true인 것만 포함)
            if (optionButtons.airConditioner === true) filterRequest.airConditioner = true;
            if (optionButtons.heater === true) filterRequest.heater = true;
            if (optionButtons.refrigerator === true) filterRequest.refrigerator = true;
            if (optionButtons.microwave === true) filterRequest.microwave = true;
            if (optionButtons.induction === true) filterRequest.induction = true;
            if (optionButtons.gasStove === true) filterRequest.gasStove = true;
            if (optionButtons.washer === true) filterRequest.washer = true;
            if (optionButtons.dryer === true) filterRequest.dryer = true;
            if (optionButtons.bed === true) filterRequest.bed = true;
            if (optionButtons.desk === true) filterRequest.desk = true;
            if (optionButtons.wardrobe === true) filterRequest.wardrobe = true;
            if (optionButtons.shoeRack === true) filterRequest.shoeRack = true;
            if (optionButtons.tv === true) filterRequest.tv = true;
            if (optionButtons.parking === true) filterRequest.parking = true;
            if (optionButtons.elevator === true) filterRequest.elevator = true;
            if (optionButtons.security === true) filterRequest.security = true;
            if (optionButtons.petAllowed === true) filterRequest.petAllowed = true;

            console.log('적용된 필터:', filterRequest);

			// AJAX 요청으로 필터링된 매물 조회
            fetch('${pageContext.request.contextPath}/api/properties/filter', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(filterRequest)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('필터링된 매물:', data.properties);

                    // 기존 마커 제거
                    overlays.forEach(overlay => overlay.setMap(null));
                    overlays = [];

                    // properties 배열 업데이트
                    properties = data.properties.map(property => ({
                        id: property.propertyNo,
                        lat: property.latitude || 37.5592,
                        lng: property.longitude || 126.9425,
                        title: property.propertyName,
                        price: property.deposit + '/' + property.monthlyRent,
                        propertyType: property.propertyType,
                        district: property.district,
                        roadAddress: property.roadAddress,
                        thumbnailPath: property.thumbnailPath || '',
                        studentPref: property.studentPref,
                        shortCont: property.shortCont,
                        options: property.propertyOption ? {
                            airConditioner: property.propertyOption.airConditioner || 'N',
                            heater: property.propertyOption.heater || 'N',
                            refrigerator: property.propertyOption.refrigerator || 'N',
                            microwave: property.propertyOption.microwave || 'N',
                            induction: property.propertyOption.induction || 'N',
                            gasStove: property.propertyOption.gasStove || 'N',
                            washer: property.propertyOption.washer || 'N',
                            dryer: property.propertyOption.dryer || 'N',
                            bed: property.propertyOption.bed || 'N',
                            desk: property.propertyOption.desk || 'N',
                            wardrobe: property.propertyOption.wardrobe || 'N',
                            shoeRack: property.propertyOption.shoeRack || 'N',
                            tv: property.propertyOption.tv || 'N',
                            parking: property.propertyOption.parking || 'N',
                            elevator: property.propertyOption.elevator || 'N',
                            security: property.propertyOption.security || 'N',
                            petAllowed: property.propertyOption.petAllowed || 'N'
                        } : {}
                    }));

                    // 좌표 오프셋 적용
                    adjustedProperties = addJitter(properties);

                    // propertyDetails 업데이트
                    propertyDetails = {};
                    properties.forEach(function(prop) {
                        var imagePath;
                        if (prop.thumbnailPath && prop.thumbnailPath.trim() !== '') {
                            if (prop.thumbnailPath.startsWith('/')) {
                                imagePath = '${pageContext.request.contextPath}' + prop.thumbnailPath;
                            } else if (prop.thumbnailPath.startsWith('images/')) {
                                imagePath = '${pageContext.request.contextPath}/' + prop.thumbnailPath;
                            } else if (prop.thumbnailPath.indexOf('/') === -1) {
                                imagePath = '${pageContext.request.contextPath}/images/property/' + prop.thumbnailPath;
                            } else {
                                imagePath = 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';
                            }
                        } else {
                            imagePath = 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';
                        }

                        var optionList = [];
                        if (prop.options) {
                            for (var key in prop.options) {
                                if (prop.options[key] === 'Y') {
                                    optionList.push(optionNameMap[key] || key);
                                }
                            }
                        }

                        if (optionList.length === 0) {
                            optionList = ['등록된 옵션이 없습니다'];
                        }

                        propertyDetails[prop.id] = {
                            title: prop.title,
                            location: '📍 ' + prop.roadAddress,
                            price: prop.price,
                            image: imagePath,
                            roomType: prop.propertyType,
                            description: '상세 설명은 전체 상세보기에서 확인하실 수 있습니다.',
                            options: optionList,
                            area: prop.contractArea ? prop.contractArea + '㎡ (약 ' + Math.round(prop.contractArea / 3.3) + '평)' : '정보 없음',
                            floor: prop.floor ? prop.floor + '층' : '정보 없음',
                            maintenanceFee: prop.maintenanceFee ? prop.maintenanceFee + '만원' : '정보 없음'
                        };
                    });

                    // 새 마커 표시
                    adjustedProperties.forEach(function(property) {
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

                    // 지도 영역 내 매물 업데이트
                    updateVisibleProperties();

                    // 검색된 매물이 있으면 해당 위치로 지도 이동
                    if (adjustedProperties.length > 0) {
                        moveMapToProperties(adjustedProperties);
                    }

                    alert('필터가 적용되었습니다. ' + data.count + '개의 매물이 검색되었습니다.');
                } else {
                    alert('매물 조회 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('매물 조회 중 오류가 발생했습니다.');
            });

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

        // 현재 지도 영역 내의 매물 필터링
        function getPropertiesInBounds() {
            var bounds = map.getBounds();
            var swLatLng = bounds.getSouthWest();
            var neLatLng = bounds.getNorthEast();

            return adjustedProperties.filter(function(property) {
                return property.lat >= swLatLng.getLat() &&
                       property.lat <= neLatLng.getLat() &&
                       property.lng >= swLatLng.getLng() &&
                       property.lng <= neLatLng.getLng();
            });
        }

        // 사이드바 매물 리스트 렌더링
        function renderPropertyList(propertiesToShow) {
            var listContainer = document.getElementById('propertyListContent');
            var countElement = document.getElementById('sidebarCount');

            // 매물 개수 업데이트
            countElement.textContent = propertiesToShow.length;
            document.getElementById('propertyCount').textContent = propertiesToShow.length;

            // 매물 카드 HTML 생성
            var html = '';
            propertiesToShow.forEach(function(property) {
                var imagePath = property.thumbnailPath && property.thumbnailPath.trim() !== ''
                    ? '${pageContext.request.contextPath}' + property.thumbnailPath
                    : 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';

                var studentPref = property.studentPref === 'Y';
                var shortCont = property.shortCont === 'Y';

                html += '<div class="property-card" onclick="showPropertyDetail(' + property.id + ')">';
                html += '  <div class="card-image">';
                html += '    <img src="' + imagePath + '" alt="' + property.propertyType + '" ';
                html += '         onerror="this.src=\'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop\'">';
                if (studentPref) {
                    html += '    <span class="card-badge">학생 우대</span>';
                }
                html += '  </div>';
                html += '  <div class="card-content">';
                html += '    <div class="card-title">' + property.title + '</div>';
                html += '    <div class="card-location">📍 ' + property.district + '</div>';
                html += '    <div class="card-price">' + property.price + '</div>';
                html += '    <div class="card-tags">';
                html += '      <span>' + property.propertyType + '</span>';
                if (shortCont) {
                    html += '      <span>단기가능</span>';
                }
                html += '    </div>';
                html += '  </div>';
                html += '</div>';
            });

            listContainer.innerHTML = html;
        }

        // 지도 영역이 변경될 때마다 매물 리스트 업데이트
        function updateVisibleProperties() {
            var visibleProperties = getPropertiesInBounds();
            renderPropertyList(visibleProperties);
        }

        // 지도 이동/확대 이벤트 리스너
        kakao.maps.event.addListener(map, 'idle', function() {
            updateVisibleProperties();
        });

        // 매물 위치로 지도 이동
        function moveMapToProperties(propertiesToShow) {
            if (!propertiesToShow || propertiesToShow.length === 0) {
                return;
            }

            // 매물이 1개인 경우 해당 위치로 이동
            if (propertiesToShow.length === 1) {
                var center = new kakao.maps.LatLng(propertiesToShow[0].lat, propertiesToShow[0].lng);
                map.setCenter(center);
                map.setLevel(3); // 줌 레벨 3으로 설정 (가까이 보기)
                return;
            }

            // 매물이 여러 개인 경우 중심점 계산
            var bounds = new kakao.maps.LatLngBounds();

            propertiesToShow.forEach(function(property) {
                var position = new kakao.maps.LatLng(property.lat, property.lng);
                bounds.extend(position);
            });

            // 모든 매물이 보이도록 지도 영역 설정
            map.setBounds(bounds);

            // 너무 가까워지는 것 방지 (최소 줌 레벨 설정)
            setTimeout(function() {
                if (map.getLevel() < 3) {
                    map.setLevel(3);
                }
            }, 100);
        }

        // 페이지 로드 시 슬라이더 초기화 및 초기 매물 리스트 렌더링
        window.onload = function() {
            updateDepositDisplay();
            updateRentDisplay();
            updateVisibleProperties(); // 초기 매물 리스트 표시

            // AI 검색 결과 자동 적용
            checkAiSearchResult();
        };

        // AI 검색 결과 확인 및 자동 적용
        function checkAiSearchResult() {
            const urlParams = new URLSearchParams(window.location.search);
            const isAiSearch = urlParams.get('ai');

            if (isAiSearch === 'true') {
                const filterJson = sessionStorage.getItem('aiSearchFilter');
                const query = sessionStorage.getItem('aiSearchQuery');

                if (filterJson) {
                    try {
                        const filter = JSON.parse(filterJson);
                        console.log('AI 검색 필터 자동 적용:', filter);

                        // 조건보기 UI에 필터 반영
                        applyFilterToUI(filter);

                        // 알림 표시
                        if (query) {
                            alert('AI 검색: "' + query + '"\n조건이 자동으로 적용되었습니다.');
                        }

                        // 필터 적용 (AJAX 호출)
                        applyAiFilter(filter);

                        // 세션 스토리지 클리어
                        sessionStorage.removeItem('aiSearchFilter');
                        sessionStorage.removeItem('aiSearchQuery');

                    } catch (e) {
                        console.error('AI 검색 결과 적용 실패:', e);
                    }
                }
            }
        }

        // AI 필터를 UI에 반영
        function applyFilterToUI(filter) {
            // 지역 필터 반영
            if (filter.regions && filter.regions.length > 0) {
                selectedRegions = filter.regions;
                updateSelectedRegions();
            }

            // 학교 필터 반영
            if (filter.schoolLocations && filter.schoolLocations.length > 0) {
                selectedSchools = filter.schoolLocations.map(s => s.name);
                updateSelectedSchools();

                // 학교 반경 설정
                if (filter.schoolRadius) {
                    document.getElementById('schoolRadius').value = filter.schoolRadius;
                }
            }

            // 보증금 필터 반영
            if (filter.depositMin !== null && filter.depositMin !== undefined) {
                document.getElementById('depositMin').value = filter.depositMin;
            }
            if (filter.depositMax !== null && filter.depositMax !== undefined) {
                document.getElementById('depositMax').value = filter.depositMax;
            }
            updateDepositDisplay();

            // 월세 필터 반영
            if (filter.rentMin !== null && filter.rentMin !== undefined) {
                document.getElementById('rentMin').value = filter.rentMin;
            }
            if (filter.rentMax !== null && filter.rentMax !== undefined) {
                document.getElementById('rentMax').value = filter.rentMax;
            }
            updateRentDisplay();

            // 매물 유형 필터 반영
            if (filter.propertyTypes && filter.propertyTypes.length > 0) {
                var propertyTypeButtons = document.querySelectorAll('.filter-row')[2].querySelectorAll('.filter-btn');
                var typeMapping = {
                    'oneRoom': 0,
                    'twoRoom': 1,
                    'threeRoom': 2,
                    'officetel': 3
                };

                filter.propertyTypes.forEach(function(type) {
                    var index = typeMapping[type];
                    if (index !== undefined && propertyTypeButtons[index]) {
                        propertyTypeButtons[index].classList.add('active');
                    }
                });
            }

            // 학생 특화 필터 반영
            var studentPrefButtons = document.querySelectorAll('.filter-row')[3].querySelectorAll('.filter-btn');
            if (filter.studentPref === true && studentPrefButtons[0]) {
                studentPrefButtons[0].classList.add('active');
            }
            if (filter.shortCont === true && studentPrefButtons[1]) {
                studentPrefButtons[1].classList.add('active');
            }

            // 옵션 필터 반영
            var optionMapping = {
                airConditioner: [4, 0],  // [filter-row 인덱스, 버튼 인덱스]
                heater: [4, 1],
                refrigerator: [5, 0],
                microwave: [5, 1],
                induction: [5, 2],
                gasStove: [5, 3],
                washer: [6, 0],
                dryer: [6, 1],
                bed: [6, 2],
                desk: [6, 3],
                wardrobe: [6, 4],
                shoeRack: [6, 5],
                tv: [6, 6],
                parking: [7, 0],
                elevator: [7, 1],
                security: [7, 2],
                petAllowed: [7, 3]
            };

            for (var optionKey in optionMapping) {
                if (filter[optionKey] === true) {
                    var mapping = optionMapping[optionKey];
                    var rowIndex = mapping[0];
                    var btnIndex = mapping[1];
                    var filterRows = document.querySelectorAll('.filter-row');

                    if (filterRows[rowIndex]) {
                        var buttons = filterRows[rowIndex].querySelectorAll('.filter-btn');
                        if (buttons[btnIndex]) {
                            buttons[btnIndex].classList.add('active');
                        }
                    }
                }
            }
        }

        // AI 필터 적용
        function applyAiFilter(filterRequest) {
            fetch('${pageContext.request.contextPath}/api/properties/filter', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(filterRequest)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('AI 필터링된 매물:', data.properties);

                    // 기존 마커 제거
                    overlays.forEach(overlay => overlay.setMap(null));
                    overlays = [];

                    // properties 배열 업데이트
                    properties = data.properties.map(property => ({
                        id: property.propertyNo,
                        lat: property.latitude || 37.5592,
                        lng: property.longitude || 126.9425,
                        title: property.propertyName,
                        price: property.deposit + '/' + property.monthlyRent,
                        propertyType: property.propertyType,
                        district: property.district,
                        roadAddress: property.roadAddress,
                        thumbnailPath: property.thumbnailPath || '',
                        studentPref: property.studentPref,
                        shortCont: property.shortCont,
                        options: property.propertyOption ? {
                            airConditioner: property.propertyOption.airConditioner || 'N',
                            heater: property.propertyOption.heater || 'N',
                            refrigerator: property.propertyOption.refrigerator || 'N',
                            microwave: property.propertyOption.microwave || 'N',
                            induction: property.propertyOption.induction || 'N',
                            gasStove: property.propertyOption.gasStove || 'N',
                            washer: property.propertyOption.washer || 'N',
                            dryer: property.propertyOption.dryer || 'N',
                            bed: property.propertyOption.bed || 'N',
                            desk: property.propertyOption.desk || 'N',
                            wardrobe: property.propertyOption.wardrobe || 'N',
                            shoeRack: property.propertyOption.shoeRack || 'N',
                            tv: property.propertyOption.tv || 'N',
                            parking: property.propertyOption.parking || 'N',
                            elevator: property.propertyOption.elevator || 'N',
                            security: property.propertyOption.security || 'N',
                            petAllowed: property.propertyOption.petAllowed || 'N'
                        } : {}
                    }));

                    // 좌표 오프셋 적용
                    adjustedProperties = addJitter(properties);

                    // propertyDetails 업데이트
                    propertyDetails = {};
                    properties.forEach(function(prop) {
                        var imagePath;
                        if (prop.thumbnailPath && prop.thumbnailPath.trim() !== '') {
                            if (prop.thumbnailPath.startsWith('/')) {
                                imagePath = '${pageContext.request.contextPath}' + prop.thumbnailPath;
                            } else if (prop.thumbnailPath.startsWith('images/')) {
                                imagePath = '${pageContext.request.contextPath}/' + prop.thumbnailPath;
                            } else if (prop.thumbnailPath.indexOf('/') === -1) {
                                imagePath = '${pageContext.request.contextPath}/images/property/' + prop.thumbnailPath;
                            } else {
                                imagePath = 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';
                            }
                        } else {
                            imagePath = 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';
                        }

                        var optionList = [];
                        if (prop.options) {
                            for (var key in prop.options) {
                                if (prop.options[key] === 'Y') {
                                    optionList.push(optionNameMap[key] || key);
                                }
                            }
                        }

                        if (optionList.length === 0) {
                            optionList = ['등록된 옵션이 없습니다'];
                        }

                        propertyDetails[prop.id] = {
                            title: prop.title,
                            location: '📍 ' + prop.roadAddress,
                            price: prop.price,
                            image: imagePath,
                            roomType: prop.propertyType,
                            description: '상세 설명은 전체 상세보기에서 확인하실 수 있습니다.',
                            options: optionList,
                            area: prop.contractArea ? prop.contractArea + '㎡ (약 ' + Math.round(prop.contractArea / 3.3) + '평)' : '정보 없음',
                            floor: prop.floor ? prop.floor + '층' : '정보 없음',
                            maintenanceFee: prop.maintenanceFee ? prop.maintenanceFee + '만원' : '정보 없음'
                        };
                    });

                    // 새 마커 표시
                    adjustedProperties.forEach(function(property) {
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

                    // 지도 영역 내 매물 업데이트
                    updateVisibleProperties();

                    // 검색된 매물이 있으면 해당 위치로 지도 이동
                    if (adjustedProperties.length > 0) {
                        moveMapToProperties(adjustedProperties);
                    }

                } else {
                    alert('AI 검색 결과 적용 실패: ' + (data.message || ''));
                }
            })
            .catch(error => {
                console.error('AI 검색 결과 적용 오류:', error);
            });
        }

        // 옵션 이름 매핑
        var optionNameMap = {
            airConditioner: '에어컨',
            heater: '히터',
            refrigerator: '냉장고',
            microwave: '전자레인지',
            induction: '인덕션',
            gasStove: '가스레인지',
            washer: '세탁기',
            dryer: '건조기',
            bed: '침대',
            desk: '책상',
            wardrobe: '옷장',
            shoeRack: '신발장',
            tv: 'TV',
            parking: '주차가능',
            elevator: '엘리베이터',
            security: '보안시스템',
            petAllowed: '반려동물'
        };

        // 매물 상세정보 데이터 (properties를 기반으로 동적 생성)
        var propertyDetails = {};
        properties.forEach(function(prop) {
            var imagePath;
            if (prop.thumbnailPath && prop.thumbnailPath.trim() !== '') {
                // thumbnailPath가 '/'로 시작하면 contextPath 추가, 아니면 기본 이미지
                if (prop.thumbnailPath.startsWith('/')) {
                    imagePath = '${pageContext.request.contextPath}' + prop.thumbnailPath;
                } else if (prop.thumbnailPath.startsWith('images/')) {
                    // 'images/property/...' 형태면 앞에 '/' 추가
                    imagePath = '${pageContext.request.contextPath}/' + prop.thumbnailPath;
                } else if (prop.thumbnailPath.indexOf('/') === -1) {
                    // 파일명만 있는 경우 전체 경로 구성
                    imagePath = '${pageContext.request.contextPath}/images/property/' + prop.thumbnailPath;
                } else {
                    // 기타 예외 상황
                    imagePath = 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';
                }
            } else {
                imagePath = 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop';
            }

            // 실제 옵션 데이터 추출 (Y인 것만)
            var optionList = [];
            if (prop.options) {
                for (var key in prop.options) {
                    if (prop.options[key] === 'Y') {
                        optionList.push(optionNameMap[key] || key);
                    }
                }
            }

            // 옵션이 없으면 기본 메시지
            if (optionList.length === 0) {
                optionList = ['등록된 옵션이 없습니다'];
            }

            propertyDetails[prop.id] = {
                title: prop.title,
                location: '📍 ' + prop.roadAddress,
                price: prop.price,
                image: imagePath,
                roomType: prop.propertyType,
                description: '상세 설명은 전체 상세보기에서 확인하실 수 있습니다.',
                options: optionList,
                area: prop.contractArea ? prop.contractArea + '㎡ (약 ' + Math.round(prop.contractArea / 3.3) + '평)' : '정보 없음',
                floor: prop.floor ? prop.floor + '층' : '정보 없음',
                maintenanceFee: prop.maintenanceFee ? prop.maintenanceFee + '만원' : '정보 없음'
            };
        });

        // 상세정보 열기
        function showPropertyDetail(propertyId) {
            currentPropertyId = propertyId; // ★ 2. 상세정보가 열릴 때 현재 ID 저장
            var property = propertyDetails[propertyId];
            if (!property) return;

            document.getElementById('detailTitle').textContent = property.title;
            document.getElementById('detailLocation').textContent = property.location;
            document.getElementById('detailPrice').textContent = property.price;
            document.getElementById('detailImage').src = property.image;
            document.getElementById('detailRoomType').textContent = property.roomType;
            document.getElementById('detailDescription').textContent = property.description;

            // 전용면적, 층수, 관리비 추가
            document.getElementById('detailArea').textContent = property.area || '정보 없음';
            document.getElementById('detailFloor').textContent = property.floor || '정보 없음';
            document.getElementById('detailMaintenanceFee').textContent = property.maintenanceFee || '정보 없음';

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

        // 중개사 문의 페이지로 이동하는 새 함수
        function goToContactPage() {
            if (!currentPropertyId) {
                alert("오류: 현재 매물 ID를 찾을 수 없습니다.");
                return;
            }
            // 'contact-realtor.jsp' 페이지로 propertyId를 쿼리 스트링으로 넘깁니다.
            window.location.href = '${pageContext.request.contextPath}/inquiries/realtor?propertyId=' + currentPropertyId;
        }

        // 전체 상세 페이지로 이동
        function openDetailPage() {
            // 하드코딩된 ID 대신 currentPropertyId 변수 사용하도록 수정
            if (!currentPropertyId) { 
                alert("오류: 현재 매물 ID를 찾을 수 없습니다.");
                return;
            }
            // Spring Controller의 @GetMapping("/{id}") 패턴에 맞게 이동
            window.location.href = '${pageContext.request.contextPath}/property/' + currentPropertyId;
        }
        
		//  중개사 문의하기 버튼 클릭 시 로그인 체크 함수
        function checkLoginAndGoToContact() {
            // JSTL을 이용해 로그인 상태를 JavaScript 변수에 저장
            const isLoggedIn = ${not empty sessionScope.loginUser}; 

            if (!isLoggedIn) {
                // 로그인이 안 되어 있으면 확인 창 띄우기
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    // 확인 누르면 로그인 페이지로 이동 (로그인 후 지도 페이지로 돌아오도록 redirectUrl 설정)
                    window.location.href = '${pageContext.request.contextPath}/auth/login?redirectUrl=/map';
                }
                // 취소 누르면 아무것도 안 함
                return; 
            }

            // 로그인이 되어 있으면 기존 함수 호출
            goToContactPage(); 
        }
		
     // 신고하기 버튼 클릭 시 로그인 체크 함수
        function checkLoginAndGoToReport() {
            const isLoggedIn = ${not empty sessionScope.loginUser}; 

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login?redirectUrl=/map';
                }
                return; 
            }

            // 로그인이 되어 있으면 신고 페이지로 이동
            goToReportPage(); 
        }

        // 신고 페이지로 이동 (관리자 문의 페이지로)
        function goToReportPage() {
            if (!currentPropertyId) {
                alert("오류: 현재 매물 ID를 찾을 수 없습니다.");
                return;
            }
            
            // 현재 매물 정보 가져오기
            const property = propertyDetails[currentPropertyId];
            if (!property) {
                alert("매물 정보를 찾을 수 없습니다.");
                return;
            }
            
            // 매물 정보를 URL 파라미터로 전달
            const params = new URLSearchParams({
                category: '허위매물신고',
                propertyId: currentPropertyId,
                propertyName: property.title,
                propertyPrice: property.price,
                propertyLocation: property.location.replace('📍 ', '')
            });
            
            window.location.href = '${pageContext.request.contextPath}/inquiries/contact-admin?' + params.toString();
        }
        
        //찜 토글
        function toggleWishlist() {
            const isLoggedIn = ${not empty sessionScope.loginUser};
            if (!isLoggedIn) {
              if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                window.location.href = '${pageContext.request.contextPath}/auth/login?redirectUrl=/map';
              }
              return;
            }
            if (!currentPropertyId) {
              alert('매물을 먼저 선택하세요.');
              return;
            }
            toggleWishlistAjax(currentPropertyId);
          }

        function toggleWishlistAjax(propertyId) {
        	  const headers = { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' };
        	  const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
        	  const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');
        	  if (csrfToken && csrfHeader) headers[csrfHeader] = csrfToken;

        	  fetch('${pageContext.request.contextPath}/property/' + propertyId + '/wishlist', {
        	    method: 'POST',
        	    headers,
        	    body: '{}'
        	  })
        	  .then(res => {
        	    if (res.redirected) {
        	      const btn = document.getElementById('btnFavorite');
        	      if (btn) {
        	        const liked = btn.classList.toggle('active');
        	        btn.textContent = liked ? '♥ 찜해제' : '♡ 찜하기';
        	      }
        	      return { _handled: true };
        	    }
        	    return res.json().catch(() => null);
        	  })
        	  .then(data => {
        	    if (!data || data._handled) return;

        	    const btn = document.getElementById('btnFavorite');
        	    if (!btn) return;

        	    if (data.success !== undefined) {
        	      const liked = !!data.liked;
        	      btn.classList.toggle('active', liked);
        	      btn.textContent = liked ? '♥ 찜해제' : '♡ 찜하기';
        	    } else {
        	      const liked = btn.classList.toggle('active');
        	      btn.textContent = liked ? '♥ 찜해제' : '♡ 찜하기';
        	    }
        	  })
        	  .catch(err => {
        	    console.error(err);
        	    alert('찜 처리 중 오류가 발생했습니다.');
        	  });
        	}
    </script>
</body>
</html>