<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UNILAND - 대학생 맞춤 원룸 중개 플랫폼</title>
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
            background: linear-gradient(180deg, #f8f9ff 0%, #f5f5f5 50%, #fafafa 100%);
            line-height: 1.6;
            min-width: 1400px;
            overflow-x: auto;
        }

        /* 메인 컨테이너 */
        .main-container {
            max-width: 1400px;
            min-width: 1400px;
            margin: 0 auto;
            padding: 24px 40px 48px;
        }

        /* AI 검색 섹션 */
        .ai-search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 32px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 48px;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
            position: relative;
            overflow: hidden;
        }

        .ai-search-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .ai-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            border: 1px solid rgba(255,255,255,0.3);
            position: relative;
        }

        .ai-badge i {
            animation: sparkle 2s ease-in-out infinite;
        }

        @keyframes sparkle {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.2); }
        }

        .ai-search-section h1 {
            color: white;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 16px;
            letter-spacing: -0.5px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .ai-search-section h1 i {
            font-size: 28px;
        }

        .ai-search-section p {
            color: rgba(255,255,255,0.85);
            font-size: 16px;
            margin-bottom: 32px;
            font-weight: 400;
            position: relative;
        }

        .search-input-container {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 16px 120px 16px 56px;
            border: none;
            border-radius: 30px;
            font-size: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }

        .search-input:focus {
            outline: none;
            box-shadow: 0 6px 30px rgba(0,0,0,0.25);
            transform: translateY(-2px);
        }

        .search-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 18px;
        }

        .search-button {
            position: absolute;
            right: 6px;
            top: 50%;
            transform: translateY(-50%);
            background: #667eea;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.2s;
        }

        .search-button:hover {
            background: #5568d3;
        }

        .search-examples {
            margin-top: 24px;
            color: rgba(255,255,255,0.75);
            font-size: 13px;
            position: relative;
            z-index: 2;
        }

        .search-examples span {
            display: inline-block;
            margin: 6px 8px;
            padding: 7px 14px;
            background: rgba(255,255,255,0.15);
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.2s;
            font-weight: 400;
            position: relative;
            z-index: 2;
        }

        .search-examples span:hover {
            background: rgba(255,255,255,0.25);
        }

        .map-link {
            margin-top: 20px;
            color: rgba(255,255,255,0.85);
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            position: relative;
            z-index: 1;
        }

        .map-link:hover {
            color: white;
            text-decoration: underline;
        }

        .map-link strong {
            cursor: pointer;
        }

        /* 인기 매물 섹션 */
        .popular-section {
            margin-bottom: 60px;
            padding-bottom: 60px;
            border-bottom: 2px solid #e5e5e5;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .section-header h2 {
            font-size: 28px;
            color: #0a0a0a;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .view-all {
            color: #667eea;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .view-all:hover {
            color: #5568d3;
        }

        .property-slider-container {
            position: relative;
            overflow: hidden;
            padding: 0 60px;
        }

        .property-slider-wrapper {
        	margin-top: 10px;
            overflow: hidden;
        }

        .property-grid {
        	margin-top: 10px;
            display: flex;
            gap: 20px;
            transition: transform 0.5s ease;
        }

        .property-card {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.1);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            min-width: calc((100% - 40px) / 3);
            flex-shrink: 0;
            position: relative;
        }

        .property-card:hover {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 12px 48px rgba(102, 126, 234, 0.2);
            border-color: rgba(102, 126, 234, 0.3);
            transform: translateY(-8px);
        }

        .slider-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: white;
            border: 1px solid #e5e5e5;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            transition: all 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .slider-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .slider-btn-prev {
            left: 0;
        }

        .slider-btn-next {
            right: 0;
        }

        .slider-btn:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .slider-btn:disabled:hover {
            background: white;
            color: #333;
            border-color: #e5e5e5;
        }

        .property-image {
            width: 100%;
            height: 200px;
            background: #f0f0f0;
            position: relative;
            overflow: hidden;
        }

        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .property-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        .property-badge.student {
            background: #667eea;
        }

        .property-badge.new {
            background: #48bb78;
        }

        .property-badge.urgent {
            background: #f56565;
        }

        .property-info {
            padding: 20px;
        }

        .property-title {
            font-size: 17px;
            font-weight: 700;
            color: #0a0a0a;
            margin-bottom: 8px;
            line-height: 1.4;
            letter-spacing: -0.3px;
        }

        .property-location {
            color: #666;
            font-size: 13px;
            margin-bottom: 12px;
        }

        .property-price {
            font-size: 22px;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 12px;
            letter-spacing: -0.5px;
        }

        .property-tags {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .property-tags span {
            background: #f5f5f5;
            color: #555;
            padding: 4px 9px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 500;
        }

        /* 정보 섹션 */
        .info-section {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .info-section-title {
            font-size: 28px;
            color: #0a0a0a;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 24px;
        }

        .info-card {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 32px;
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.08);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .info-card:hover {
            background: rgba(255, 255, 255, 0.85);
            transform: translateY(-4px);
            box-shadow: 0 12px 48px rgba(102, 126, 234, 0.15);
            border-color: rgba(102, 126, 234, 0.2);
        }

        .info-card-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e5e5e5;
        }

        .info-card-icon {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            font-size: 24px;
        }

        .info-card h3 {
            font-size: 18px;
            color: #0a0a0a;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .info-list {
            list-style: none;
        }

        .info-list li {
            padding: 11px 0;
            color: #555;
            font-size: 14px;
            border-bottom: 1px solid #f5f5f5;
            cursor: pointer;
            transition: color 0.2s;
        }

        .info-list li:hover {
            color: #667eea;
        }

        .info-list li:last-child {
            border-bottom: none;
        }

        .view-more {
            display: block;
            text-align: center;
            margin-top: 16px;
            color: #667eea;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .view-more:hover {
            color: #5568d3;
        }
    </style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <!-- 메인 컨텐츠 -->
    <div class="main-container">
        <!-- AI 검색 섹션 -->
        <section class="ai-search-section">
            <div class="ai-badge">
                <i class="fa-solid fa-sparkles"></i>
                AI 기반 검색
            </div>
            <h1>
                <i class="fa-solid fa-house-circle-check"></i>
                대학생을 위한 똑똑한 방 찾기
            </h1>
            <p>AI가 당신의 조건에 딱 맞는 원룸을 찾아드립니다</p>
            <div class="search-input-container">
                <i class="fa-solid fa-wand-magic-sparkles search-icon"></i>
                <input type="text" class="search-input" placeholder="예) 연세대 근처에서 월세 70만원 이하로 찾아줘">
                <button class="search-button"><i class="fa-solid fa-magnifying-glass"></i> 검색</button>
            </div>
            <div class="search-examples">
                <span>홍익대 도보 10분</span>
                <span>보증금 500만원 이하</span>
                <span>풀옵션</span>
                <span>합정역 근처</span>
            </div>
            <div class="map-link" style="cursor: pointer;">
                또는 <strong>지도에서 직접 찾아보기 →</strong>
            </div>
        </section>

        <!-- 인기 매물 섹션 -->
        <section class="popular-section">
            <div class="section-header">
                <h2>이번 주 인기 매물</h2>
                <span class="view-all">전체보기 →</span>
            </div>
            <div class="property-slider-container">
                <button class="slider-btn slider-btn-prev" onclick="slideProperty(-1)">
                    <i class="fa-solid fa-chevron-left"></i>
                </button>
                <button class="slider-btn slider-btn-next" onclick="slideProperty(1)">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
                <div class="property-slider-wrapper">
                    <div class="property-grid">
                <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/1'">
                    <div class="property-image">
                        <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop" alt="원룸">
                        <span class="property-badge student">학생 우대</span>
                    </div>
                    <div class="property-info">
                        <div class="property-title">신촌역 5분거리 풀옵션 원룸</div>
                        <div class="property-location">서울 서대문구 창천동</div>
                        <div class="property-price">500/55</div>
                        <div class="property-tags">
                            <span>풀옵션</span>
                            <span>역세권</span>
                            <span>단기가능</span>
                        </div>
                    </div>
                </div>
                <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/2'">
                    <div class="property-image">
                        <img src="https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=300&fit=crop" alt="오피스텔">
                        <span class="property-badge new">NEW</span>
                    </div>
                    <div class="property-info">
                        <div class="property-title">혜화역 도보 7분 깨끗한 오피스텔</div>
                        <div class="property-location">서울 종로구 명륜동</div>
                        <div class="property-price">1000/60</div>
                        <div class="property-tags">
                            <span>신축</span>
                            <span>주차가능</span>
                            <span>엘리베이터</span>
                        </div>
                    </div>
                </div>
                <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/3'">
                    <div class="property-image">
                        <img src="https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&h=300&fit=crop" alt="원룸">
                        <span class="property-badge urgent">급매</span>
                    </div>
                    <div class="property-info">
                        <div class="property-title">홍대 캠퍼스 앞 저렴한 원룸</div>
                        <div class="property-location">서울 마포구 서교동</div>
                        <div class="property-price">300/45</div>
                        <div class="property-tags">
                            <span>저렴</span>
                            <span>학교근처</span>
                            <span>관리비저렴</span>
                        </div>
                    </div>
                </div>
                <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/4'">
                    <div class="property-image">
                        <img src="https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400&h=300&fit=crop" alt="원룸">
                        <span class="property-badge student">학생 우대</span>
                    </div>
                    <div class="property-info">
                        <div class="property-title">건대입구역 초역세권 원룸</div>
                        <div class="property-location">서울 광진구 화양동</div>
                        <div class="property-price">500/50</div>
                        <div class="property-tags">
                            <span>초역세권</span>
                            <span>풀옵션</span>
                            <span>보안우수</span>
                        </div>
                    </div>
                </div>
                <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/5'">
                    <div class="property-image">
                        <img src="https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=400&h=300&fit=crop" alt="오피스텔">
                    </div>
                    <div class="property-info">
                        <div class="property-title">이대역 3분 신축 오피스텔</div>
                        <div class="property-location">서울 서대문구 대현동</div>
                        <div class="property-price">1500/70</div>
                        <div class="property-tags">
                            <span>신축</span>
                            <span>풀옵션</span>
                            <span>세탁기</span>
                        </div>
                    </div>
                </div>
                <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/6'">
                    <div class="property-image">
                        <img src="https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&h=300&fit=crop" alt="투룸">
                        <span class="property-badge student">학생 우대</span>
                    </div>
                    <div class="property-info">
                        <div class="property-title">성신여대 도보 5분 투룸</div>
                        <div class="property-location">서울 성북구 동선동</div>
                        <div class="property-price">500/65</div>
                        <div class="property-tags">
                            <span>투룸</span>
                            <span>단기가능</span>
                            <span>반려동물</span>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            </div>
        </section>

        <!-- 정보 섹션 -->
        <h2 class="info-section-title">유용한 정보</h2>
        <div class="info-section">
            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon"><i class="fa-solid fa-lightbulb"></i></div>
                    <h3>첫 자취 꿀팁</h3>
                </div>
                <ul class="info-list">
                    <li onclick="location.href='${pageContext.request.contextPath}/community/guide'">계약 전 꼭 확인해야 할 10가지</li>
                    <li onclick="location.href='${pageContext.request.contextPath}/community/guide'">숨은 비용 찾아내는 법</li>
                    <li onclick="location.href='${pageContext.request.contextPath}/community/guide'">원룸 vs 오피스텔 차이점</li>
                    <li onclick="location.href='${pageContext.request.contextPath}/community/guide'">계약서 작성 주의사항</li>
                    <li onclick="location.href='${pageContext.request.contextPath}/community/guide'">입주 전 체크리스트</li>
                </ul>
                <span class="view-more" onclick="location.href='${pageContext.request.contextPath}/community/guide'">더보기 →</span>
            </div>

            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon"><i class="fa-solid fa-clipboard-check"></i></div>
                    <h3>입주 점검표</h3>
                </div>
                <ul class="info-list">
                    <li>수압 및 수도 시설 확인</li>
                    <li>채광 및 통풍 체크</li>
                    <li>전기 콘센트 위치 확인</li>
                    <li>도어락 및 보안 점검</li>
                    <li>인터넷 및 통신 환경</li>
                </ul>
                <span class="view-more" onclick="openChecklistModal()">PDF 다운로드 →</span>
            </div>

            <div class="info-card">
		    <div class="info-card-header">
		        <div class="info-card-icon"><i class="fa-solid fa-bullhorn"></i></div>
		        <h3>공지사항</h3>
		    </div>
		    <ul class="info-list">
		        <c:forEach var="notice" items="${noticeList}" begin="0" end="4">
		            <li onclick="location.href='${pageContext.request.contextPath}/community/notice/${notice.noticeNo}'">
		                ${notice.noticeSubject}
		            </li>
		        </c:forEach>
		        <c:if test="${empty noticeList}">
		            <li style="color: #999; cursor: default;">등록된 공지사항이 없습니다.</li>
		        </c:if>
		    </ul>
		    <span class="view-more" onclick="location.href='${pageContext.request.contextPath}/community/notice'">더보기 →</span>
		</div>
        </div>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <!-- 입주 점검표 모달 포함 -->
    <jsp:include page="/WEB-INF/views/components/checklist-modal.jsp"/>

    <script>
        // 슬라이더 관련
        let currentSlide = 0;
        const propertyGrid = document.querySelector('.property-grid');
        const propertyCards = document.querySelectorAll('.property-card');
        const totalCards = propertyCards.length;
        const cardsPerView = 3;
        const maxSlide = totalCards - cardsPerView;

        function slideProperty(direction) {
            currentSlide += direction;

            if (currentSlide < 0) currentSlide = 0;
            if (currentSlide > maxSlide) currentSlide = maxSlide;

            const cardWidth = propertyCards[0].offsetWidth;
            const gap = 20;
            const slideAmount = currentSlide * (cardWidth + gap);
            propertyGrid.style.transform = 'translateX(-' + slideAmount + 'px)';

            updateButtons();
        }

        function updateButtons() {
            const prevBtn = document.querySelector('.slider-btn-prev');
            const nextBtn = document.querySelector('.slider-btn-next');

            prevBtn.disabled = currentSlide === 0;
            nextBtn.disabled = currentSlide === maxSlide;
        }

        // 초기 버튼 상태 설정
        updateButtons();

        // AI 검색 버튼
        document.querySelector('.search-button').addEventListener('click', function() {
            const searchInput = document.querySelector('.search-input');
            const query = searchInput.value.trim();

            if (query) {
                // TODO: AI 검색 페이지로 이동
                alert('AI 검색 기능은 준비 중입니다.');
            } else {
                alert('검색어를 입력해주세요.');
            }
        });

        // 검색창 엔터키
        document.querySelector('.search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.querySelector('.search-button').click();
            }
        });

        // 검색 예시 클릭
        document.addEventListener('DOMContentLoaded', function() {
            const searchExamples = document.querySelectorAll('.search-examples span');
            const searchInput = document.querySelector('.search-input');

            searchExamples.forEach(function(span) {
                span.addEventListener('click', function(e) {
                    e.stopPropagation();
                    searchInput.value = this.textContent;
                    searchInput.focus();
                });
            });
        });

        // 지도 링크 클릭
        document.querySelector('.map-link').addEventListener('click', function() {
            location.href = '${pageContext.request.contextPath}/map';
        });

        // 전체보기 버튼
        document.querySelector('.view-all').addEventListener('click', function() {
            // TODO: 매물 목록 페이지로 이동
            alert('매물 목록 페이지는 준비 중입니다.');
        });

    </script>
</body>
</html>
