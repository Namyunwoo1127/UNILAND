<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${guide.guideTitle} - UNILAND</title>
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
            line-height: 1.8;
        }

        /* 뒤로가기 버튼 */
        .btn-back {
            padding: 9px 20px;
            background: white;
            color: #667eea;
            border: 1px solid #d0d0d0;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 20px 0;
        }

        .btn-back:hover {
            background: #f7fafc;
            border-color: #667eea;
        }

        /* 메인 컨테이너 */
        .main-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 24px;
        }

        /* 게시글 헤더 */
        .post-header {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        .post-category {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .post-category.contract {
            background: #e0e7ff;
            color: #667eea;
        }

        .post-category.moving {
            background: #feebc8;
            color: #c05621;
        }

        .post-category.life {
            background: #c6f6d5;
            color: #22543d;
        }

        .post-category.area {
            background: #bee3f8;
            color: #2c5282;
        }

        .post-category.qna {
            background: #fed7d7;
            color: #c53030;
        }

        .post-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
            line-height: 1.4;
        }

        .post-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 20px;
            border-top: 1px solid #e5e5e5;
        }

        .post-author-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .author-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 700;
        }

        .author-details {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .author-name {
            font-size: 15px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .post-date {
            font-size: 13px;
            color: #999;
        }

        .post-stats {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #666;
        }

        .post-stats span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 게시글 내용 */
        .post-content {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        .post-body {
            font-size: 16px;
            color: #333;
            line-height: 1.8;
        }

        .post-body h2 {
            font-size: 24px;
            font-weight: 700;
            color: #1a1a1a;
            margin: 40px 0 20px 0;
            padding-bottom: 12px;
            border-bottom: 2px solid #e5e5e5;
        }

        .post-body h3 {
            font-size: 20px;
            font-weight: 600;
            color: #1a1a1a;
            margin: 30px 0 15px 0;
        }

        .post-body p {
            margin-bottom: 20px;
        }

        .post-body ul,
        .post-body ol {
            margin: 20px 0;
            padding-left: 30px;
        }

        .post-body li {
            margin-bottom: 12px;
        }

        .post-body strong {
            color: #667eea;
            font-weight: 600;
        }

        .highlight-box {
            background: #f7fafc;
            border-left: 4px solid #667eea;
            padding: 20px;
            margin: 25px 0;
            border-radius: 8px;
        }

        .highlight-box p {
            margin-bottom: 0;
        }

        /* 액션 버튼 */
        .post-actions {
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn-action {
            padding: 12px 28px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-like {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-like:hover {
            background: #f7fafc;
        }

        .btn-like.active {
            background: #667eea;
            color: white;
        }

        .btn-share {
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-share:hover {
            background: #f7fafc;
        }

        /* 댓글 섹션 */
        .comments-section {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        .comments-header {
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .comment-count {
            color: #667eea;
        }

        /* 댓글 작성 */
        .comment-form {
            margin-bottom: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #e5e5e5;
        }

        .comment-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            min-height: 120px;
            transition: border-color 0.2s;
        }

        .comment-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .comment-form-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 12px;
        }

        .comment-info {
            font-size: 13px;
            color: #999;
        }

        .btn-comment-submit {
            padding: 10px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-comment-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        /* 댓글 리스트 */
        .comment-list {
            list-style: none;
        }

        .comment-item {
            padding: 20px 0;
            border-bottom: 1px solid #e5e5e5;
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .comment-author-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .comment-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
            font-weight: 700;
        }

        .comment-author {
            font-size: 14px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .comment-date {
            font-size: 13px;
            color: #999;
            margin-left: 8px;
        }

        .comment-actions {
            display: flex;
            gap: 10px;
        }

        .btn-comment-action {
            background: none;
            border: none;
            color: #999;
            font-size: 13px;
            cursor: pointer;
            padding: 4px 8px;
            transition: color 0.2s;
        }

        .btn-comment-action:hover {
            color: #667eea;
        }

        .comment-body {
            font-size: 14px;
            color: #333;
            line-height: 1.6;
            padding-left: 52px;
        }

        /* 이전/다음 글 */
        .post-navigation {
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        .nav-title {
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
        }

        .nav-item {
            padding: 15px 0;
            border-bottom: 1px solid #e5e5e5;
            cursor: pointer;
            transition: all 0.2s;
        }

        .nav-item:hover {
            color: #667eea;
            padding-left: 10px;
        }

        .nav-item:last-child {
            border-bottom: none;
        }

        .nav-label {
            font-size: 13px;
            color: #999;
            margin-bottom: 5px;
        }

        .nav-post-title {
            font-size: 15px;
            font-weight: 500;
            color: #1a1a1a;
        }

        .nav-item:hover .nav-post-title {
            color: #667eea;
        }

        /* 목록 버튼 */
        .btn-list {
            width: 100%;
            padding: 14px;
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-list:hover {
            background: #f7fafc;
            border-color: #667eea;
            color: #667eea;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .post-header,
            .post-content,
            .comments-section {
                padding: 24px;
            }

            .post-title {
                font-size: 24px;
            }

            .post-meta {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .post-actions {
                padding: 20px;
            }

            .comment-body {
                padding-left: 0;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
	<!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<!-- 메인 컨테이너 -->
    <div class="main-container">
		<!-- 뒤로가기 버튼 -->
        <button class="btn-back" onclick="location.href='${pageContext.request.contextPath}/community/guide'">
            <i class="fa-solid fa-arrow-left"></i> 목록으로
        </button>
        
		<!-- 게시글 헤더 -->
        <div class="post-header">
		    <c:choose>
		        <c:when test="${guide.guideCategory eq 'contract'}">
		            <span class="post-category contract">
		                <i class="fa-solid fa-file-contract"></i> 계약 팁
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'moving'}">
		            <span class="post-category moving">
		                <i class="fa-solid fa-truck-moving"></i> 이사 팁
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'life'}">
		            <span class="post-category life">
		                <i class="fa-solid fa-house-user"></i> 생활 팁
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'area'}">
		            <span class="post-category area">
		                <i class="fa-solid fa-map-location-dot"></i> 동네 정보
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'qna'}">
		            <span class="post-category qna">
		                <i class="fa-solid fa-question-circle"></i> 질문/답변
		            </span>
		        </c:when>
		        <c:otherwise>
		            <span class="post-category contract">
		                <i class="fa-solid fa-file-contract"></i> ${guide.categoryName}
		            </span>
		        </c:otherwise>
		    </c:choose>
		    <h1 class="post-title">${guide.guideTitle}</h1>
		    <div class="post-meta">
		        <div class="post-author-info">
		            <div class="author-avatar">
		                ${guide.userId.substring(0, 1)}
		            </div>
		            <div class="author-details">
		                <span class="author-name">
		                    ${guide.userId}
		                </span>
		                <span class="post-date">
		                    <fmt:formatDate value="${guide.writeDate}" pattern="yyyy.MM.dd"/>
		                </span>
		            </div>
		        </div>
		        <div class="post-stats">
		            <span><i class="fa-solid fa-eye"></i> ${guide.viewCount}</span>
		            <span><i class="fa-solid fa-heart"></i> ${likeCount}</span>
		            <span><i class="fa-solid fa-comment"></i> ${guide.commentCount}</span>
		        </div>
		    </div>
		</div>

		<!-- 게시글 내용 -->
        <div class="post-content">
            <div class="post-body">
                ${guide.guideContent}
            </div>
        </div>

		<!-- 액션 버튼 -->
        <div class="post-actions">
            <button class="btn-action btn-like ${isLiked ? 'active' : ''}" onclick="toggleLike()">
                <i class="${isLiked ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
                <span id="likeText">좋아요 (${likeCount})</span>
            </button>
            <button class="btn-action btn-share" onclick="sharePost()">
                <i class="fa-solid fa-share-nodes"></i>
                공유하기
            </button>
        </div>

		<!-- 댓글 섹션 -->
        <div class="comments-section">
            <h3 class="comments-header">
                <i class="fa-solid fa-comments"></i>
                댓글 <span class="comment-count">${guide.commentCount}</span>
            </h3>

			<!-- 댓글 작성 -->
            <div class="comment-form">
                <form action="${pageContext.request.contextPath}/community/guide/${guide.guideNo}/comment" method="post">
                    <textarea class="comment-textarea" name="content" placeholder="댓글을 입력하세요..." id="commentInput"></textarea>
                    <div class="comment-form-footer">
                        <span class="comment-info">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loginUser}">
                                    ${sessionScope.loginUser.userId}님으로 댓글 작성
                                </c:when>
                                <c:otherwise>
                                    로그인 후 댓글을 작성할 수 있습니다.
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <button type="submit" class="btn-comment-submit" onclick="return submitComment()">
                            댓글 등록
                        </button>
                    </div>
                </form>
            </div>

			<!-- 댓글 리스트 -->
            <ul class="comment-list">
                <c:choose>
                    <c:when test="${not empty comments}">
                        <c:forEach var="comment" items="${comments}">
                            <li class="comment-item">
                                <div class="comment-header">
                                    <div class="comment-author-info">
                                        <%-- [수정됨] authorNickname -> userId --%>
                                        <div class="comment-avatar">${comment.userId.substring(0, 1)}</div>
                                        <div>
                                            <%-- [수정됨] authorNickname -> userId --%>
                                            <span class="comment-author">${comment.userId}</span>
                                            <span class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                        </div>
                                    </div>
                                    <div class="comment-actions">
                                        <button class="btn-comment-action">
                                            <i class="fa-regular fa-heart"></i> 좋아요
                                        </button>
                                        <c:if test="${sessionScope.loginUser.userId == comment.userId}">
                                            <button class="btn-comment-action" onclick="deleteComment(${comment.commentId})">삭제</button>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="comment-body">
                                    ${comment.content}
                                </div>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li style="text-align: center; padding: 40px 0; color: #999;">
                            첫 번째 댓글을 작성해보세요!
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

		<!-- 이전/다음 글 -->
        <c:if test="${not empty prevGuide || not empty nextGuide}">
            <div class="post-navigation">
                <h3 class="nav-title">다른 글 보기</h3>
                <c:if test="${not empty prevGuide}">
                    <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${prevGuide.guideNo}'">
                        <div class="nav-label">
                            <i class="fa-solid fa-chevron-up"></i> 이전 글
                        </div>
                        <div class="nav-post-title">${prevGuide.guideTitle}</div>
                    </div>
                </c:if>
                <c:if test="${not empty nextGuide}">
                    <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${nextGuide.guideNo}'">
                        <div class="nav-label">
                            <i class="fa-solid fa-chevron-down"></i> 다음 글
                        </div>
                        <div class="nav-post-title">${nextGuide.guideTitle}</div>
                    </div>
                </c:if>
            </div>
        </c:if>

		<!-- 목록 버튼 -->
        <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/community/guide'">
            <i class="fa-solid fa-list"></i> 목록으로 돌아가기
        </button>
    </div>

	<!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        // 좋아요 토글
        let isLiked = ${isLiked};
        let likeCount = ${likeCount};

        function toggleLike() {
            const isLoggedIn = ${not empty sessionScope.loginUser};

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }
                return;
            }

            const btn = document.querySelector('.btn-like');
            const icon = btn.querySelector('i');
            const text = document.getElementById('likeText');

            // AJAX로 좋아요 처리
            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideNo}/like', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    isLiked = data.isLiked;
                    likeCount = data.likeCount;

                    if (isLiked) {
                        icon.className = 'fa-solid fa-heart';
                        btn.classList.add('active');
                    } else {
                        icon.className = 'fa-regular fa-heart';
                        btn.classList.remove('active');
                    }
                    text.textContent = '좋아요 (' + likeCount + ')';
                    
                 // ⭐ 상단 post-stats의 좋아요 수 실시간 업데이트
                    const statsHeart = document.querySelector('.post-stats span:nth-child(2)');
                    if (statsHeart) {
                        statsHeart.innerHTML = '<i class="fa-solid fa-heart"></i> ' + likeCount;
                    }
                }
            })
            .catch(err => console.error('좋아요 처리 실패:', err));
        }

        // 공유하기
        function sharePost() {
            const url = window.location.href;
            const title = document.querySelector('.post-title').textContent;

            if (navigator.share) {
                navigator.share({
                    title: title,
                    text: 'UNILAND 자취 가이드',
                    url: url
                }).catch(err => console.log('공유 실패:', err));
            } else {
                // Fallback: URL 복사
                navigator.clipboard.writeText(url).then(() => {
                    alert('링크가 복사되었습니다!');
                });
            }
        }

        // 댓글 작성
        function submitComment() {
            const isLoggedIn = ${not empty sessionScope.loginUser};
            const commentInput = document.getElementById('commentInput');

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                }
                return false;
            }

            const content = commentInput.value.trim();

            if (content === '') {
                alert('댓글 내용을 입력해주세요.');
                commentInput.focus();
                return false;
            }

            return true;
        }

        // 댓글 삭제
        function deleteComment(commentId) {
            if (!confirm('댓글을 삭제하시겠습니까?')) {
                return;
            }

            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideNo}/comment/' + commentId, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('댓글이 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                }
            })
            .catch(err => console.error('댓글 삭제 실패:', err));
        }

        // 엔터키로 댓글 작성 (Shift + Enter는 줄바꿈)
        document.getElementById('commentInput').addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                if (submitComment()) {
                    document.querySelector('.comment-form form').submit();
                }
            }
        });
    </script>
</body>
</html>