<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부동산 중개인 마이페이지 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* (원본 CSS — 절대 수정 금지) */
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

        /* 헤더 스타일 */
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
        
        .auth-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .auth-buttons a, .auth-buttons button {
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
        
        .auth-buttons a:hover, .auth-buttons button:hover {
            color: #667eea;
            background: #f5f5f5;
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

        /* 컨테이너 */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow: hidden;
            padding: 0 20px;
        }
        
        .tab-menu {
            display: flex;
            border-bottom: 2px solid #e0e0e0;
            background: #fafafa;
            margin: 0 -20px;
            padding: 0 20px;
        }
        
        .tab-item {
            flex: 1;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            color: #999;
            border-bottom: 3px solid transparent;
            transition: all 0.3s;
            position: relative;
        }
        
        .tab-item:hover {
            background: #f0f0f0;
            color: #333;
        }
        
        .tab-item.active {
            color: #667eea;
            border-bottom-color: #667eea;
            background: white;
        }
        
        .content-area {
            padding: 40px 0;
            min-height: 500px;
        }
        
        .content-section {
            display: none;
        }
        
        .content-section.active {
            display: block;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333;
        }
        
        .profile-section {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
            padding: 30px;
            background: #fafafa;
            border-radius: 8px;
        }
        
        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            flex-shrink: 0;
        }
        
        .profile-info {
            flex: 1;
        }
        
        .info-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .info-label {
            width: 100px;
            color: #666;
            font-weight: 500;
        }
        
        .info-value {
            color: #333;
            flex: 1;
        }
        
        .edit-btn-container {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        
        .btn-edit {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-edit:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            padding: 10px 20px;
            background: white;
            color: #667eea;
            border: 1px solid #667eea;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-secondary:hover {
            background: #f8f8f8;
        }
        
        .contract-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            background: white;
            transition: all 0.3s;
        }
        
        .contract-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .contract-status {
            display: inline-block;
            padding: 6px 12px;
            background: #e8e4f8;
            color: #667eea;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .contract-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }
        
        .contract-location {
            color: #667eea;
            font-weight: 500;
            font-size: 14px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .agent-info {
            background: #fafafa;
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        
        .agent-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .agent-row:last-child {
            border-bottom: none;
        }
        
        .agent-label {
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }
        
        .agent-value {
            color: #333;
            font-weight: 600;
        }
        
        .btn-chat {
            display: inline-block;
            padding: 8px 16px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-chat:hover {
            background: #5568d3;
        }
        
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            background: white;
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .card-image {
            width: 100%;
            height: 150px;
            background: #e0e0e0;
            border-radius: 4px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
        }
        
        .card-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        
        .card-desc {
            font-size: 14px;
            color: #666;
        }
        
        .list-item {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            border-bottom: 1px solid #eee;
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .list-item:hover {
            background: #fafafa;
        }
        
        .list-title {
            font-weight: 500;
            color: #333;
        }
        
        .list-date {
            color: #999;
            font-size: 14px;
        }
        
        .status-badge {
            font-weight: 500;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 13px;
        }
        
        .status-complete {
            color: #2c5ff5;
            background: #e8f1ff;
        }
        
        .status-pending {
            color: #ff6b6b;
            background: #ffe8e8;
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.active {
            display: flex;
        }
        
        .modal-content {
            background: white;
            padding: 40px;
            border-radius: 8px;
            max-width: 500px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .modal-buttons {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        
        .btn-save {
            flex: 1;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
        }
        
        .btn-cancel {
            flex: 1;
            padding: 12px;
            background: #f0f0f0;
            color: #333;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <!-- 통합된 헤더 -->
    <header>
        <div class="header-container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/realtor/realtor-dashboard">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
                </a>
            </div>
            <div class="auth-buttons">
                <!-- 컨트롤러에서 세션에 저장한 "loginRealtor" 객체의 realtorName을 사용하도록 수정 -->
                <button class="btn-mypage" 
                        onclick="location.href='${pageContext.request.contextPath}/realtor/realtor-mypage'">
                    ${sessionScope.loginRealtor.realtorName != null ? sessionScope.loginRealtor.realtorName : '중개사님'} 중개사님
                </button>
                <button class="btn-logout" 
                        onclick="location.href='${pageContext.request.contextPath}/realtor/logout'">
                    로그아웃
                </button>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="tab-menu">
            <div class="tab-item active" data-tab="mypage">마이페이지</div>
            <!-- 중개사 마이페이지는 보통 계약/찜/최근매물 대신 매물 관리, 문의 내역을 보여줍니다. -->
            <div class="tab-item" data-tab="property-management" onclick="location.href='${pageContext.request.contextPath}/realtor/property-management'">매물 관리</div>
            <div class="tab-item" data-tab="inquiry-management" onclick="location.href='${pageContext.request.contextPath}/realtor/inquiry-management'">받은 문의</div>
            <!-- 기존 탭들은 일반 사용자용이므로, 중개사에게 필요한 탭으로 변경하는 것이 좋습니다. -->
        </div>
        
        <div class="content-area">
            <!-- 마이페이지 -->
            <div class="content-section active" id="mypage">
                <div class="section-title">중개사 마이페이지</div>
                <div class="profile-section">
                    <!-- ✅ 수정: profileImage 속성 부재로 인한 오류를 피하기 위해 임시로 아이콘으로 대체 -->
                    <div class="profile-image">
                        <i class="fas fa-user-tie fa-3x"></i>
                    </div>
                    <div class="profile-info">
                        <!-- 전체 보기: 사용자가 볼 수 있도록 모든 주요 컬럼을 출력 -->
                        <div class="info-row">
                            <div class="info-label">중개사 ID</div>
                            <div class="info-value">${realtor.realtorId != null ? realtor.realtorId : 'REALTOR_001'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">사업자번호</div>
                            <div class="info-value">${realtor.businessNum != null ? realtor.businessNum : '123-45-67890'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">사무소 상호</div>
                            <div class="info-value">${realtor.officeName != null ? realtor.officeName : '우리공인중개사무소'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">대표 중개인</div>
                            <div class="info-value">${realtor.realtorName != null ? realtor.realtorName : '홍길동'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">사무소 주소</div>
                            <div class="info-value">${realtor.realtorAddress != null ? realtor.realtorAddress : '서울특별시 강남구 역삼동 123-45'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">연락처</div>
                            <div class="info-value">${realtor.realtorPhone != null ? realtor.realtorPhone : '010-1234-5678'}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">이메일</div>
                            <div class="info-value">${realtor.realtorEmail != null ? realtor.realtorEmail : 'realtor@example.com'}</div>
                        </div>
                        <!-- 비밀번호는 노출하지 않음(관리 목적이라면 별도 비밀번호 변경 UI 필요) -->
                        
                        <div class="edit-btn-container">
                            <!-- '회원 정보 수정' 클릭 시 수정 가능한 필드만 보여주는 모달 열기 -->
                            <button class="btn-edit" onclick="openEditModal()">회원 정보 수정</button>
                            <button class="btn-secondary" onclick="confirmDelete()">탈퇴</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- (나머지 탭들은 중개사 마이페이지 구조에 맞게 수정하거나 삭제하는 것이 좋습니다.) -->
            <!-- ... -->
            
            <!-- 샘플 탭 유지 (기존 코드 그대로 유지) -->
            <div class="content-section" id="contract">
                <div class="section-title">계약 현황 (일반 사용자 기능)</div>
            </div>
            <div class="content-section" id="wishlist">
                <div class="section-title">찜매물 (일반 사용자 기능)</div>
            </div>
            <div class="content-section" id="recent">
                <div class="section-title">최근 본 매물 (일반 사용자 기능)</div>
            </div>
            <div class="content-section" id="inquiries">
                <div class="section-title">내 문의내역 (일반 사용자 기능)</div>
            </div>

        </div>
    </div>
    
    <!-- 회원정보 수정 모달 (수정 가능: OFFICE_NAME, REALTOR_NAME, REALTOR_ADDRESS, REALTOR_PHONE, REALTOR_EMAIL) -->
    <div class="modal" id="editModal">
        <div class="modal-content">
            <div class="modal-title">회원 정보 수정</div>

            <!-- 경로 수정: /realtor/mypage/update -->
            <form action="${pageContext.request.contextPath}/realtor/mypage/update" method="post" id="updateForm">
                <input type="hidden" name="realtorId" value="${realtor.realtorId}" />
                <input type="hidden" name="businessNum" value="${realtor.businessNum}" />

                <!-- 읽기 전용 정보(노출만) -->
                <div class="form-group">
                    <label class="form-label">중개사 ID</label>
                    <input type="text" class="form-input" value="${realtor.realtorId != null ? realtor.realtorId : ''}" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">사업자등록번호</label>
                    <input type="text" class="form-input" value="${realtor.businessNum != null ? realtor.businessNum : ''}" readonly>
                </div>
                
                <div class="form-group">
                    <label class="form-label">사무소 상호</label>
                    <input type="text" name="officeName" class="form-input" value="${realtor.officeName != null ? realtor.officeName : ''}" placeholder="사무소 상호를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label class="form-label">대표 중개인 이름</label>
                    <input type="text" name="realtorName" class="form-input" value="${realtor.realtorName != null ? realtor.realtorName : ''}" placeholder="대표 중개인 이름을 입력하세요" required>
                </div>

                <div class="form-group">
                    <label class="form-label">사무소 주소</label>
                    <input type="text" name="realtorAddress" class="form-input" value="${realtor.realtorAddress != null ? realtor.realtorAddress : ''}" placeholder="사무소 주소를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label class="form-label">연락처</label>
                    <input type="tel" name="realtorPhone" class="form-input" value="${realtor.realtorPhone != null ? realtor.realtorPhone : ''}" placeholder="연락처를 입력하세요 (예: 010-1234-5678)" pattern="[\d\-+\s]+" required>
                </div>

                <div class="form-group">
                    <label class="form-label">이메일</label>
                    <input type="email" name="realtorEmail" class="form-input" value="${realtor.realtorEmail != null ? realtor.realtorEmail : ''}" placeholder="이메일을 입력하세요" required>
                </div>

                <div class="modal-buttons">
                    <button type="button" class="btn-save" onclick="saveChanges()">저장하기</button>
                    <button type="button" class="btn-cancel" onclick="closeEditModal()">취소</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 탭 네비게이션
        const tabs = document.querySelectorAll('.tab-item');
        const sections = document.querySelectorAll('.content-section');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                const targetTab = this.dataset.tab;

                // 중개사 마이페이지에서는 'mypage' 탭 외에 다른 탭은 페이지 이동을 유도했으므로, 
                // 해당 탭을 클릭하면 페이지 이동 로직이 실행될 것입니다.
                if(targetTab !== 'mypage') return;

                tabs.forEach(t => t.classList.remove('active'));
                sections.forEach(s => s.classList.remove('active'));

                this.classList.add('active');
                document.getElementById(targetTab).classList.add('active');
            });
        });

        // 모달 기능
        function openEditModal() {
            document.getElementById('editModal').classList.add('active');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
        }

        function saveChanges() {
            const form = document.getElementById('updateForm');

            // 폼 유효성 검사
            if (!form.checkValidity()) {
                alert('모든 필드를 올바르게 입력해주세요.');
                return;
            }

            // 폼 제출
            form.submit();
        }

        // 회원 탈퇴
        function confirmDelete() {
            if (confirm('정말로 탈퇴하시겠습니까? 탈퇴 후에는 복구할 수 없습니다.')) {
                // 경로 수정: /realtor/mypage/delete
                location.href = '${pageContext.request.contextPath}/realtor/mypage/delete';
            }
        }

        // 채팅 열기
        function openChat(contractId) {
            location.href = '${pageContext.request.contextPath}/chat/' + contractId;
        }

        // 모달 외부 클릭 시 닫기
        document.getElementById('editModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeEditModal();
            }
        });
    </script>
</body>
</html>
