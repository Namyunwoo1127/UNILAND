<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매물 수정 - UNILAND</title>
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

        .info-box {
            background: #ebf8ff;
            border-left: 4px solid #4299e1;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .info-box-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .info-box-left h3 {
            font-size: 18px;
            color: #2c5282;
            margin-bottom: 10px;
        }

        .info-stats {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #2d3748;
        }

        .info-stats span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .form-section {
            margin-bottom: 40px;
            padding-bottom: 40px;
            border-bottom: 2px solid #e2e8f0;
        }

        .form-section:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-row.single {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .required {
            color: #f56565;
            margin-left: 4px;
        }

        .form-input {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-select {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: white;
            transition: border-color 0.3s;
        }

        .form-select:focus {
            outline: none;
            border-color: #667eea;
        }

        .input-suffix {
            position: relative;
        }

        .input-suffix input {
            padding-right: 50px;
        }

        .suffix-text {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 14px;
            font-weight: 600;
        }

        .form-textarea {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            min-height: 150px;
            resize: vertical;
            font-family: inherit;
            transition: border-color 0.3s;
        }

        .form-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .character-count {
            text-align: right;
            font-size: 13px;
            color: #718096;
            margin-top: 5px;
        }

        .option-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
        }

        .option-checkbox {
            display: none;
        }

        .option-label {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
        }

        .option-checkbox:checked + .option-label {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }

        .option-label:hover {
            border-color: #cbd5e0;
        }

        .photo-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
        }

        .photo-item {
            position: relative;
            aspect-ratio: 1;
            border-radius: 8px;
            background: linear-gradient(135deg, #e0e7ff 0%, #f3e8ff 100%);
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            border: 2px solid #e2e8f0;
        }

        .photo-badge {
            position: absolute;
            top: 8px;
            left: 8px;
            background: #667eea;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
        }

        .photo-remove {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 24px;
            height: 24px;
            background: rgba(0,0,0,0.7);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .photo-controls {
            position: absolute;
            bottom: 8px;
            left: 8px;
            right: 8px;
            display: flex;
            gap: 5px;
            justify-content: center;
        }

        .photo-control-btn {
            background: rgba(0,0,0,0.7);
            color: white;
            border: none;
            padding: 4px 8px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .photo-add {
            border: 3px dashed #cbd5e0;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }

        .photo-add:hover {
            border-color: #667eea;
            background: #f7fafc;
        }

        .photo-input {
            display: none;
        }

        .detail-link {
            text-align: center;
            margin-top: 20px;
        }

        .btn-detail {
            color: #667eea;
            font-size: 14px;
            cursor: pointer;
            text-decoration: underline;
        }

        .btn-detail:hover {
            color: #5568d3;
        }

        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
            padding-top: 40px;
            border-top: 2px solid #e2e8f0;
        }

        .btn-submit {
            padding: 16px 48px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .btn-cancel {
            padding: 16px 48px;
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #f7fafc;
        }

        .btn-delete {
            padding: 16px 48px;
            background: #fff5f5;
            color: #f56565;
            border: 2px solid #feb2b2;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-delete:hover {
            background: #fed7d7;
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
                <li><a href="${pageContext.request.contextPath}/realtor/property-management" class="active"><span class="menu-icon">🏢</span>매물 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-register"><span class="menu-icon">➕</span>매물 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/inquiry-management"><span class="menu-icon">💬</span>받은 문의</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>매물 수정</h1>
                <p>자주 수정하는 항목만 빠르게 변경하세요</p>
            </div>

            <div class="info-box">
                <div class="info-box-content">
                    <div class="info-box-left">
                        <h3>📌 ${property.propertyName}</h3>
                        <div class="info-stats">
                            <span>📅 등록일: <fmt:formatDate value="${property.createdAt}" pattern="yyyy.MM.dd"/></span>
                            <span>👁️ 조회수: ${property.views != null ? property.views : 0}</span>
                            <span>❤️ 찜: ${property.likes != null ? property.likes : 0}</span>
                            <span>💬 문의: 0건</span>
                        </div>
                    </div>
                </div>
            </div>

            <form class="form-container" action="${pageContext.request.contextPath}/realtor/property-edit" method="POST">
                <input type="hidden" name="id" value="${property.propertyNo}">
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">🏷️</span>
                        매물 상태
                    </h2>
                    <div class="form-row single">
                        <div class="form-group">
                            <label class="form-label">상태 변경<span class="required">*</span></label>
                            <select class="form-select" name="status">
                                <option value="ACTIVE" ${property.status == 'ACTIVE' ? 'selected' : ''}>판매중</option>
                                <option value="RESERVED" ${property.status == 'RESERVED' ? 'selected' : ''}>예약중</option>
                                <option value="COMPLETED" ${property.status == 'COMPLETED' ? 'selected' : ''}>거래완료</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📝</span>
                        기본 정보
                    </h2>
                    <div class="form-row single">
                        <div class="form-group">
                            <label class="form-label">매물 제목<span class="required">*</span></label>
                            <input type="text" class="form-input" name="propertyName" value="${property.propertyName}">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">💰</span>
                        가격 정보
                    </h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">보증금<span class="required">*</span></label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" name="deposit" value="${property.deposit}">
                                <span class="suffix-text">만원</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">월세<span class="required">*</span></label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" name="monthlyRent" value="${property.monthlyRent}">
                                <span class="suffix-text">만원</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">관리비</label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" name="maintenanceFee" value="${property.maintenanceFee != null ? property.maintenanceFee : 0}">
                                <span class="suffix-text">만원</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">입주가능일</label>
                            <input type="text" class="form-input" name="availableDate" value="${property.availableDate}">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">✨</span>
                        옵션 정보
                    </h2>

                    <c:set var="option" value="${not empty options ? options[0] : null}" />

                    <div class="form-group">
                        <label class="form-label">냉난방</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt1" name="airConditioner" value="Y" class="option-checkbox" ${option != null && option.airConditioner == 'Y' ? 'checked' : ''}>
                            <label for="opt1" class="option-label">에어컨</label>
                            <input type="checkbox" id="opt2" name="heater" value="Y" class="option-checkbox" ${option != null && option.heater == 'Y' ? 'checked' : ''}>
                            <label for="opt2" class="option-label">히터</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">주방</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt3" name="refrigerator" value="Y" class="option-checkbox" ${option != null && option.refrigerator == 'Y' ? 'checked' : ''}>
                            <label for="opt3" class="option-label">냉장고</label>
                            <input type="checkbox" id="opt4" name="microwave" value="Y" class="option-checkbox" ${option != null && option.microwave == 'Y' ? 'checked' : ''}>
                            <label for="opt4" class="option-label">전자레인지</label>
                            <input type="checkbox" id="opt5" name="induction" value="Y" class="option-checkbox" ${option != null && option.induction == 'Y' ? 'checked' : ''}>
                            <label for="opt5" class="option-label">인덕션</label>
                            <input type="checkbox" id="opt6" name="gasStove" value="Y" class="option-checkbox" ${option != null && option.gasStove == 'Y' ? 'checked' : ''}>
                            <label for="opt6" class="option-label">가스레인지</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">세탁</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt7" name="washer" value="Y" class="option-checkbox" ${option != null && option.washer == 'Y' ? 'checked' : ''}>
                            <label for="opt7" class="option-label">세탁기</label>
                            <input type="checkbox" id="opt8" name="dryer" value="Y" class="option-checkbox" ${option != null && option.dryer == 'Y' ? 'checked' : ''}>
                            <label for="opt8" class="option-label">건조기</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">가구</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt9" name="bed" value="Y" class="option-checkbox" ${option != null && option.bed == 'Y' ? 'checked' : ''}>
                            <label for="opt9" class="option-label">침대</label>
                            <input type="checkbox" id="opt10" name="desk" value="Y" class="option-checkbox" ${option != null && option.desk == 'Y' ? 'checked' : ''}>
                            <label for="opt10" class="option-label">책상</label>
                            <input type="checkbox" id="opt11" name="wardrobe" value="Y" class="option-checkbox" ${option != null && option.wardrobe == 'Y' ? 'checked' : ''}>
                            <label for="opt11" class="option-label">옷장</label>
                            <input type="checkbox" id="opt12" name="shoeRack" value="Y" class="option-checkbox" ${option != null && option.shoeRack == 'Y' ? 'checked' : ''}>
                            <label for="opt12" class="option-label">신발장</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">가전</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt13" name="tv" value="Y" class="option-checkbox" ${option != null && option.tv == 'Y' ? 'checked' : ''}>
                            <label for="opt13" class="option-label">TV</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">시설</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt14" name="parking" value="Y" class="option-checkbox" ${option != null && option.parking == 'Y' ? 'checked' : ''}>
                            <label for="opt14" class="option-label">주차 가능</label>
                            <input type="checkbox" id="opt15" name="elevator" value="Y" class="option-checkbox" ${option != null && option.elevator == 'Y' ? 'checked' : ''}>
                            <label for="opt15" class="option-label">엘리베이터</label>
                            <input type="checkbox" id="opt16" name="security" value="Y" class="option-checkbox" ${option != null && option.security == 'Y' ? 'checked' : ''}>
                            <label for="opt16" class="option-label">보안시스템</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">기타</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt17" name="petAllowed" value="Y" class="option-checkbox" ${option != null && option.petAllowed == 'Y' ? 'checked' : ''}>
                            <label for="opt17" class="option-label">반려동물 가능</label>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📄</span>
                        매물 설명
                    </h2>
                    <div class="form-group">
                        <label class="form-label">상세 설명<span class="required">*</span></label>
                        <textarea class="form-textarea" name="description" maxlength="1000">${property.description}</textarea>
                        <div class="character-count"><c:out value="${property.description != null ? property.description.length() : 0}"/> / 1000</div>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📸</span>
                        매물 사진
                    </h2>
                    <div class="photo-grid">
                        <c:choose>
                            <c:when test="${not empty images}">
                                <c:forEach var="img" items="${images}" varStatus="status">
                                    <div class="photo-item">
                                        <img src="${pageContext.request.contextPath}${img.imgPath}" alt="매물 사진 ${status.index + 1}" style="width: 100%; height: 100%; object-fit: cover;">
                                        <c:if test="${img.imgOrder == 0}">
                                            <span class="photo-badge">대표</span>
                                        </c:if>
                                        <button type="button" class="photo-remove">×</button>
                                        <div class="photo-controls">
                                            <button type="button" class="photo-control-btn">◀</button>
                                            <button type="button" class="photo-control-btn">▶</button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="photo-item">
                                    🏠
                                    <span class="photo-badge">대표</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="photo-item photo-add" onclick="document.getElementById('photoInput').click()">
                            ➕
                        </div>
                    </div>
                    <input type="file" id="photoInput" class="photo-input" accept="image/*" multiple>
                    <div class="detail-link">
                        <span class="btn-detail">면적, 층수 등 상세 정보 수정하기 →</span>
                    </div>
                </div>

                <div class="button-group">
                    <button type="button" class="btn-delete" onclick="if(confirm('정말 삭제하시겠습니까?')) alert('매물이 삭제되었습니다.')">매물 삭제</button>
                    <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                    <button type="submit" class="btn-submit">수정 완료</button>
                </div>
            </form>
        </main>
    </div>

    <script>
        const textarea = document.querySelector('.form-textarea');
        const charCount = document.querySelector('.character-count');
        
        textarea.addEventListener('input', function() {
            charCount.textContent = this.value.length + ' / 1000';
        });
    </script>
</body>
</html>