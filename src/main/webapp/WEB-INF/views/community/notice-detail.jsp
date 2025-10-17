<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif; color: #1a1a1a; background-color: #f5f5f5; line-height: 1.8; }
        .main-container { max-width: 900px; margin: 40px auto; padding: 0 24px; }
        .notice-header { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; }
        .notice-badge { display: inline-flex; align-items: center; gap: 6px; background: linear-gradient(135deg, #f56565 0%, #c53030 100%); color: white; padding: 8px 16px; border-radius: 6px; font-size: 13px; font-weight: 600; margin-bottom: 16px; }
        .notice-title { font-size: 32px; font-weight: 700; color: #1a1a1a; margin-bottom: 20px; line-height: 1.4; }
        .notice-meta { display: flex; justify-content: space-between; align-items: center; padding-top: 20px; border-top: 1px solid #e5e5e5; font-size: 14px; color: #666; }
        .notice-meta-left { display: flex; gap: 20px; }
        .notice-meta span { display: flex; align-items: center; gap: 6px; }
        .notice-content { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; }
        .notice-body { font-size: 16px; color: #333; line-height: 1.8; }
        .notice-body h2 { font-size: 24px; font-weight: 700; color: #1a1a1a; margin: 40px 0 20px 0; padding-bottom: 12px; border-bottom: 2px solid #e5e5e5; }
        .notice-body h3 { font-size: 20px; font-weight: 600; color: #1a1a1a; margin: 30px 0 15px 0; }
        .notice-body p { margin-bottom: 20px; }
        .notice-body ul, .notice-body ol { margin: 20px 0; padding-left: 30px; }
        .notice-body li { margin-bottom: 12px; }
        .notice-body strong { color: #667eea; font-weight: 600; }
        .highlight-box { background: #fff5f5; border-left: 4px solid #f56565; padding: 20px; margin: 25px 0; border-radius: 8px; }
        .highlight-box.info { background: #ebf8ff; border-left-color: #4299e1; }
        .highlight-box.success { background: #f0fff4; border-left-color: #48bb78; }
        .notice-actions { background: white; padding: 25px 40px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; display: flex; justify-content: center; gap: 12px; }
        .btn-action { padding: 12px 28px; border-radius: 8px; cursor: pointer; font-size: 15px; font-weight: 600; transition: all 0.2s; display: flex; align-items: center; gap: 8px; background: white; color: #4a5568; border: 2px solid #e2e8f0; }
        .btn-action:hover { background: #f7fafc; }
        .btn-list { width: 100%; padding: 14px; background: white; color: #4a5568; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.2s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-list:hover { background: #f7fafc; border-color: #667eea; color: #667eea; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="main-container">
        <div class="notice-header">
            <span class="notice-badge"><i class="fa-solid fa-exclamation"></i> 필독</span>
            <h1 class="notice-title">UNILAND 정식 오픈 안내 및 서비스 이용 가이드</h1>
            <div class="notice-meta">
                <div class="notice-meta-left">
                    <span><i class="fa-solid fa-user"></i> 관리자</span>
                    <span><i class="fa-solid fa-calendar"></i> 2024.01.15</span>
                </div>
                <span><i class="fa-solid fa-eye"></i> 조회 2,456</span>
            </div>
        </div>
        <div class="notice-content">
            <div class="notice-body">
                <p>안녕하세요, UNILAND 운영팀입니다. 🎉</p>
                <p>대학생 여러분의 편리한 자취방 찾기를 위해 준비한 <strong>UNILAND</strong>가 드디어 정식 오픈했습니다!</p>
                <div class="highlight-box info">
                    <p><strong>📢 UNILAND는?</strong><br>
                    처음 자취를 시작하는 대학생을 위한 AI 기반 원룸/오피스텔 검색 및 중개 플랫폼입니다.</p>
                </div>
                <h2>🚀 주요 서비스 안내</h2>
                <h3>1. AI 자연어 검색</h3>
                <p>"연세대 근처에서 월세 70만원 이하로 찾아줘" 처럼 자연스러운 말로 검색하세요.</p>
            </div>
        </div>
        <div class="notice-actions">
            <button class="btn-action" onclick="alert('공유하기')"><i class="fa-solid fa-share-nodes"></i> 공유하기</button>
            <button class="btn-action" onclick="window.print()"><i class="fa-solid fa-print"></i> 인쇄하기</button>
        </div>
        <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/community/notice'">
            <i class="fa-solid fa-list"></i> 목록으로 돌아가기
        </button>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
