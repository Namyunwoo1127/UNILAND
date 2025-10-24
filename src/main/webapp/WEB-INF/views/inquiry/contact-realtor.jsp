<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>중개사 문의하기 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ========================================
           UNILAND 디자인 시스템 - CSS 변수
        ======================================== */
        :root {
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #718096; /* ★ map.jsp와 통일 */
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-tag: #f7fafc; /* ★ map.jsp와 통일 */
            --border-light: #e2e8f0; /* ★ map.jsp와 통일 */
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --spacing-3xl: 48px;
            --radius-md: 6px;
            --radius-lg: 8px;
            --font-md: 14px;
            --font-lg: 16px;
            --font-2xl: 24px;
            --color-red: #f56565; /* ★ 빨간색 변수 추가 */
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--bg-body);
            color: var(--text-primary);
        }

        /* ========================================
           ▼▼▼ 1. 새로운 2단 레이아웃 CSS ▼▼▼
        ======================================== */
        .page-wrapper {
            display: flex;
            max-width: 1200px; /* ★ 전체 컨테이너 폭 조절 */
            margin: var(--spacing-3xl) auto;
            background: var(--bg-white);
            border-radius: var(--radius-lg);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            overflow: hidden; /* 자식 요소의 radius 적용을 위해 */
        }

        .property-detail-column {
            flex: 1; /* 왼쪽 컬럼 */
            min-width: 450px; /* 최소 너비 */
            max-width: 550px; /* 최대 너비 */
            border-right: 1px solid var(--border-light);
            background: var(--bg-white);
        }

        .inquiry-form-column {
            flex: 1; /* 오른쪽 컬럼 */
            min-width: 400px; /* 최소 너비 */
            padding: var(--spacing-xl);
            display: flex;
            flex-direction: column;
        }
        
        /* ========================================
           ▼▼▼ 2. map.jsp에서 가져온 상세정보 CSS ▼▼▼
        ======================================== */
        .detail-images {
            width: 100%;
            height: 300px;
            position: relative;
            background: #f0f0f0;
            flex-shrink: 0;
        }

        .detail-images img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .detail-info {
            padding: 25px;
            width: 100%;
            flex-shrink: 0;
        }

        .detail-price {
            font-size: 32px;
            font-weight: bold;
            color: var(--primary-purple);
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
            color: var(--text-tertiary);
            margin-bottom: 20px;
        }

        .detail-section {
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid var(--border-light);
        }

        .detail-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
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
            background: var(--bg-tag);
            border-radius: 4px;
        }

        .detail-item-label {
            color: var(--text-tertiary);
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
            color: var(--primary-purple);
            padding: 8px 14px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
        }

        .detail-description {
            color: #4a5568;
            line-height: 1.6;
            font-size: 14px;
            white-space: pre-wrap; /* 줄바꿈 유지를 위해 */
        }
        
        /* ========================================
           ▼▼▼ 3. 기존 문의 양식 CSS ▼▼▼
        ======================================== */
        .page-title {
            font-size: var(--font-2xl);
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: var(--spacing-2xl);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .form-group {
            margin-bottom: var(--spacing-lg);
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: var(--font-md);
            margin-bottom: var(--spacing-sm);
        }
        
        .form-control {
            width: 100%;
            padding: var(--spacing-sm) var(--spacing-md);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            transition: all 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        textarea.form-control {
            min-height: 200px;
            resize: vertical;
            font-family: inherit;
        }
        
        .btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto; /* ★ 버튼을 하단에 고정 */
            padding-top: var(--spacing-lg);
            border-top: 1px solid var(--border-light);
        }
        
        .btn-primary {
            padding: var(--spacing-sm) var(--spacing-lg);
            background: var(--gradient-primary);
            color: var(--bg-white);
            border: none;
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }
        
        .btn-secondary {
            padding: var(--spacing-sm) var(--spacing-lg);
            background: var(--bg-white);
            color: var(--primary-purple);
            border: 1px solid var(--primary-purple);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .btn-secondary:hover {
            background: var(--bg-tag);
        }
        
        .alert {
            padding: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
        }
        
        .alert-error {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
            border: 1px solid #f56565;
        }

        /* ▼▼▼ 4. 필수 입력(*) 마크 빨간색 스타일 추가 ▼▼▼ */
        .required-mark {
            color: var(--color-red); /* CSS 변수 사용 */
            margin-left: 2px; /* 라벨 텍스트와 약간 간격 띄우기 */
        }
        
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
    <div class="page-wrapper">
        
        <div class="property-detail-column">
            <c:if test="${not empty property}">
				<div class="detail-images">
                    <c:if test="${not empty thumbnail and not empty thumbnail.imgPath}">
                        <img src="${pageContext.request.contextPath}${thumbnail.imgPath}" alt="매물 썸네일" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/property/placeholder.jpg';">
                    </c:if>
                    <c:if test="${empty thumbnail or empty thumbnail.imgPath}">
                        <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=500&h=300&fit=crop" alt="기본 이미지">
                    </c:if>
                </div>
                
                <div class="detail-info">
                    <div class="detail-price">
                        보증금 <fmt:formatNumber value="${property.deposit}" pattern="#,###" /> / 
                        월세 <fmt:formatNumber value="${property.monthlyRent}" pattern="#,###" />
                    </div>
                    <div class="detail-title">${property.propertyName}</div>
                    <div class="detail-location">
                        📍 ${property.roadAddress} ${property.addressDetail}
                    </div>

					<div class="detail-section">
                        <h3>기본 정보</h3>
						<div class="detail-grid">
                            <div class="detail-item">
                                <span class="detail-item-label">방 종류</span>
                                <span class="detail-item-value">
                                    <c:choose>
                                        <c:when test="${property.propertyType == 'oneRoom'}">원룸</c:when>
                                        <c:when test="${property.propertyType == 'twoRoom'}">투룸</c:when>
                                        <c:when test="${property.propertyType == 'threeRoom'}">쓰리룸</c:when>
                                        <c:when test="${property.propertyType == 'office'}">오피스텔</c:when>
                                        <c:otherwise>${property.propertyType}</c:otherwise> 
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-item-label">전용면적</span>
                                <span class="detail-item-value">${property.contractArea}㎡</span>
                            </div>

                            <div class="detail-item">
                                <span class="detail-item-label">층수</span>
                                <span class="detail-item-value">
                                    <c:choose>
                                        <c:when test="${not empty property.floor and not empty property.totalFloor}">
                                            ${property.floor}층 / 총 ${property.totalFloor}층
                                        </c:when>
                                        <c:when test="${not empty property.floor}">
                                            ${property.floor}층
                                        </c:when>
                                        <c:when test="${not empty property.totalFloor}">
                                            총 ${property.totalFloor}층
                                        </c:when>
                                        <c:otherwise>정보 없음</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="detail-item">
                                <span class="detail-item-label">관리비</span>
                                <span class="detail-item-value">
                                    <fmt:formatNumber value="${property.maintenanceFee}" pattern="#,###" />만
                                </span>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty options}">
                        <div class="detail-section">
                            <h3>옵션</h3>
                            <div class="detail-options">
                                <c:if test="${options.airConditioner == 'Y'}"><span class="detail-option">에어컨</span></c:if>
                                <c:if test="${options.heater == 'Y'}"><span class="detail-option">히터</span></c:if>
                                <c:if test="${options.refrigerator == 'Y'}"><span class="detail-option">냉장고</span></c:if>
                                <c:if test="${options.microwave == 'Y'}"><span class="detail-option">전자레인지</span></c:if>
                                <c:if test="${options.induction == 'Y'}"><span class="detail-option">인덕션</span></c:if>
                                <c:if test="${options.gasStove == 'Y'}"><span class="detail-option">가스레인지</span></c:if>
                                <c:if test="${options.washer == 'Y'}"><span class="detail-option">세탁기</span></c:if>
                                <c:if test="${options.dryer == 'Y'}"><span class="detail-option">건조기</span></c:if>
                                <c:if test="${options.bed == 'Y'}"><span class="detail-option">침대</span></c:if>
                                <c:if test="${options.desk == 'Y'}"><span class="detail-option">책상</span></c:if>
                                <c:if test="${options.wardrobe == 'Y'}"><span class="detail-option">옷장</span></c:if>
                                <c:if test="${options.shoeRack == 'Y'}"><span class="detail-option">신발장</span></c:if>
                                <c:if test="${options.tv == 'Y'}"><span class="detail-option">TV</span></c:if>
                                <c:if test="${options.parking == 'Y'}"><span class="detail-option">주차가능</span></c:if>
                                <c:if test="${options.elevator == 'Y'}"><span class="detail-option">엘리베이터</span></c:if>
                                <c:if test="${options.security == 'Y'}"><span class="detail-option">보안시스템</span></c:if>
                                <c:if test="${options.petAllowed == 'Y'}"><span class="detail-option">반려동물</span></c:if>
                            </div>
                        </div>
                    </c:if>

                    <div class="detail-section">
                        <h3>상세 설명</h3>
                        <div class="detail-description">
                            ${property.description}
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty property}">
                <div class="detail-info">
                    <div class="detail-title">매물 정보를 불러올 수 없습니다.</div>
                    <div class="detail-description">
                        이전 페이지로 돌아가 다시 시도해 주세요.
                    </div>
                </div>
            </c:if>
        </div>

        <div class="inquiry-form-column">
            <h2 class="page-title">
                <i class="fa-solid fa-comment-dots"></i>
                중개사 문의하기
            </h2>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/inquiry/realtor" method="post" style="display: flex; flex-direction: column; flex-grow: 1;">
                
                <input type="hidden" name="propertyId" value="${property.propertyNo}">
                <input type="hidden" name="realtorId" value="${property.realtorId}">
                <input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">
                <input type="hidden" name="inquiryType" value="REALTOR">

                <div class="form-group">
                    <%-- ▼▼▼ 5. 별표(*)를 span 태그로 감싸기 ▼▼▼ --%>
                    <label for="contactPhone" class="form-label">연락처<span class="required-mark">*</span></label>
                    <input type="tel" 
                           id="contactPhone" 
                           name="contactPhone" 
                           class="form-control" 
                           value="${sessionScope.loginUser.userPhone}" required>
                </div>
                <div class="form-group">
                    <%-- ▼▼▼ 6. 별표(*)를 span 태그로 감싸기 ▼▼▼ --%>
                    <label for="inquiryTitle" class="form-label">제목<span class="required-mark">*</span></label>
                    <input type="text" 
                           id="inquiryTitle" 
                           name="inquiryTitle"
                           class="form-control" 
                           placeholder="제목을 입력하세요 (예: ${property.propertyName} 문의합니다)" 
                           required>
                </div>
                
                <div class="form-group" style="flex-grow: 1; display: flex; flex-direction: column;">
                    <%-- ▼▼▼ 7. 별표(*)를 span 태그로 감싸기 ▼▼▼ --%>
                    <label for="inquiryContent" class="form-label">내용<span class="required-mark">*</span></label>
                    <textarea id="inquiryContent" 
                              name="inquiryContent" 
                              class="form-control" 
                              placeholder="문의 할 내용을 입력하세요 (예: 방문 희망 시간: 평일 6시 이후)" 
                              required style="flex-grow: 1;"></textarea>
                </div>
                
                <div class="btn-area">
                    <a href="javascript:history.back()" class="btn-secondary">
                        <i class="fa-solid fa-arrow-left"></i> 취소
                    </a>
                    <button type="submit" class="btn-primary">
                        <i class="fa-solid fa-paper-plane"></i> 문의하기
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
</body>
</html>