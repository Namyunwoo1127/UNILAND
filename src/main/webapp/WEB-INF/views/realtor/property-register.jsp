<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매물 등록 - UNILAND</title>
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

        header {
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
            text-decoration: none;
        }

        .logo img {
            width: 140px;
            height: auto;
            object-fit: contain;
            display: block;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-name {
            font-weight: 600;
            color: #2d3748;
        }

        .btn-logout {
            padding: 8px 20px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-logout:hover {
            background: #f7fafc;
        }

        .main-layout {
            display: flex;
            max-width: 1400px;
            margin: 0 auto;
            min-height: calc(100vh - 80px);
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

        .form-input::placeholder {
            color: #a0aec0;
        }

        .form-textarea {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            min-height: 120px;
            resize: vertical;
            font-family: inherit;
            transition: border-color 0.3s;
        }

        .form-textarea:focus {
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

        .address-group {
            display: flex;
            gap: 10px;
        }

        .address-group input {
            flex: 1;
        }

        .btn-search {
            padding: 12px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
        }

        .btn-search:hover {
            background: #5568d3;
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

        .photo-upload-area {
            border: 3px dashed #e2e8f0;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .photo-upload-area:hover {
            border-color: #667eea;
            background: #f7fafc;
        }

        .upload-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .upload-text {
            font-size: 16px;
            color: #2d3748;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .upload-hint {
            font-size: 14px;
            color: #718096;
        }

        .photo-input {
            display: none;
        }

        .photo-preview-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        .photo-preview {
            position: relative;
            aspect-ratio: 1;
            border-radius: 8px;
            background: #e2e8f0;
            overflow: hidden;
        }

        .photo-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
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
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        .form-hint {
            font-size: 13px;
            color: #718096;
            margin-top: 8px;
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

        .character-count {
            text-align: right;
            font-size: 13px;
            color: #718096;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="logo-icon">
                <a href="${pageContext.request.contextPath}/realtor/realtor-dashboard" class="logo">
                		<img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
            		</a>
         	</div>
            <div class="user-info">
                <span class="user-name">${sessionScope.loginRealtor.realtorName} 중개사님</span>
                <button class="btn-logout" onclick="alert('로그아웃되었습니다.'); location.href='${pageContext.request.contextPath}/auth/logout';">
                    로그아웃
                </button>
            </div>
        </div>
    </header>

    <div class="main-layout">
        <aside class="sidebar">
            <div class="sidebar-title">중개사 메뉴</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/realtor/realtor-dashboard"><span class="menu-icon">📊</span>대시보드</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/property-management"><span class="menu-icon">🏢</span>매물 관리</a></li>
                <li><a href="#" class="active"><span class="menu-icon">➕</span>매물 등록</a></li>
                <li><a href="${pageContext.request.contextPath}/realtor/inquiry-management"><span class="menu-icon">💬</span>받은 문의</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>매물 등록</h1>
                <p>새로운 매물 정보를 등록하세요</p>
            </div>

            <form class="form-container">
                <!-- 기본 정보 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📝</span>
                        기본 정보
                    </h2>
                    <div class="form-row single">
                        <div class="form-group">
                            <label class="form-label">매물 제목<span class="required">*</span></label>
                            <input type="text" class="form-input" placeholder="예) 신촌역 5분거리 풀옵션 원룸">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">매물 유형<span class="required">*</span></label>
                            <select class="form-select">
                                <option>선택하세요</option>
                                <option>원룸</option>
                                <option>투룸</option>
                                <option>쓰리룸</option>
                                <option>오피스텔</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">거래 유형<span class="required">*</span></label>
                            <select class="form-select">
                                <option>선택하세요</option>
                                <option>월세</option>
                                <option>전세</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 가격 정보 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">💰</span>
                        가격 정보
                    </h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">보증금<span class="required">*</span></label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" placeholder="500">
                                <span class="suffix-text">만원</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">월세<span class="required">*</span></label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" placeholder="55">
                                <span class="suffix-text">만원</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">관리비</label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" placeholder="5">
                                <span class="suffix-text">만원</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">관리비 포함 항목</label>
                            <select class="form-select" multiple style="height: 100px;">
                                <option>수도</option>
                                <option>전기</option>
                                <option>가스</option>
                                <option>인터넷</option>
                            </select>
                            <span class="form-hint">Ctrl 또는 Cmd 키를 누른 채로 다중 선택 가능</span>
                        </div>
                    </div>
                </div>

                <!-- 위치 정보 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📍</span>
                        위치 정보
                    </h2>
                    <div class="form-row single">
                        <div class="form-group">
                            <label class="form-label">주소<span class="required">*</span></label>
                            <div class="address-group">
                                <input type="text" class="form-input" placeholder="도로명 주소를 검색하세요" readonly>
                                <button type="button" class="btn-search">주소 검색</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-row single">
                        <div class="form-group">
                            <label class="form-label">상세 주소</label>
                            <input type="text" class="form-input" placeholder="동, 호수 입력 (선택)">
                        </div>
                    </div>
                </div>

                <!-- 상세 정보 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">🏠</span>
                        상세 정보
                    </h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">전용면적<span class="required">*</span></label>
                            <div class="input-suffix">
                                <input type="number" class="form-input" placeholder="20">
                                <span class="suffix-text">㎡</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">방 개수<span class="required">*</span></label>
                            <select class="form-select">
                                <option>선택하세요</option>
                                <option>1개</option>
                                <option>2개</option>
                                <option>3개</option>
                                <option>4개 이상</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">화장실 개수<span class="required">*</span></label>
                            <select class="form-select">
                                <option>선택하세요</option>
                                <option>1개</option>
                                <option>2개</option>
                                <option>3개 이상</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">입주가능일<span class="required">*</span></label>
                            <input type="date" class="form-input">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">층수<span class="required">*</span></label>
                            <input type="number" class="form-input" placeholder="3">
                        </div>
                        <div class="form-group">
                            <label class="form-label">건물 총 층수<span class="required">*</span></label>
                            <input type="number" class="form-input" placeholder="5">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">건축년도</label>
                            <input type="number" class="form-input" placeholder="2020">
                        </div>
                        <div class="form-group"></div>
                    </div>
                </div>

                <!-- 옵션 정보 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">✨</span>
                        옵션 정보
                    </h2>
                    <div class="form-group">
                        <label class="form-label">냉난방</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt1" class="option-checkbox">
                            <label for="opt1" class="option-label">에어컨</label>
                            <input type="checkbox" id="opt2" class="option-checkbox">
                            <label for="opt2" class="option-label">히터</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">주방</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt3" class="option-checkbox">
                            <label for="opt3" class="option-label">냉장고</label>
                            <input type="checkbox" id="opt4" class="option-checkbox">
                            <label for="opt4" class="option-label">전자레인지</label>
                            <input type="checkbox" id="opt5" class="option-checkbox">
                            <label for="opt5" class="option-label">인덕션</label>
                            <input type="checkbox" id="opt6" class="option-checkbox">
                            <label for="opt6" class="option-label">가스레인지</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">가구/가전</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt7" class="option-checkbox">
                            <label for="opt7" class="option-label">세탁기</label>
                            <input type="checkbox" id="opt8" class="option-checkbox">
                            <label for="opt8" class="option-label">건조기</label>
                            <input type="checkbox" id="opt9" class="option-checkbox">
                            <label for="opt9" class="option-label">침대</label>
                            <input type="checkbox" id="opt10" class="option-checkbox">
                            <label for="opt10" class="option-label">책상</label>
                            <input type="checkbox" id="opt11" class="option-checkbox">
                            <label for="opt11" class="option-label">옷장</label>
                            <input type="checkbox" id="opt12" class="option-checkbox">
                            <label for="opt12" class="option-label">신발장</label>
                            <input type="checkbox" id="opt13" class="option-checkbox">
                            <label for="opt13" class="option-label">TV</label>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 20px;">
                        <label class="form-label">시설</label>
                        <div class="option-grid">
                            <input type="checkbox" id="opt13" class="option-checkbox">
                            <label for="opt13" class="option-label">주차 가능</label>
                            <input type="checkbox" id="opt14" class="option-checkbox">
                            <label for="opt14" class="option-label">엘리베이터</label>
                            <input type="checkbox" id="opt15" class="option-checkbox">
                            <label for="opt15" class="option-label">보안시스템</label>
                            <input type="checkbox" id="opt16" class="option-checkbox">
                            <label for="opt16" class="option-label">반려동물</label>
                        </div>
                    </div>
                </div>

                <!-- 대학생 특화 옵션 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">🎓</span>
                        대학생 특화 옵션
                    </h2>
                    <div class="form-row">
                        <div class="form-group">
                            <div class="option-grid">
                                <input type="checkbox" id="student1" class="option-checkbox">
                                <label for="student1" class="option-label">학생 우대</label>
                                <input type="checkbox" id="student2" class="option-checkbox">
                                <label for="student2" class="option-label">단기 계약 가능</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 매물 설명 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📄</span>
                        매물 설명
                    </h2>
                    <div class="form-group">
                        <label class="form-label">상세 설명<span class="required">*</span></label>
                        <textarea class="form-textarea" placeholder="매물에 대한 자세한 설명을 입력하세요. (최대 1000자)" maxlength="1000"></textarea>
                        <div class="character-count">0 / 1000</div>
                    </div>
                </div>

                <!-- 매물 사진 -->
                <div class="form-section">
                    <h2 class="section-title">
                        <span class="section-icon">📸</span>
                        매물 사진
                    </h2>
                    <div class="form-group">
                        <label class="form-label">사진 업로드<span class="required">*</span> (최소 1장, 최대 10장)</label>
                        <div class="photo-upload-area" onclick="document.getElementById('photoInput').click()">
                            <div class="upload-icon">📷</div>
                            <div class="upload-text">클릭하여 사진 업로드</div>
                            <div class="upload-hint">JPG, PNG 파일 (최대 5MB)</div>
                        </div>
                        <input type="file" id="photoInput" class="photo-input" accept="image/*" multiple>
                        <div class="photo-preview-grid" style="display: none;">
                            <div class="photo-preview">
                                <span class="photo-badge">대표</span>
                                <button type="button" class="photo-remove">×</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 버튼 -->
                <div class="button-group">
                    <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                    <button type="submit" class="btn-submit">매물 등록하기</button>
                </div>
            </form>
        </main>
    </div>

    <script>
        // 글자 수 카운터
        const textarea = document.querySelector('.form-textarea');
        const charCount = document.querySelector('.character-count');
        
        textarea.addEventListener('input', function() {
            charCount.textContent = this.value.length + ' / 1000';
        });
    </script>
</body>
</html>