<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UNILAND 관리자 - 중개사 승인</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
      background-color: #f5f5f5;
      color: #1a1a1a;
      display: flex;
      flex-direction: column;
      height: 100vh;
    }

    /* 헤더 */
    header {
      background: white;
      border-bottom: 1px solid #e5e5e5;
      padding: 18px 0;
      position: sticky;
      top: 0;
      z-index: 100;
    }
    .header-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 24px;
    }
    .logo img {
      height: 60px;
      object-fit: contain;
      object-position: center;
      cursor: pointer;
    }
    .btn-login {
      background: linear-gradient(90deg, #667eea, #764ba2);
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 25px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
    }
    .btn-login:hover { 
      background: linear-gradient(90deg, #5a67d8, #6b46c1);
      transform: translateY(-2px); 
    }

    /* 레이아웃 */
    .admin-container { flex: 1; display: flex; min-height: calc(100vh - 150px); }

    /* 사이드바 */
    .sidebar {
      width: 240px;
      background: #ffffff;
      border-right: 1px solid #e5e5e5;
      padding-top: 24px;
    }
    .sidebar h3 {
      text-align: center;
      color: #667eea;
      margin-bottom: 20px;
      font-size: 18px;
      font-weight: 700;
    }
    .sidebar ul { list-style: none; }
    .sidebar li {
      padding: 14px 24px;
      color: #333;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: all 0.2s;
    }
    .sidebar li:hover { background: #f0f2ff; color: #667eea; }
    .sidebar li.active { background: #e6e8ff; color: #5568d3; font-weight: 600; }

    /* 메인 콘텐츠 */
    .main-content {
      flex: 1;
      padding: 32px;
      overflow-y: auto;
    }

    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
    }
    .page-header h2 {
      font-size: 24px;
      font-weight: 700;
      color: #1a1a1a;
    }

    /* 알림 메시지 */
    .alert {
      padding: 12px 20px;
      border-radius: 6px;
      margin-bottom: 20px;
      font-size: 14px;
    }
    .alert-success {
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }
    .alert-error {
      background: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    /* 테이블 */
    table {
      width: 100%;
      background: white;
      border-collapse: collapse;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    th, td {
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #f0f0f0;
      font-size: 14px;
    }
    th {
      background: #f8f8f8;
      color: #555;
      font-weight: 600;
    }
    tr:hover td { background: #f9faff; }

    /* 상태 뱃지 */
    .badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      color: white;
    }
    .badge.pending { background: #f59e0b; }
    .badge.approved { background: #48bb78; }
    .badge.rejected { background: #e53e3e; }

    /* 버튼 */
    .action-btns {
      display: flex;
      justify-content: center;
      gap: 4px;
    }
    .action-btns button, .action-btns form {
      display: inline-block;
    }
    .btn-detail, .btn-approve, .btn-reject, .btn-cancel {
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      font-weight: 600;
      transition: all 0.2s;
    }
    .btn-detail { background: #667eea; color: white; }
    .btn-detail:hover { background: #5568d3; }
    .btn-approve { background: #48bb78; color: white; }
    .btn-approve:hover { background: #38a169; }
    .btn-reject { background: #e53e3e; color: white; }
    .btn-reject:hover { background: #c53030; }
    .btn-cancel { background: #f59e0b; color: white; }
    .btn-cancel:hover { background: #d97706; }

    /* 푸터 */
    footer {
      background: #2a2a2a;
      color: #999;
      padding: 40px 0;
      border-top: 1px solid #3a3a3a;
      text-align: center;
      font-size: 13px;
    }
  </style>
</head>

<body>
  <!-- 헤더 -->
  <header>
    <div class="header-container">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND 관리자">
      </div>
      <div class="auth-buttons">
        <button class="btn-login"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</button>
      </div>
    </div>
  </header>

  <!-- 메인 -->
  <div class="admin-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <h3>관리 메뉴</h3>
      <ul>
        <li><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li><i class="fa-solid fa-users"></i> 회원관리</li>
        <li><i class="fa-solid fa-building"></i> 매물관리</li>
        <li><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li><i class="fa-solid fa-envelope"></i> 문의관리</li>
        <li class="active"><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
      <div class="page-header">
        <h2>중개사 승인 관리</h2>
      </div>

      <!-- 알림 메시지 -->
      <c:if test="${not empty message}">
        <div class="alert alert-success">
          <i class="fa-solid fa-circle-check"></i> ${message}
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-error">
          <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
      </c:if>

      <!-- 중개사 승인 테이블 -->
      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>신청자명</th>
            <th>업체명</th>
            <th>사업자등록번호</th>
            <th>연락처</th>
            <th>신청일</th>
            <th>상태</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="realtorTable">
          <c:forEach var="realtor" items="${realtorList}" varStatus="status">
            <tr>
              <td>${status.count}</td>
              <td>${realtor.realtorName}</td>
              <td>${realtor.officeName}</td>
              <td>${realtor.businessNum}</td>
              <td>${realtor.realtorPhone}</td>
              <td>
                <c:choose>
                  <c:when test="${not empty realtor.createdAt}">
                    <fmt:formatDate value="${realtor.createdAt}" pattern="yyyy-MM-dd"/>
                  </c:when>
                  <c:otherwise>-</c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${realtor.approvalStatus == 'PENDING'}">
                    <span class="badge pending">승인대기</span>
                  </c:when>
                  <c:when test="${realtor.approvalStatus == 'APPROVAL'}">
                    <span class="badge approved">승인완료</span>
                  </c:when>
                  <c:when test="${realtor.approvalStatus == 'REJECTED'}">
                    <span class="badge rejected">거부됨</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge pending">-</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="action-btns">
                <!-- 상세보기 버튼 -->
                <button class="btn-detail" 
                        onclick="location.href='${pageContext.request.contextPath}/admin/realtor-detail/${realtor.realtorId}'">
                  <i class="fa-solid fa-file-lines"></i> 상세
                </button>
                
                <!-- 승인대기 상태 -->
                <c:if test="${realtor.approvalStatus == 'PENDING'}">
                  <form action="${pageContext.request.contextPath}/admin/realtor-approve/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-approve" 
                            onclick="return confirm('중개사를 승인하시겠습니까?')">
                      <i class="fa-solid fa-check"></i> 승인
                    </button>
                  </form>
                  <form action="${pageContext.request.contextPath}/admin/realtor-reject/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-reject" 
                            onclick="return confirm('중개사를 거부하시겠습니까?')">
                      <i class="fa-solid fa-xmark"></i> 거부
                    </button>
                  </form>
                </c:if>
                
                <!-- 승인완료 상태 -->
                <c:if test="${realtor.approvalStatus == 'APPROVAL'}">
                  <form action="${pageContext.request.contextPath}/admin/realtor-cancel/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-reject" 
                            onclick="return confirm('승인을 취소하시겠습니까?')">
                      <i class="fa-solid fa-ban"></i> 승인취소
                    </button>
                  </form>
                </c:if>
                
                <!-- 거부됨 상태 -->
                <c:if test="${realtor.approvalStatus == 'REJECTED'}">
                  <form action="${pageContext.request.contextPath}/admin/realtor-approve/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-cancel" 
                            onclick="return confirm('재승인하시겠습니까?')">
                      <i class="fa-solid fa-rotate-right"></i> 재승인
                    </button>
                  </form>
                </c:if>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty realtorList}">
            <tr>
              <td colspan="8" style="text-align: center; color: #999; padding: 40px;">
                등록된 중개사가 없습니다.
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </main>
  </div>

  <!-- 푸터 -->
  <footer>
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    // 사이드바 메뉴 클릭
    document.querySelectorAll('.sidebar li').forEach((item, index) => {
      item.addEventListener('click', function() {
        document.querySelectorAll('.sidebar li').forEach(li => li.classList.remove('active'));
        this.classList.add('active');

        const pages = [
          '${pageContext.request.contextPath}/admin/dashboard',
          '${pageContext.request.contextPath}/admin/user-management',
          '${pageContext.request.contextPath}/admin/property-management',
          '${pageContext.request.contextPath}/admin/content-management',
          '${pageContext.request.contextPath}/admin/inquiry-management',
          '${pageContext.request.contextPath}/admin/realtor-approval'
        ];
        
        if (pages[index]) {
          window.location.href = pages[index];
        }
      });
    });

    // 로고 클릭
    document.querySelector('.logo').addEventListener('click', function() {
      window.location.href = '${pageContext.request.contextPath}/uniland';
    });

    // 로그아웃
    document.querySelector('.btn-login').addEventListener('click', function() {
      if (confirm('로그아웃 하시겠습니까?')) {
        window.location.href = '${pageContext.request.contextPath}/auth/logout';
      }
    });

    // 알림 메시지 자동 사라지기
    setTimeout(function() {
      const alerts = document.querySelectorAll('.alert');
      alerts.forEach(alert => {
        alert.style.transition = 'opacity 0.5s';
        alert.style.opacity = '0';
        setTimeout(() => alert.remove(), 500);
      });
    }, 3000);
  </script>
</body>
</html>