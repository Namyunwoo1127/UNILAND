<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UNILAND 관리자 - 문의관리</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    /* =======================================
      UNILAND 관리자 공통 스타일
    ======================================== */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
      background-color: #f5f5f5;
      color: #1a1a1a;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
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
    .logo img { height: 50px; cursor: pointer; }

    .btn-login {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 25px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease, transform 0.2s ease;
    }
    .btn-login:hover { background: #5a67d8; transform: translateY(-2px); }
    .btn-login:active { background: #4c51bf; transform: translateY(0); }

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
    .page-header h2 { font-size: 24px; font-weight: 700; color: #1a1a1a; }

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
    .search-box select { width: 140px; }
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

    /* 관리 버튼 */
    .action-btns button {
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      margin: 0 4px;
      transition: all 0.2s;
    }
    .btn-answer { background: #48bb78; color: white; }
    .btn-answer:hover { background: #38a169; }
    .btn-delete { background: #e53e3e; color: white; }
    .btn-delete:hover { background: #c53030; }

    /* 상태 표시 */
    .status-complete { color: green; font-weight: 600; }
    .status-pending { color: red; font-weight: 600; }

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

  <div class="admin-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <h3>관리 메뉴</h3>
      <ul>
        <li><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li><i class="fa-solid fa-users"></i> 회원관리</li>
        <li><i class="fa-solid fa-building"></i> 매물관리</li>
        <li><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li class="active"><i class="fa-solid fa-envelope"></i> 문의관리</li>
              <li><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
      <div class="page-header">
        <h2>문의관리</h2>
      </div>

      <!-- 검색 박스 -->
      <div class="search-box">
        <select id="searchCategory">
          <option value="title">제목</option>
          <option value="author">작성자</option>
          <option value="category">카테고리</option>
          <option value="date">문의일자</option>
        </select>
        <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
        <button class="btn-search" onclick="searchInquiry()">검색</button>
      </div>

      <!-- 문의 테이블 -->
      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성자</th>
            <th>카테고리</th>
            <th>문의일자</th>
            <th>상태</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="inquiryTable">
          <tr>
            <td>1</td>
            <td>회원가입 관련 문의</td>
            <td>김재훈</td>
            <td>회원관리</td>
            <td>2025-10-01</td>
            <td class="status-pending">미답변</td>
            <td class="action-btns">
              <button class="btn-answer"><i class="fa-solid fa-reply"></i> 답변</button>
              <button class="btn-delete"><i class="fa-solid fa-trash"></i> 삭제</button>
            </td>
          </tr>
          <tr>
            <td>2</td>
            <td>결제 오류 문의</td>
            <td>이민지</td>
            <td>결제</td>
            <td>2025-10-03</td>
            <td class="status-complete">답변완료</td>
            <td class="action-btns">
              <button class="btn-answer"><i class="fa-solid fa-reply"></i> 답변</button>
              <button class="btn-delete"><i class="fa-solid fa-trash"></i> 삭제</button>
            </td>
          </tr>
        </tbody>
      </table>
    </main>
  </div>

  <!-- 푸터 -->
  <footer>
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    function searchInquiry() {
      const category = document.getElementById('searchCategory').value;
      const keyword = document.getElementById('searchInput').value.toLowerCase();
      const rows = document.querySelectorAll('#inquiryTable tr');
      rows.forEach(row => {
        const cells = row.getElementsByTagName('td');
        let text = '';
        if (category === 'title') text = cells[1].textContent;
        else if (category === 'author') text = cells[2].textContent;
        else if (category === 'category') text = cells[3].textContent;
        else if (category === 'date') text = cells[4].textContent;
        row.style.display = text.toLowerCase().includes(keyword) ? '' : 'none';
      });
    }

    // 사이드바 메뉴 클릭
    document.querySelectorAll('.sidebar li').forEach((item, index) => {
      item.addEventListener('click', function() {
        document.querySelectorAll('.sidebar li').forEach(li => li.classList.remove('active'));
        this.classList.add('active');

        const pages = ['${pageContext.request.contextPath}/admin/dashboard', '${pageContext.request.contextPath}/admin/user-management', '${pageContext.request.contextPath}/admin/property-management', '${pageContext.request.contextPath}/admin/content-management', '${pageContext.request.contextPath}/admin/inquiry-management', '${pageContext.request.contextPath}/admin/realtor-approval'];
        if (pages[index]) {
          window.location.href = pages[index];
        }
      });
    });

    // 로고 클릭
    document.querySelector('.logo').addEventListener('click', function() {
      window.location.href = '${pageContext.request.contextPath}uniland';
    });

    // 로그아웃
    document.querySelector('.btn-login').addEventListener('click', function() {
      if (confirm('로그아웃 하시겠습니까?')) {
        alert('로그아웃되었습니다.');
        window.location.href = '${pageContext.request.contextPath}/auth/login';
      }
    });

    // 답변/삭제 버튼
    document.querySelectorAll('.btn-answer').forEach(btn => {
      btn.addEventListener('click', function() {
        alert('답변 작성 기능은 준비중입니다.');
      });
    });

    document.querySelectorAll('.btn-delete').forEach(btn => {
      btn.addEventListener('click', function() {
        if (confirm('정말 삭제하시겠습니까?')) {
          alert('삭제되었습니다.');
        }
      });
    });
  </script>
</body>
</html>
