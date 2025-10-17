<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자취 가이드 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            color: #1a1a1a;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        /* 메인 컨테이너 */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 24px;
        }

        /* 페이지 헤더 */
        .page-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .page-title {
            font-size: 36px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 12px;
        }

        .page-subtitle {
            font-size: 16px;
            color: #666;
        }

        /* 카테고리 탭 */
        .category-tabs {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .category-tab {
            padding: 12px 24px;
            border: 2px solid #e2e8f0;
            background: white;
            color: #4a5568;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .category-tab:hover {
            border-color: #667eea;
            color: #667eea;
        }

        .category-tab.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }

        /* 컨텐츠 영역 */
        .content-wrapper {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 30px;
        }

        /* 상단 컨트롤 */
        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e5e5e5;
        }

        .search-box {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }

        .search-input {
            flex: 1;
            padding: 12px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.2s;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-search {
            padding: 12px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-search:hover {
            background: #5568d3;
        }

        .btn-write {
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-write:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        /* 게시글 리스트 */
        .post-list {
            list-style: none;
        }

        .post-item {
            padding: 24px 0;
            border-bottom: 1px solid #e5e5e5;
            cursor: pointer;
            transition: background 0.2s;
        }

        .post-item:hover {
            background: #f7fafc;
            margin: 0 -30px;
            padding: 24px 30px;
        }

        .post-item:last-child {
            border-bottom: none;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 12px;
        }

        .post-left {
            flex: 1;
        }

        .post-category {
            display: inline-block;
            background: #e0e7ff;
            color: #667eea;
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .post-category.tip {
            background: #feebc8;
            color: #c05621;
        }

        .post-category.life {
            background: #c6f6d5;
            color: #22543d;
        }

        .post-category.area {
            background: #e0e7ff;
            color: #434190;
        }

        .post-category.qna {
            background: #fed7d7;
            color: #c53030;
        }

        .post-title {
            font-size: 18px;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .post-title:hover {
            color: #667eea;
        }

        .post-preview {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .post-meta {
            display: flex;
            gap: 20px;
            margin-top: 12px;
            font-size: 13px;
            color: #999;
        }

        .post-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: #fff5f5;
            color: #f56565;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .post-badge.hot {
            background: #fed7d7;
            color: #c53030;
        }

        /* 인기글 섹션 */
        .popular-section {
            background: #f7fafc;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .popular-title {
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .popular-list {
            list-style: none;
        }

        .popular-item {
            padding: 12px 0;
            border-bottom: 1px solid #e2e8f0;
            cursor: pointer;
            transition: all 0.2s;
        }

        .popular-item:hover {
            color: #667eea;
        }

        .popular-item:last-child {
            border-bottom: none;
        }

        .popular-number {
            display: inline-block;
            width: 24px;
            height: 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 4px;
            text-align: center;
            line-height: 24px;
            font-size: 13px;
            font-weight: 700;
            margin-right: 10px;
        }

        .popular-item-title {
            font-size: 14px;
            font-weight: 500;
        }

        /* 페이지네이션 */
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
            color: #4a5568;
            transition: all 0.2s;
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

        /* 빈 상태 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
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

        /* 반응형 */
        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                gap: 15px;
            }

            .search-box {
                max-width: 100%;
            }

            .post-title {
                font-size: 16px;
            }

            .category-tabs {
                justify-content: flex-start;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <!-- 메인 컨테이너 -->
    <div class="main-container">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <h1 class="page-title">🏠 자취 가이드</h1>
            <p class="page-subtitle">처음 자취하는 대학생을 위한 꿀팁 모음</p>
        </div>

        <!-- 카테고리 탭 -->
        <div class="category-tabs">
            <button class="category-tab active" onclick="filterCategory('all')">
                <i class="fa-solid fa-list"></i> 전체
            </button>
            <button class="category-tab" onclick="filterCategory('contract')">
                <i class="fa-solid fa-file-contract"></i> 계약 팁
            </button>
            <button class="category-tab" onclick="filterCategory('moving')">
                <i class="fa-solid fa-truck-moving"></i> 이사 팁
            </button>
            <button class="category-tab" onclick="filterCategory('life')">
                <i class="fa-solid fa-house-user"></i> 생활 팁
            </button>
            <button class="category-tab" onclick="filterCategory('area')">
                <i class="fa-solid fa-map-location-dot"></i> 동네 정보
            </button>
            <button class="category-tab" onclick="filterCategory('qna')">
                <i class="fa-solid fa-question-circle"></i> 질문/답변
            </button>
        </div>

        <!-- 컨텐츠 영역 -->
        <div class="content-wrapper">
            <!-- 인기글 -->
            <div class="popular-section">
                <h3 class="popular-title">
                    <i class="fa-solid fa-fire" style="color: #f56565;"></i>
                    인기 게시글 TOP 5
                </h3>
                <ul class="popular-list">
                    <li class="popular-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/1'">
                        <span class="popular-number">1</span>
                        <span class="popular-item-title">계약 전 꼭 확인해야 할 10가지 체크리스트</span>
                    </li>
                    <li class="popular-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/2'">
                        <span class="popular-number">2</span>
                        <span class="popular-item-title">신촌 자취생이 알려주는 실전 생활비 절약법</span>
                    </li>
                    <li class="popular-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/3'">
                        <span class="popular-number">3</span>
                        <span class="popular-item-title">원룸 곰팡이 예방 완벽 가이드</span>
                    </li>
                    <li class="popular-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/4'">
                        <span class="popular-number">4</span>
                        <span class="popular-item-title">대학가 숨은 맛집 추천 (홍대편)</span>
                    </li>
                    <li class="popular-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/5'">
                        <span class="popular-number">5</span>
                        <span class="popular-item-title">보증금 돌려받기 실전 노하우</span>
                    </li>
                </ul>
            </div>

            <!-- 상단 컨트롤 -->
            <div class="controls">
                <form action="${pageContext.request.contextPath}/community/guide" method="get" class="search-box">
                    <input type="text" name="keyword" class="search-input"
                           placeholder="검색어를 입력하세요" value="${param.keyword}">
                    <button type="submit" class="btn-search">
                        <i class="fa-solid fa-magnifying-glass"></i> 검색
                    </button>
                </form>
                <button class="btn-write" onclick="checkLoginAndWrite()">
                    <i class="fa-solid fa-pen"></i> 글쓰기
                </button>
            </div>

            <!-- 게시글 리스트 -->
            <ul class="post-list">
                <c:choose>
                    <c:when test="${not empty guideList}">
                        <c:forEach var="guide" items="${guideList}">
                            <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${guide.guideId}'">
                                <div class="post-header">
                                    <div class="post-left">
                                        <span class="post-category ${guide.category}">${guide.categoryName}</span>
                                        <c:if test="${guide.isHot}">
                                            <span class="post-badge hot">
                                                <i class="fa-solid fa-fire"></i> HOT
                                            </span>
                                        </c:if>
                                        <h3 class="post-title">${guide.title}</h3>
                                        <p class="post-preview">${guide.preview}</p>
                                    </div>
                                </div>
                                <div class="post-meta">
                                    <span><i class="fa-solid fa-user"></i> ${guide.authorNickname}</span>
                                    <span><i class="fa-solid fa-calendar"></i> <fmt:formatDate value="${guide.createdAt}" pattern="yyyy.MM.dd"/></span>
                                    <span><i class="fa-solid fa-eye"></i> ${guide.viewCount}</span>
                                    <span><i class="fa-solid fa-heart"></i> ${guide.likeCount}</span>
                                    <span><i class="fa-solid fa-comment"></i> ${guide.commentCount}</span>
                                </div>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- 샘플 데이터 (서버에서 데이터가 없을 때) -->
                        <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/1'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category">계약 팁</span>
                            <span class="post-badge hot">
                                <i class="fa-solid fa-fire"></i> HOT
                            </span>
                            <h3 class="post-title">계약 전 꼭 확인해야 할 10가지 체크리스트</h3>
                            <p class="post-preview">
                                처음 원룸 계약하시는 분들을 위해 실전 체크리스트를 준비했습니다. 
                                수압, 채광, 곰팡이, 소음 등 현장에서 꼭 확인해야 할 항목들을 정리했어요...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 자취고수</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.15</span>
                        <span><i class="fa-solid fa-eye"></i> 1,245</span>
                        <span><i class="fa-solid fa-heart"></i> 89</span>
                        <span><i class="fa-solid fa-comment"></i> 23</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/2'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category life">생활 팁</span>
                            <h3 class="post-title">신촌 자취생이 알려주는 실전 생활비 절약법</h3>
                            <p class="post-preview">
                                월 생활비 50만원으로 버티는 법! 장보기 꿀팁부터 통신비 절약까지 
                                실제로 제가 사용하는 방법들을 공유합니다...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 알뜰자취러</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.14</span>
                        <span><i class="fa-solid fa-eye"></i> 892</span>
                        <span><i class="fa-solid fa-heart"></i> 67</span>
                        <span><i class="fa-solid fa-comment"></i> 15</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/3'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category life">생활 팁</span>
                            <span class="post-badge hot">
                                <i class="fa-solid fa-fire"></i> HOT
                            </span>
                            <h3 class="post-title">원룸 곰팡이 예방 완벽 가이드</h3>
                            <p class="post-preview">
                                겨울철 원룸 곰팡이 때문에 고생하시는 분들 많으시죠? 
                                환기, 제습, 청소 방법까지 곰팡이 예방의 모든 것을 알려드립니다...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 깔끔쟁이</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.13</span>
                        <span><i class="fa-solid fa-eye"></i> 756</span>
                        <span><i class="fa-solid fa-heart"></i> 54</span>
                        <span><i class="fa-solid fa-comment"></i> 18</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/4'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category area">동네 정보</span>
                            <h3 class="post-title">대학가 숨은 맛집 추천 (홍대편)</h3>
                            <p class="post-preview">
                                홍대 근처에서 자취하시는 분들! 가성비 좋은 숨은 맛집들을 소개합니다. 
                                혼밥하기 좋은 곳부터 회식 장소까지...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 홍대맛집러</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.12</span>
                        <span><i class="fa-solid fa-eye"></i> 623</span>
                        <span><i class="fa-solid fa-heart"></i> 42</span>
                        <span><i class="fa-solid fa-comment"></i> 12</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/5'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category tip">이사 팁</span>
                            <h3 class="post-title">보증금 돌려받기 실전 노하우</h3>
                            <p class="post-preview">
                                계약 종료 후 보증금 100% 돌려받는 법! 
                                입주 시 사진 찍기부터 퇴거 청소까지 단계별로 알려드립니다...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 현명한자취러</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.11</span>
                        <span><i class="fa-solid fa-eye"></i> 534</span>
                        <span><i class="fa-solid fa-heart"></i> 38</span>
                        <span><i class="fa-solid fa-comment"></i> 9</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/6'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category qna">질문/답변</span>
                            <h3 class="post-title">첫 자취 준비물 뭐가 필요할까요?</h3>
                            <p class="post-preview">
                                다음 달에 처음으로 자취를 시작하는데요, 
                                필수 준비물이 뭐가 있을까요? 선배님들 조언 부탁드립니다...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 자취초보</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.10</span>
                        <span><i class="fa-solid fa-eye"></i> 421</span>
                        <span><i class="fa-solid fa-heart"></i> 24</span>
                        <span><i class="fa-solid fa-comment"></i> 16</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/7'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category">계약 팁</span>
                            <h3 class="post-title">월세 vs 전세, 어떤 게 유리할까?</h3>
                            <p class="post-preview">
                                대학생 입장에서 월세와 전세 중 어떤 것이 더 유리한지 비교 분석해봤습니다. 
                                각각의 장단점과 상황별 추천...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 부동산공부중</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.09</span>
                        <span><i class="fa-solid fa-eye"></i> 387</span>
                        <span><i class="fa-solid fa-heart"></i> 19</span>
                        <span><i class="fa-solid fa-comment"></i> 7</span>
                    </div>
                </li>

                <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/8'">
                    <div class="post-header">
                        <div class="post-left">
                            <span class="post-category area">동네 정보</span>
                            <h3 class="post-title">신촌 vs 홍대, 어디가 살기 좋을까?</h3>
                            <p class="post-preview">
                                연세대 다니는 학생입니다. 신촌과 홍대 중 어디에 방을 구할지 고민 중인데요, 
                                실거주자 분들의 의견이 궁금합니다...
                            </p>
                        </div>
                    </div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 연세대24</span>
                        <span><i class="fa-solid fa-calendar"></i> 2024.01.08</span>
                        <span><i class="fa-solid fa-eye"></i> 298</span>
                        <span><i class="fa-solid fa-heart"></i> 15</span>
                        <span><i class="fa-solid fa-comment"></i> 11</span>
                    </div>
                </li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <button onclick="location.href='?page=${currentPage - 1}'">
                        <i class="fa-solid fa-chevron-left"></i> 이전
                    </button>
                </c:if>
                <c:if test="${currentPage == null || currentPage <= 1}">
                    <button disabled><i class="fa-solid fa-chevron-left"></i> 이전</button>
                </c:if>

                <c:choose>
                    <c:when test="${not empty totalPages}">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <button onclick="location.href='?page=${i}'"
                                    class="${i == currentPage ? 'active' : ''}">
                                ${i}
                            </button>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <button class="active">1</button>
                        <button onclick="location.href='?page=2'">2</button>
                        <button onclick="location.href='?page=3'">3</button>
                        <button onclick="location.href='?page=4'">4</button>
                        <button onclick="location.href='?page=5'">5</button>
                    </c:otherwise>
                </c:choose>

                <c:if test="${currentPage < totalPages}">
                    <button onclick="location.href='?page=${currentPage + 1}'">
                        다음 <i class="fa-solid fa-chevron-right"></i>
                    </button>
                </c:if>
                <c:if test="${currentPage == null || (totalPages != null && currentPage >= totalPages)}">
                    <button onclick="location.href='?page=2'">다음 <i class="fa-solid fa-chevron-right"></i></button>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        // 카테고리 필터
        function filterCategory(category) {
            const tabs = document.querySelectorAll('.category-tab');
            tabs.forEach(tab => tab.classList.remove('active'));
            event.target.classList.add('active');

            // 카테고리별 필터링
            if (category === 'all') {
                location.href = '${pageContext.request.contextPath}/community/guide';
            } else {
                location.href = '${pageContext.request.contextPath}/community/guide?category=' + category;
            }
        }

        // 글쓰기 (로그인 체크)
        function checkLoginAndWrite() {
            const isLoggedIn = ${not empty sessionScope.user};

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }
                return;
            }

            // 글쓰기 페이지로 이동
            location.href = '${pageContext.request.contextPath}/community/guide/write';
        }

        // 엔터키로 검색
        document.querySelector('.search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.querySelector('.btn-search').click();
            }
        });
    </script>
</body>
</html>