<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 문의하기 - UNILAND</title>
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
            --text-tertiary: #666;
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-tag: #f5f5f5;
            --border-light: #e5e5e5;
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
        
        .container {
            max-width: 900px;
            margin: var(--spacing-3xl) auto;
            padding: var(--spacing-2xl);
            background: var(--bg-white);
            border-radius: var(--radius-lg);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .page-header {
            margin-bottom: var(--spacing-2xl);
            padding-bottom: var(--spacing-lg);
            border-bottom: 2px solid var(--border-light);
        }
        
        .page-title {
            font-size: var(--font-2xl);
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: var(--spacing-sm);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .page-subtitle {
            font-size: var(--font-md);
            color: var(--text-tertiary);
            line-height: 1.6;
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
        
        .required {
            color: #f56565;
            margin-left: 4px;
        }
        
        .form-control {
            width: 100%;
            padding: var(--spacing-sm) var(--spacing-md);
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            transition: all 0.3s;
            font-family: inherit;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .form-select {
            width: 100%;
            padding: var(--spacing-sm) var(--spacing-md);
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            cursor: pointer;
            transition: all 0.3s;
            background: var(--bg-white);
            font-family: inherit;
        }
        
        .form-select:focus {
            outline: none;
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        textarea.form-control {
            min-height: 300px;
            resize: vertical;
            line-height: 1.6;
        }
        
        .info-box {
            background: #f0f4ff;
            border-left: 4px solid var(--primary-purple);
            padding: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
            border-radius: var(--radius-md);
        }
        
        .info-box-title {
            font-size: var(--font-md);
            font-weight: 600;
            color: var(--primary-purple);
            margin-bottom: var(--spacing-sm);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .info-box-content {
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.6;
        }
        
        .info-box-content ul {
            margin-left: 20px;
            margin-top: 8px;
        }
        
        .info-box-content li {
            margin-bottom: 4px;
        }
        
        .btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: var(--spacing-2xl);
            padding-top: var(--spacing-lg);
            border-top: 2px solid var(--border-light);
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
            border: 2px solid var(--primary-purple);
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
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .alert-error {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
            border: 1px solid #f56565;
        }
        
        .alert-success {
            background: rgba(72, 187, 120, 0.1);
            color: #48bb78;
            border: 1px solid #48bb78;
        }
        
        .char-counter {
            text-align: right;
            font-size: 13px;
            color: var(--text-tertiary);
            margin-top: 4px;
        }

        /* 허위매물신고 검색 영역 */
        .property-search-area {
            display: none;
            margin-top: var(--spacing-md);
            padding: var(--spacing-md);
            background: #f7fafc;
            border-radius: var(--radius-md);
            border: 1px solid #e2e8f0;
        }

        .property-search-area.active {
            display: block;
        }

        .search-input-group {
            display: flex;
            gap: 10px;
            margin-bottom: var(--spacing-md);
        }

        .btn-search {
            padding: var(--spacing-sm) var(--spacing-lg);
            background: var(--primary-purple);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
        }

        .btn-search:hover {
            background: var(--primary-dark);
        }

        .property-result {
            display: none;
            padding: var(--spacing-md);
            background: white;
            border-radius: var(--radius-md);
            border: 2px solid var(--primary-purple);
        }

        .property-result.active {
            display: block;
        }

        .property-result-title {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .property-result-info {
            font-size: 13px;
            color: var(--text-tertiary);
        }
    </style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fa-solid fa-headset"></i>
                관리자에게 문의하기
            </h1>
            <p class="page-subtitle">
                서비스 이용 중 불편한 점이나 건의사항이 있으시면 언제든지 문의해 주세요. 
                관리자가 확인 후 빠르게 답변드리겠습니다.
            </p>
        </div>
        
        <!-- 에러/성공 메시지 -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i>
                ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i>
                ${message}
            </div>
        </c:if>
        
        <!-- 안내 박스 -->
        <div class="info-box">
            <div class="info-box-title">
                <i class="fa-solid fa-lightbulb"></i>
                문의 전 확인해주세요
            </div>
            <div class="info-box-content">
                <ul>
                    <li>문의 내용은 관리자만 확인할 수 있습니다.</li>
                    <li>답변은 영업일 기준 1~2일 내에 등록하신 이메일 또는 마이페이지에서 확인하실 수 있습니다.</li>
                    <li>허위 매물 신고는 해당 매물 정보를 선택하여 신고해주세요.</li>
                    <li>긴급한 사항은 고객센터(1588-0000)로 연락 주시기 바랍니다.</li>
                </ul>
            </div>
        </div>
        
        <!-- 문의 작성 폼 -->
        <form action="${pageContext.request.contextPath}/inquiries/contact-admin" method="post" id="inquiryForm">
            <!-- 허위매물신고 시 매물 ID (선택사항) -->
            <input type="hidden" name="propertyId" id="selectedPropertyId" value="">
            
            <div class="form-group">
                <label for="category" class="form-label">
                    문의 유형<span class="required">*</span>
                </label>
                <select id="category" name="category" class="form-select" required>
                    <option value="">문의 유형을 선택하세요</option>
                    <option value="일반문의">일반문의</option>
                    <option value="건의사항">건의사항</option>
                    <option value="허위매물신고">허위매물신고</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <!-- 허위매물신고 선택 시 매물 검색 영역 -->
            <div id="propertySearchArea" class="property-search-area">
                <label class="form-label">
                    <i class="fa-solid fa-search"></i> 신고할 매물 검색
                </label>
                <div class="search-input-group">
                    <input type="text" 
                           id="propertySearchInput" 
                           class="form-control" 
                           placeholder="매물 번호 또는 매물명을 입력하세요">
                    <button type="button" class="btn-search" onclick="searchProperty()">
                        <i class="fa-solid fa-search"></i> 검색
                    </button>
                </div>
                <div id="propertyResult" class="property-result">
                    <div class="property-result-title" id="propertyName"></div>
                    <div class="property-result-info" id="propertyInfo"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="title" class="form-label">
                    제목<span class="required">*</span>
                </label>
                <input type="text" 
                       id="title" 
                       name="title" 
                       class="form-control" 
                       placeholder="문의 제목을 입력하세요 (최대 200자)"
                       maxlength="200"
                       required>
                <div class="char-counter">
                    <span id="titleCount">0</span> / 200
                </div>
            </div>
            
            <div class="form-group">
                <label for="content" class="form-label">
                    문의 내용<span class="required">*</span>
                </label>
                <textarea id="content" 
                          name="content" 
                          class="form-control" 
                          placeholder="문의하실 내용을 상세히 입력해주세요.&#10;&#10;※ 개인정보(주민번호, 계좌번호 등)는 입력하지 마세요."
                          required></textarea>
                <div class="char-counter">
                    <span id="contentCount">0</span>자
                </div>
            </div>
            
            <div class="btn-area">
                <a href="${pageContext.request.contextPath}/mypage?tab=inquiries" class="btn-secondary">
                    <i class="fa-solid fa-arrow-left"></i> 취소
                </a>
                <button type="submit" class="btn-primary">
                    <i class="fa-solid fa-paper-plane"></i> 문의하기
                </button>
            </div>
        </form>
    </div>
    
    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        // 글자 수 카운터
        const titleInput = document.getElementById('title');
        const titleCount = document.getElementById('titleCount');
        const contentTextarea = document.getElementById('content');
        const contentCount = document.getElementById('contentCount');
        
        titleInput.addEventListener('input', function() {
            titleCount.textContent = this.value.length;
        });
        
        contentTextarea.addEventListener('input', function() {
            contentCount.textContent = this.value.length;
        });
        
        // 카테고리 변경 시 허위매물신고 검색 영역 표시/숨김
        const categorySelect = document.getElementById('category');
        const propertySearchArea = document.getElementById('propertySearchArea');
        
        categorySelect.addEventListener('change', function() {
            if (this.value === '허위매물신고') {
                propertySearchArea.classList.add('active');
            } else {
                propertySearchArea.classList.remove('active');
                document.getElementById('propertyResult').classList.remove('active');
                document.getElementById('selectedPropertyId').value = '';
            }
        });
        
        // 매물 검색 (실제 구현 시 AJAX로 서버에서 조회)
        function searchProperty() {
            const searchInput = document.getElementById('propertySearchInput').value.trim();
            
            if (!searchInput) {
                alert('매물 번호 또는 매물명을 입력하세요.');
                return;
            }
            
            // TODO: 실제 구현 시 AJAX로 서버에서 매물 정보 조회
            // 임시 데모용 코드
            const propertyResult = document.getElementById('propertyResult');
            const propertyName = document.getElementById('propertyName');
            const propertyInfo = document.getElementById('propertyInfo');
            
            // 샘플 데이터 (실제로는 서버에서 조회)
            propertyName.textContent = '강남구 역삼동 원룸';
            propertyInfo.textContent = '매물번호: 12345 | 보증금: 1000만원 / 월세: 50만원';
            document.getElementById('selectedPropertyId').value = '12345';
            
            propertyResult.classList.add('active');
        }
        
        // 폼 제출 전 유효성 검사
        document.getElementById('inquiryForm').addEventListener('submit', function(e) {
            const category = document.getElementById('category').value;
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            const propertyId = document.getElementById('selectedPropertyId').value;
            
            if (!category) {
                e.preventDefault();
                alert('문의 유형을 선택해주세요.');
                return false;
            }
            
            if (!title) {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                return false;
            }
            
            if (title.length < 5) {
                e.preventDefault();
                alert('제목을 5자 이상 입력해주세요.');
                return false;
            }
            
            if (!content) {
                e.preventDefault();
                alert('문의 내용을 입력해주세요.');
                return false;
            }
            
            if (content.length < 10) {
                e.preventDefault();
                alert('문의 내용을 10자 이상 입력해주세요.');
                return false;
            }
            
            // 허위매물신고인 경우 매물 선택 확인
            if (category === '허위매물신고' && !propertyId) {
                e.preventDefault();
                alert('신고할 매물을 검색하여 선택해주세요.');
                return false;
            }
            
            return confirm('문의를 등록하시겠습니까?');
        });
    </script>
</body>
</html>