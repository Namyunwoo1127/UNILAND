<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UNILAND 관리자 - 공지사항관리</title>
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
      cursor: pointer;
    }

    .logo img {
      height: 60px;
      object-fit: contain;
      object-position: center;
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
      transition: background 0.3s ease, transform 0.2s ease;
    }
    .btn-login:hover {
      background: linear-gradient(90deg, #5a67d8, #6b46c1);
      transform: translateY(-2px);
    }

    /* 메인 레이아웃 */
    .admin-container {
      flex: 1;
      display: flex;
      min-height: calc(100vh - 150px);
    }

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

    /* 공지 작성 버튼 */
    .btn-create {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .btn-create:hover {
      background: #5a67d8;
    }

    /* 검색 박스 */
    .search-box {
      background: white;
      border: 1px solid #e5e5e5;
      border-radius: 8px;
      padding: 20px;
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 30px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .search-box select, .search-box input {
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }

    .search-box select { width: 130px; }
    .search-box input { flex: 1; }

    .btn-search {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .btn-search:hover { background: #5a67d8; }
  
    .btn-reset {
      background: #718096;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease;
    }
    .btn-reset:hover { background: #4a5568; }

    /* 테이블 */
    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    th, td {
      padding: 14px;
      border-bottom: 1px solid #f0f0f0;
      text-align: center;
      font-size: 14px;
    }

    th {
      background: #f8f8f8;
      color: #555;
      font-weight: 600;
    }

    tr:hover td { background: #f9faff; }

    .manage-btn {
      display: flex;
      justify-content: center;
      gap: 6px;
    }
    
    .badge {
      display: inline-block;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 11px;
      font-weight: 600;
    }
        
    .badge-important {
      background: #f56565;
      color: white;
    }
        
    .badge-new {
      background: #48bb78;
      color: white;
    }

    .btn-edit, .btn-delete {
      border: none;
      padding: 6px 10px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      font-weight: 600;
    }

    .notice-title a {
      text-decoration: none;
      color: #1a1a1a;
      transition: color 0.2s;
    }

    .notice-title a:hover {
      color: #667eea;
    }

    .btn-edit { background: #48bb78; color: white; }
    .btn-delete { background: #e53e3e; color: white; }
    .btn-edit:hover { background: #38a169; }
    .btn-delete:hover { background: #c53030; }
    
    /* 검색 결과 메시지 */
    .search-result-message {
      background: #e6f7ff;
      border: 1px solid #91d5ff;
      border-radius: 6px;
      padding: 12px 16px;
      margin-bottom: 20px;
      color: #0050b3;
      font-size: 14px;
      display: none;
      align-items: center;
      gap: 8px;
    }
    .search-result-message.active {
      display: flex;
    }

    /* 검색 결과 없음 */
    .no-result {
      text-align: center;
      padding: 40px 20px;
      color: #718096;
      font-size: 14px;
      display: none;
    }
    .no-result.active {
      display: block;
    }
    .no-result i {
      font-size: 48px;
      margin-bottom: 12px;
      opacity: 0.5;
    }    

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
        <button class="btn-login" onclick="logout()"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</button>
      </div>
    </div>
  </header>

  <div class="admin-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <h3>관리 메뉴</h3>
      <ul>
        <li><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li><i class="fa-solid fa-users"></i> 회원관리</li>
        <li><i class="fa-solid fa-building"></i> 매물관리</li>
        <li class="active"><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li><i class="fa-solid fa-envelope"></i> 문의관리</li>
        <li><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
      <div class="page-header">
        <h2>공지사항관리 (<span id="noticeCount">0</span>건)</h2>
        <button class="btn-create" onclick="location.href='/uniland/community/notice-write'">
          <i class="fa-solid fa-pen"></i> 공지 작성
        </button>
      </div>

      <!-- 검색 결과 메시지 -->
      <div class="search-result-message" id="searchResultMessage">
        <i class="fa-solid fa-info-circle"></i>
        <span id="searchResultText"></span>
      </div>

      <!-- 검색 박스 -->
      <div class="search-box">
        <select id="searchCategory">
          <option value="all">전체</option>
          <option value="title">제목</option>
          <option value="writer">작성자</option>
          <option value="date">작성일</option>
        </select>
        <input type="text" id="searchInput" placeholder="검색어를 입력하세요" onkeypress="if(event.keyCode==13) searchNotice()">
        <button class="btn-search" onclick="searchNotice()">
          <i class="fa-solid fa-search"></i> 검색
        </button>
        <button class="btn-reset" onclick="resetSearch()">
          <i class="fa-solid fa-rotate-right"></i> 초기화
        </button>
      </div>

      <!-- 공지 목록 테이블 -->
      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="noticeTable">
          <c:forEach var="notice" items="${noticeList}">
            <tr data-title="${notice.noticeSubject}"
                data-writer="${notice.noticeWriter}"
                data-date="<fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd" />">
              <td>${notice.noticeNo}</td>
              <td class="notice-title">
                <a href="${pageContext.request.contextPath}/community/notice/${notice.noticeNo}">
                  <c:if test="${notice.noticeImportant == 'Y'}">
                    <span class="badge badge-important">중요</span>
                  </c:if>
                  <c:if test="${notice.noticeIsnew == 'Y'}">
                    <span class="badge badge-new">NEW</span>
                  </c:if>
                  ${notice.noticeSubject}
                </a>
              </td>
              <td>${notice.noticeWriter}</td>
              <td><fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd" /></td>
              <td>${notice.viewCount}</td>
              <td>
                <div class="manage-btn">
                  <button class="btn-edit" onclick="location.href='${pageContext.request.contextPath}/community/notice-update/${notice.noticeNo}'">
                    <i class="fa-solid fa-pen"></i> 수정
                  </button>
                  <form action="${pageContext.request.contextPath}/community/notice/delete/${notice.noticeNo}" method="post" style="display:inline;">
                    <button type="submit" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">
                      <i class="fa-solid fa-trash"></i> 삭제
                    </button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      
      <!-- 검색 결과 없음 -->
      <div id="noResult" class="no-result">
        <i class="fa-solid fa-inbox"></i>
        <div>검색 결과가 없습니다.</div>
      </div>
      
      <!-- 공지사항 없음 -->
      <c:if test="${empty noticeList}">
        <div class="no-result active">
          <i class="fa-solid fa-inbox"></i>
          <div>등록된 공지사항이 없습니다.</div>
        </div>
      </c:if>
    </main>
  </div>

  <!-- 푸터 -->
  <footer>
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    // 검색 기능
    function searchNotice() {
      const category = document.getElementById('searchCategory').value;
      // 검색 시 대소문자를 구분하지 않도록 toLowerCase()를 사용
      const keyword = document.getElementById('searchInput').value.trim().toLowerCase();
      
      if (!keyword) {
        alert('검색어를 입력하세요.');
        return;
      }

      const rows = document.querySelectorAll('#noticeTable tr');
      let visibleCount = 0; // 검색된 행의 수
      
      rows.forEach(row => {
        // data- 속성 값을 가져올 때 null 체크를 위해 || '' 사용
        const title = row.getAttribute('data-title')?.toLowerCase() || '';
        const writer = row.getAttribute('data-writer')?.toLowerCase() || '';
        const date = row.getAttribute('data-date') || ''; // 날짜는 대소문자 구분 불필요
        
        let isMatch = false;
        
        if (category === 'all') {
          isMatch = title.includes(keyword) ||
                    writer.includes(keyword) ||
                    date.includes(keyword);
        } else if (category === 'title') {
          isMatch = title.includes(keyword);
        } else if (category === 'writer') {
          isMatch = writer.includes(keyword);
        } else if (category === 'date') {
          isMatch = date.includes(keyword);
        }
        
        if (isMatch) {
          row.style.display = '';
          visibleCount++;
        } else {
          row.style.display = 'none';
        }
      });

      // 검색 결과 메시지 및 카운트 업데이트
      const searchResultMessage = document.getElementById('searchResultMessage');
      const searchResultText = document.getElementById('searchResultText');
      const noResultDiv = document.getElementById('noResult');
      
      // 검색 결과 메시지 표시/숨김
      searchResultMessage.classList.add('active');
      
      if (visibleCount > 0) {
    	  searchResultText.textContent = "'" + keyword + "' 검색 결과";
        noResultDiv.classList.remove('active'); // 검색 결과가 있으면 숨김
      } else {
    	  searchResultText.textContent = "'" + keyword + "' 검색 결과가 없습니다.";
        noResultDiv.classList.add('active'); // 검색 결과가 없으면 표시
      }
     
      // 최종 카운트 업데이트
      document.getElementById('noticeCount').textContent = visibleCount;
    }

 // 검색 초기화
    function resetSearch() {
      // 1. 입력 필드 및 카테고리 초기화
      document.getElementById('searchCategory').value = 'all';
      document.getElementById('searchInput').value = '';
      
      // 2. 검색 결과 메시지 숨김 및 텍스트 초기화 (🌟 이 부분이 중요합니다)
      document.getElementById('searchResultMessage').classList.remove('active');
      document.getElementById('searchResultText').textContent = ''; // 👈 이 코드를 추가하거나 확인하세요
      
      // 3. 모든 행 표시
      document.querySelectorAll('#noticeTable tr').forEach(row => {
        row.style.display = '';
      });
      
      // 4. '검색 결과 없음' 메시지 숨김
      document.getElementById('noResult').classList.remove('active');

      // 5. 최종 카운트 업데이트 (전체 목록 수로 복원)
      updateCount();
    }

 // 카운트 업데이트
    function updateCount() {
      const rows = document.querySelectorAll('#noticeTable tr');
      let visibleCount = 0;
      
      rows.forEach(row => {
        // display 속성이 'none'이 아닌 경우만 카운트
        if (row.style.display !== 'none') visibleCount++; 
      });
      
      // 최종 카운트 업데이트
      document.getElementById('noticeCount').textContent = visibleCount;
    }

    // 페이지 로드 시 초기 카운트
    window.addEventListener('DOMContentLoaded', function() {
      updateCount();
    });

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
    function logout() {
      if (confirm('로그아웃 하시겠습니까?')) {
        window.location.href = '${pageContext.request.contextPath}/auth/logout';
      }
    }
  </script>
</body>