<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${guide.title} - UNILAND</title>
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
            background: #feebc8;
            color: #c05621;
            padding: 6px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
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
                <c:when test="${not empty guide}">
                    <span class="post-category">
                        <i class="fa-solid fa-file-contract"></i> ${guide.categoryName}
                    </span>
                    <h1 class="post-title">${guide.title}</h1>
                    <div class="post-meta">
                        <div class="post-author-info">
                            <div class="author-avatar">${guide.authorNickname.substring(0, 1)}</div>
                            <div class="author-details">
                                <span class="author-name">${guide.authorNickname}</span>
                                <span class="post-date"><fmt:formatDate value="${guide.createdAt}" pattern="yyyy.MM.dd"/></span>
                            </div>
                        </div>
                        <div class="post-stats">
                            <span><i class="fa-solid fa-eye"></i> ${guide.viewCount}</span>
                            <span><i class="fa-solid fa-heart"></i> ${guide.likeCount}</span>
                            <span><i class="fa-solid fa-comment"></i> ${guide.commentCount}</span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <span class="post-category">
                        <i class="fa-solid fa-file-contract"></i> 계약 팁
                    </span>
                    <h1 class="post-title">계약 전 꼭 확인해야 할 10가지 체크리스트</h1>
                    <div class="post-meta">
                        <div class="post-author-info">
                            <div class="author-avatar">자</div>
                            <div class="author-details">
                                <span class="author-name">자취고수</span>
                                <span class="post-date">2024.01.15</span>
                            </div>
                        </div>
                        <div class="post-stats">
                            <span><i class="fa-solid fa-eye"></i> 1,245</span>
                            <span><i class="fa-solid fa-heart"></i> 89</span>
                            <span><i class="fa-solid fa-comment"></i> 23</span>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 게시글 내용 -->
        <div class="post-content">
            <div class="post-body">
                <c:choose>
                    <c:when test="${not empty guide}">
                        ${guide.content}
                    </c:when>
                    <c:otherwise>
                        <p>
                    안녕하세요! 3년차 자취생입니다. 
                    처음 원룸 계약하실 때 무엇을 확인해야 할지 막막하셨던 경험 다들 있으시죠?
                </p>

                <p>
                    저도 첫 계약 때 제대로 확인하지 못해서 나중에 후회했던 적이 많았는데요,
                    그동안의 경험을 바탕으로 <strong>계약 전 꼭 확인해야 할 체크리스트</strong>를 정리해봤습니다!
                </p>

                <div class="highlight-box">
                    <p>
                        💡 <strong>꿀팁!</strong> 이 체크리스트를 프린트해서 매물 방문 시 직접 체크하면서 확인하시면 더욱 좋습니다!
                    </p>
                </div>

                <h2>1. 수압 및 배수 확인 💧</h2>
                <p>
                    가장 중요한 체크 포인트입니다!
                </p>
                <ul>
                    <li><strong>수압 확인:</strong> 샤워기와 세면대 수도꼭지를 모두 틀어보세요. 수압이 약하면 샤워할 때 정말 불편합니다.</li>
                    <li><strong>온수 확인:</strong> 온수가 나오는지, 얼마나 빨리 나오는지 확인하세요.</li>
                    <li><strong>배수 확인:</strong> 물을 틀어놓고 배수가 잘 되는지 확인하세요. 배수가 느리면 곰팡이의 원인이 됩니다.</li>
                </ul>

                <h2>2. 채광 및 환기 ☀️</h2>
                <p>
                    낮에 방문해서 직접 확인하는 것이 가장 중요합니다.
                </p>
                <ul>
                    <li><strong>창문 위치:</strong> 남향이 가장 좋지만, 동향도 괜찮습니다. 북향은 피하시는 게 좋아요.</li>
                    <li><strong>햇빛:</strong> 낮 시간대에 방문해서 햇빛이 얼마나 들어오는지 확인하세요.</li>
                    <li><strong>환기:</strong> 창문을 열어보고 맞바람이 치는지 확인하세요.</li>
                </ul>

                <h2>3. 곰팡이 및 습기 🔍</h2>
                <p>
                    곰팡이는 건강에도 안 좋고 한번 생기면 없애기 정말 힘듭니다!
                </p>
                <ul>
                    <li><strong>벽지 확인:</strong> 벽지가 들뜨거나 얼룩이 있는지 확인하세요.</li>
                    <li><strong>코너 부분:</strong> 방 구석구석, 특히 창문 주변을 자세히 살펴보세요.</li>
                    <li><strong>화장실:</strong> 화장실 환기구가 제대로 작동하는지 확인하세요.</li>
                    <li><strong>냄새:</strong> 곰팡이 냄새나 퀴퀴한 냄새가 나는지 확인하세요.</li>
                </ul>

                <h2>4. 방음 상태 🔇</h2>
                <p>
                    소음 문제는 생활의 질과 직결됩니다!
                </p>
                <ul>
                    <li><strong>벽 두드리기:</strong> 벽을 두드려보고 얼마나 울리는지 확인하세요.</li>
                    <li><strong>시간대별 방문:</strong> 가능하면 저녁 시간에도 한 번 방문해보세요.</li>
                    <li><strong>주변 환경:</strong> 도로와 가까운지, 주변에 술집이나 클럽이 있는지 확인하세요.</li>
                </ul>

                <h2>5. 보안 및 안전 🔒</h2>
                <ul>
                    <li><strong>도어락:</strong> 도어락이 최신형인지, 잘 작동하는지 확인하세요.</li>
                    <li><strong>CCTV:</strong> 건물 입구와 복도에 CCTV가 있는지 확인하세요.</li>
                    <li><strong>현관문:</strong> 이중 잠금장치가 있는지 확인하세요.</li>
                    <li><strong>1층 여부:</strong> 1층이라면 창문 잠금장치를 꼭 확인하세요.</li>
                </ul>

                <h2>6. 옵션 상태 확인 ✅</h2>
                <p>
                    계약서에 명시된 옵션들이 실제로 있는지, 작동하는지 확인해야 합니다.
                </p>
                <ul>
                    <li><strong>에어컨:</strong> 직접 켜보고 냉방이 잘 되는지 확인하세요.</li>
                    <li><strong>냉장고:</strong> 냉동/냉장이 제대로 되는지 확인하세요.</li>
                    <li><strong>세탁기:</strong> 탈수가 잘 되는지, 소음은 얼마나 되는지 확인하세요.</li>
                    <li><strong>가구:</strong> 침대, 책상 등이 흔들리지 않는지 확인하세요.</li>
                </ul>

                <h2>7. 전기 설비 ⚡</h2>
                <ul>
                    <li><strong>콘센트 위치:</strong> 콘센트가 필요한 곳에 있는지 확인하세요.</li>
                    <li><strong>콘센트 개수:</strong> 멀티탭 없이도 충분한지 확인하세요.</li>
                    <li><strong>전등:</strong> 모든 전등이 잘 켜지는지 확인하세요.</li>
                    <li><strong>전기용량:</strong> 차단기를 확인해 전기 용량이 충분한지 확인하세요.</li>
                </ul>

                <h2>8. 관리비 항목 상세 확인 💰</h2>
                <p>
                    관리비에 무엇이 포함되는지 꼼꼼히 확인하세요!
                </p>
                <ul>
                    <li><strong>포함 항목:</strong> 수도, 인터넷, 가스 등 어떤 것이 포함되는지 확인하세요.</li>
                    <li><strong>개별 난방:</strong> 난방비는 어떻게 청구되는지 확인하세요.</li>
                    <li><strong>예상 비용:</strong> 겨울철/여름철 평균 관리비가 얼마인지 물어보세요.</li>
                </ul>

                <h2>9. 입주 가능일 및 계약 기간 📅</h2>
                <ul>
                    <li><strong>입주일:</strong> 정확한 입주 가능일을 확인하세요.</li>
                    <li><strong>계약 기간:</strong> 최소 계약 기간이 얼마인지 확인하세요.</li>
                    <li><strong>단기 계약:</strong> 학기 단위 계약이 가능한지 물어보세요.</li>
                </ul>

                <h2>10. 주변 편의시설 🏪</h2>
                <ul>
                    <li><strong>편의점:</strong> 도보 5분 이내에 편의점이 있는지 확인하세요.</li>
                    <li><strong>세탁소:</strong> 이불 빨래를 위한 세탁소가 가까운지 확인하세요.</li>
                    <li><strong>교통:</strong> 지하철역이나 버스 정류장까지의 거리를 확인하세요.</li>
                    <li><strong>학교:</strong> 학교까지의 실제 소요 시간을 확인하세요.</li>
                </ul>

                <div class="highlight-box">
                    <p>
                        📸 <strong>사진 꼭 찍어두세요!</strong><br>
                        입주 전 방 상태를 사진으로 남겨두면 나중에 보증금 돌려받을 때 도움이 됩니다!
                    </p>
                </div>

                <h2>마무리 💪</h2>
                <p>
                    이 체크리스트를 참고하셔서 좋은 방 구하시길 바랍니다!
                    궁금한 점이 있으시면 댓글로 남겨주세요. 아는 범위 내에서 답변 드리겠습니다!
                </p>

                <p>
                    모두 행복한 자취 생활 하세요! 🏠✨
                </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- 액션 버튼 -->
        <div class="post-actions">
            <button class="btn-action btn-like" onclick="toggleLike()">
                <i class="fa-regular fa-heart"></i>
                <span id="likeText">좋아요 (<c:out value="${guide.likeCount != null ? guide.likeCount : 89}"/>)</span>
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
                댓글 <span class="comment-count"><c:out value="${guide.commentCount != null ? guide.commentCount : 23}"/></span>
            </h3>

            <!-- 댓글 작성 -->
            <div class="comment-form">
                <form action="${pageContext.request.contextPath}/community/guide/${guide.guideId}/comment" method="post">
                    <textarea class="comment-textarea" name="content" placeholder="댓글을 입력하세요..." id="commentInput"></textarea>
                    <div class="comment-form-footer">
                        <span class="comment-info">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    ${sessionScope.user.nickname}님으로 댓글 작성
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
                                        <div class="comment-avatar">${comment.authorNickname.substring(0, 1)}</div>
                                        <div>
                                            <span class="comment-author">${comment.authorNickname}</span>
                                            <span class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                        </div>
                                    </div>
                                    <div class="comment-actions">
                                        <button class="btn-comment-action">
                                            <i class="fa-regular fa-heart"></i> 좋아요
                                        </button>
                                        <c:if test="${sessionScope.user.userId == comment.userId}">
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
                        <!-- 샘플 댓글 데이터 -->
                <li class="comment-item">
                    <div class="comment-header">
                        <div class="comment-author-info">
                            <div class="comment-avatar">김</div>
                            <div>
                                <span class="comment-author">김대학</span>
                                <span class="comment-date">2024.01.15 14:30</span>
                            </div>
                        </div>
                        <div class="comment-actions">
                            <button class="btn-comment-action">
                                <i class="fa-regular fa-heart"></i> 좋아요
                            </button>
                            <button class="btn-comment-action">답글</button>
                        </div>
                    </div>
                    <div class="comment-body">
                        정말 유용한 정보 감사합니다! 다음 주에 방 보러 가는데 이 체크리스트 프린트해서 가져가야겠어요 👍
                    </div>
                </li>

                <li class="comment-item">
                    <div class="comment-header">
                        <div class="comment-author-info">
                            <div class="comment-avatar">이</div>
                            <div>
                                <span class="comment-author">이학생</span>
                                <span class="comment-date">2024.01.15 15:20</span>
                            </div>
                        </div>
                        <div class="comment-actions">
                            <button class="btn-comment-action">
                                <i class="fa-regular fa-heart"></i> 좋아요
                            </button>
                            <button class="btn-comment-action">답글</button>
                        </div>
                    </div>
                    <div class="comment-body">
                        특히 곰팡이 확인 부분이 중요한 것 같아요. 제가 첫 자취방에서 곰팡이 때문에 고생 많이 했거든요 ㅠㅠ
                    </div>
                </li>

                <li class="comment-item">
                    <div class="comment-header">
                        <div class="comment-author-info">
                            <div class="comment-avatar">박</div>
                            <div>
                                <span class="comment-author">박연세</span>
                                <span class="comment-date">2024.01.15 16:45</span>
                            </div>
                        </div>
                        <div class="comment-actions">
                            <button class="btn-comment-action">
                                <i class="fa-regular fa-heart"></i> 좋아요
                            </button>
                            <button class="btn-comment-action">답글</button>
                        </div>
                    </div>
                    <div class="comment-body">
                        수압 체크는 정말 중요합니다! 저는 이거 안 봐서 지금 샤워할 때마다 후회 중이에요... 다음 계약 때는 꼭 확인해야겠네요.
                    </div>
                </li>

                <li class="comment-item">
                    <div class="comment-header">
                        <div class="comment-author-info">
                            <div class="comment-avatar">최</div>
                            <div>
                                <span class="comment-author">최학생</span>
                                <span class="comment-date">2024.01.15 18:30</span>
                            </div>
                        </div>
                        <div class="comment-actions">
                            <button class="btn-comment-action">
                                <i class="fa-regular fa-heart"></i> 좋아요
                            </button>
                            <button class="btn-comment-action">답글</button>
                        </div>
                    </div>
                    <div class="comment-body">
                        관리비 항목 확인 부분 추가해주셔서 감사합니다! 처음에 관리비에 뭐가 포함되는지 안 물어봐서 나중에 청구서 보고 깜짝 놀랐었어요.
                    </div>
                </li>

                <li class="comment-item">
                    <div class="comment-header">
                        <div class="comment-author-info">
                            <div class="comment-avatar">정</div>
                            <div>
                                <span class="comment-author">정대학</span>
                                <span class="comment-date">2024.01.16 09:15</span>
                            </div>
                        </div>
                        <div class="comment-actions">
                            <button class="btn-comment-action">
                                <i class="fa-regular fa-heart"></i> 좋아요
                            </button>
                            <button class="btn-comment-action">답글</button>
                        </div>
                    </div>
                    <div class="comment-body">
                        저장해놨다가 친구들한테도 공유해야겠어요! 정말 꿀팁 가득한 글이네요 👏👏
                    </div>
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
                    <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${prevGuide.guideId}'">
                        <div class="nav-label">
                            <i class="fa-solid fa-chevron-up"></i> 이전 글
                        </div>
                        <div class="nav-post-title">${prevGuide.title}</div>
                    </div>
                </c:if>
                <c:if test="${not empty nextGuide}">
                    <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${nextGuide.guideId}'">
                        <div class="nav-label">
                            <i class="fa-solid fa-chevron-down"></i> 다음 글
                        </div>
                        <div class="nav-post-title">${nextGuide.title}</div>
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
        let isLiked = false;
        let likeCount = ${guide.likeCount != null ? guide.likeCount : 89};

        function toggleLike() {
            const isLoggedIn = ${not empty sessionScope.user};

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
            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideId}/like', {
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
            const isLoggedIn = ${not empty sessionScope.user};
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

            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideId}/comment/' + commentId, {
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