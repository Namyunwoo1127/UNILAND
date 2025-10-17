<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공인중개사 회원가입 - UNILAND</title>
    <style>
        /* ========================================
        UNILAND 디자인 시스템 - CSS 변수
        ======================================== */
        :root {
            /* 메인 컬러 */
            --primary-purple: #667eea;
            --primary-dark: #5568d3;

            /* 배지 컬러 */
            --badge-urgent: #f56565;

            /* 텍스트 컬러 */
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --text-light: #999;

            /* 배경 컬러 */
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-light-gray: #f0f0f0;

            /* 테두리 컬러 */
            --border-light: #e5e5e5;
            --border-medium: #d0d0d0;

            /* 간격 (Spacing) */
            --spacing-xs: 6px;
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --spacing-4xl: 60px;

            /* 모서리 반경 (Border Radius) */
            --radius-md: 6px;
            --radius-lg: 8px;

            /* 폰트 크기 (Font Size) */
            --font-sm: 13px;
            --font-md: 14px;
            --font-lg: 16px;
            --font-2xl: 24px;
        }

        /* ========================================
        스타일 초기화 및 기본 설정
        ======================================== */
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: var(--bg-body);
        }

        /* ========================================
        컴포넌트 스타일 (디자인 시스템 적용)
        ======================================== */
        /* 메인 컨텐츠 */
        .main-container {
            max-width: 700px;
            margin: var(--spacing-4xl) auto;
            padding: var(--spacing-md);
        }

        .signup-card {
            background: var(--bg-white);
            border-radius: var(--radius-lg);
            padding: var(--spacing-2xl);
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .page-logo {
            text-align: center;
            margin-bottom: var(--spacing-lg);
        }

        .page-logo img {
            height: 80px;
            object-fit: contain;
        }

        .page-title {
            text-align: center;
            font-size: 22px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: var(--spacing-2xl);
            padding-bottom: var(--spacing-md);
            border-bottom: 2px solid var(--text-primary);
        }

        .form-wrapper {
            max-width: 450px;
            margin: 0 auto;
        }

        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: var(--spacing-md);
        }

        .form-label {
            width: 120px; /* 라벨 너비 조정 */
            font-size: var(--font-md);
            color: var(--text-primary);
            flex-shrink: 0;
        }

        .form-label .required {
            color: var(--badge-urgent);
            margin-right: 4px;
        }

        .form-input-group {
            position: relative;
            flex: 1;
            display: flex;
            gap: var(--spacing-sm);
            align-items: center;
        }
        
        .input-field {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            outline: none;
            background-color: var(--bg-white);
            transition: border-color 0.3s;
        }

        .input-field:focus {
            border-color: var(--primary-purple);
        }
        
        .input-field.password-input {
            padding-right: 40px; 
        }

        .input-field::-ms-reveal,
        .input-field::-webkit-password-reveal-button {
            display: none;
        }

        .password-toggle-icon {
            position: absolute;
            top: 50%;
            right: 12px;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--text-light);
            user-select: none;
            display: none;
        }

        .btn-check {
            padding: 12px 16px;
            background: var(--bg-white);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-md);
            color: var(--text-tertiary);
            font-size: var(--font-sm);
            cursor: pointer;
            white-space: nowrap;
            flex-shrink: 0;
            transition: all 0.2s;
        }
        
        /* ... (나머지 CSS는 이전과 동일) ... */
        .submit-section { margin-top: var(--spacing-2xl); text-align: center; }
        .submit-btn { width: 100%; max-width: 200px; padding: 14px; background: var(--primary-purple); color: var(--bg-white); border: none; border-radius: var(--radius-md); font-size: var(--font-lg); font-weight: 500; cursor: pointer; transition: background 0.3s; }
        .submit-btn:hover { background: var(--primary-dark); }

        .signup-footer {
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
            margin-top: var(--spacing-xl);
            font-size: var(--font-md);
        }

        .signup-footer a {
            color: var(--text-tertiary);
            text-decoration: none;
        }

        .signup-footer a:hover {
            color: var(--primary-purple);
        }

        .signup-footer .divider {
            color: var(--border-light);
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="signup-card">
            <div class="page-logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
            </div>
            <h1 class="page-title">중개사 회원가입</h1>
            <div class="form-wrapper">
                <form>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>중개 사무소 이름</label>
                        <div class="form-input-group"><input type="text" class="input-field"></div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표자명</label>
                        <div class="form-input-group"><input type="text" class="input-field"></div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>주소</label>
                        <div class="form-input-group"><input type="text" class="input-field"></div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표 공인중개사 <p></p> 연락처</label>
                        <div class="form-input-group"><input type="tel" class="input-field" placeholder="'-' 없이 숫자만 입력"></div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표 공인중개사 이메일</label>
                        <div class="form-input-group"><input type="email" class="input-field"></div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>사업자 등록번호</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" placeholder="'-' 없이 숫자만 입력">
                            <button type="button" class="btn-check">인증</button>
                        </div>
                    </div>

                    <div class="submit-section">
                        <button type="submit" class="submit-btn">회원가입 신청</button>
                    </div>
                </form>
            </div>

            <div class="signup-footer">
                <a href="${pageContext.request.contextPath}/auth/login">로그인</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/signup">일반 회원가입</a>
            </div>
        </div>
    </div>
</body>
</html>