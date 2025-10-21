<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공인중개사 회원가입 - UNILAND</title>
    <style>
        /* ⚠️ 기존 CSS는 전혀 수정하지 않음 */
        :root {
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --badge-urgent: #f56565;
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --text-light: #999;
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-light-gray: #f0f0f0;
            --border-light: #e5e5e5;
            --border-medium: #d0d0d0;
            --spacing-xs: 6px;
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --spacing-4xl: 60px;
            --radius-md: 6px;
            --radius-lg: 8px;
            --font-sm: 13px;
            --font-md: 14px;
            --font-lg: 16px;
            --font-2xl: 24px;
        }
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: var(--bg-body); }
        .main-container { max-width: 700px; margin: var(--spacing-4xl) auto; padding: var(--spacing-md); }
        .signup-card { background: var(--bg-white); border-radius: var(--radius-lg); padding: var(--spacing-2xl); box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .page-logo { text-align: center; margin-bottom: var(--spacing-lg); }
        .page-logo img { height: 80px; object-fit: contain; }
        .page-title { text-align: center; font-size: 22px; font-weight: 600; color: var(--text-primary); margin-bottom: var(--spacing-2xl); padding-bottom: var(--spacing-md); border-bottom: 2px solid var(--text-primary); }
        .form-wrapper { max-width: 450px; margin: 0 auto; }
        .form-row { display: flex; align-items: center; margin-bottom: var(--spacing-md); }
        .form-label { width: 120px; font-size: var(--font-md); color: var(--text-primary); flex-shrink: 0; }
        .form-label .required { color: var(--badge-urgent); margin-right: 4px; }
        .form-input-group { position: relative; flex: 1; display: flex; gap: var(--spacing-sm); align-items: center; }
        .input-field { width: 100%; padding: 12px; border: 1px solid var(--border-medium); border-radius: var(--radius-md); font-size: var(--font-md); outline: none; background-color: var(--bg-white); transition: border-color 0.3s; }
        .input-field:focus { border-color: var(--primary-purple); }
        .password-toggle-icon { position: absolute; top: 50%; right: 12px; transform: translateY(-50%); cursor: pointer; color: var(--text-light); user-select: none; display: none; }
        .btn-check { padding: 12px 16px; background: var(--bg-white); border: 1px solid var(--border-medium); border-radius: var(--radius-md); color: var(--text-tertiary); font-size: var(--font-sm); cursor: pointer; white-space: nowrap; flex-shrink: 0; transition: all 0.2s; }
        .btn-check:hover { background: var(--bg-light-gray); border-color: var(--primary-purple); color: var(--primary-purple); }
        .btn-check:disabled { background: var(--bg-light-gray); border-color: var(--border-light); color: var(--text-light); cursor: not-allowed; }
        .verification-message { font-size: var(--font-sm); margin-top: 4px; display: none; }
        .verification-message.success { color: #22c55e; display: block; }
        .verification-message.error { color: var(--badge-urgent); display: block; }
        .submit-section { margin-top: var(--spacing-2xl); text-align: center; }
        .submit-btn { width: 100%; max-width: 200px; padding: 14px; background: var(--primary-purple); color: var(--bg-white); border: none; border-radius: var(--radius-md); font-size: var(--font-lg); font-weight: 500; cursor: pointer; transition: background 0.3s; }
        .submit-btn:hover { background: var(--primary-dark); }
        .submit-btn:disabled { background: var(--text-light); cursor: not-allowed; }
        .signup-footer { display: flex; justify-content: center; gap: var(--spacing-md); margin-top: var(--spacing-xl); font-size: var(--font-md); }
        .signup-footer a { color: var(--text-tertiary); text-decoration: none; }
        .signup-footer a:hover { color: var(--primary-purple); }
        .signup-footer .divider { color: var(--border-light); }
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
                <form id="realtorSignupForm">
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>아이디</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorId" name="realtorId" placeholder="아이디를 입력하세요" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>비밀번호</label>
                        <div class="form-input-group">
                            <input type="password" class="input-field" id="realtorPassword" name="realtorPassword" placeholder="비밀번호를 입력하세요" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>중개 사무소 이름</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="officeName" name="officeName" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표자명</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorName" name="realtorName" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>주소</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorAddress" name="realtorAddress" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표 공인중개사 연락처</label>
                        <div class="form-input-group">
                            <input type="tel" class="input-field" id="realtorPhone" name="realtorPhone" placeholder="'-' 없이 숫자만 입력" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표 공인중개사 이메일</label>
                        <div class="form-input-group">
                            <input type="email" class="input-field" id="realtorEmail" name="realtorEmail" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>사업자 등록번호</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="businessNum" name="businessNum" placeholder="'-' 없이 숫자만 입력" required>
                            <button type="button" class="btn-check" id="verifyBtn">인증</button>
                        </div>
                    </div>
                    <div class="verification-message" id="verificationMsg"></div>

                    <div class="submit-section">
                        <button type="submit" class="submit-btn" id="submitBtn" disabled>회원가입 신청</button>
                    </div>
                </form>
            </div>

            <div class="signup-footer">
                <a href="${pageContext.request.contextPath}/auth/realtor-login">로그인</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/signup">일반 회원가입</a>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const form = document.getElementById('realtorSignupForm');
        const verifyBtn = document.getElementById('verifyBtn');
        const submitBtn = document.getElementById('submitBtn');
        const businessNumInput = document.getElementById('businessNum');
        const verificationMsg = document.getElementById('verificationMsg');

        const fields = {
            realtorId: document.getElementById('realtorId'),
            realtorPassword: document.getElementById('realtorPassword'),
            officeName: document.getElementById('officeName'),
            realtorName: document.getElementById('realtorName'),
            realtorAddress: document.getElementById('realtorAddress'),
            realtorPhone: document.getElementById('realtorPhone'),
            realtorEmail: document.getElementById('realtorEmail'),
            businessNum: businessNumInput
        };

        let isBusinessNumVerified = false;

        fields.realtorPhone.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
            checkFormValidity();
        });

        businessNumInput.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
            isBusinessNumVerified = false;
            verificationMsg.classList.remove('success', 'error');
            verificationMsg.textContent = '';
            checkFormValidity();
        });

        Object.values(fields).forEach(f => {
            if (f !== fields.realtorPhone && f !== businessNumInput) {
                f.addEventListener('input', checkFormValidity);
            }
        });

        verifyBtn.addEventListener('click', e => {
            e.preventDefault();
            const businessNum = businessNumInput.value.trim();
            if (!businessNum) {
                verificationMsg.classList.add('error');
                verificationMsg.textContent = '사업자 등록번호를 입력해주세요.';
                return;
            }
            if (!/^\d{10}$/.test(businessNum)) {
                verificationMsg.classList.add('error');
                verificationMsg.textContent = '사업자 등록번호는 10자리 숫자여야 합니다.';
                return;
            }
            verifyBtn.disabled = true;
            verifyBtn.textContent = '확인 중...';
            fetch(contextPath + '/realtor/check-business-num', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ businessNum })
            })
            .then(res => res.json())
            .then(data => {
                if (data.isDuplicate) {
                    verificationMsg.classList.add('error');
                    verificationMsg.textContent = '이미 등록된 사업자 등록번호입니다.';
                    isBusinessNumVerified = false;
                } else {
                    verificationMsg.classList.add('success');
                    verificationMsg.textContent = '사용 가능한 사업자 등록번호입니다.';
                    isBusinessNumVerified = true;
                }
                checkFormValidity();
            })
            .finally(() => {
                verifyBtn.disabled = false;
                verifyBtn.textContent = '인증';
            });
        });

        function checkFormValidity() {
            const allFilled = Object.values(fields).every(f => f.value.trim() !== '');
            submitBtn.disabled = !(allFilled && isBusinessNumVerified);
        }

        form.addEventListener('submit', e => {
            e.preventDefault();
            if (!isBusinessNumVerified) {
                alert('사업자 등록번호 인증을 완료해주세요.');
                return;
            }

            const formData = {
                realtorId: fields.realtorId.value.trim(),
                realtorPassword: fields.realtorPassword.value.trim(),
                officeName: fields.officeName.value.trim(),
                realtorName: fields.realtorName.value.trim(),
                realtorAddress: fields.realtorAddress.value.trim(),
                realtorPhone: fields.realtorPhone.value.trim(),
                realtorEmail: fields.realtorEmail.value.trim(),
                businessNum: businessNumInput.value.trim()
            };

            submitBtn.disabled = true;
            submitBtn.textContent = '처리 중...';

            fetch(contextPath + '/realtor/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert('회원가입이 완료되었습니다.');
                    window.location.href = contextPath + '/auth/realtor-login';
                } else {
                    alert('회원가입 실패: ' + (data.message || ''));
                }
            })
            .catch(err => {
                console.error('Error:', err);
                alert('회원가입 중 오류가 발생했습니다.');
            })
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.textContent = '회원가입 신청';
            });
        });
    </script>
</body>
</html>
