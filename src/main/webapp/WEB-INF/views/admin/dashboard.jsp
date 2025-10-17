<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UNILAND 관리자 페이지</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
      height: 50px;
      object-fit: contain;
      cursor: pointer;
    }
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

    .dashboard-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
    }
    .dashboard-header h2 {
      font-size: 24px;
      font-weight: 700;
      color: #1a1a1a;
    }

    /* 통계 카드 */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
      margin-bottom: 40px;
    }

    .stat-card {
      background: white;
      border-radius: 8px;
      padding: 24px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e5e5e5;
      display: flex;
      align-items: center;
      justify-content: space-between;
      transition: transform 0.2s;
    }

    .stat-card:hover { transform: translateY(-3px); }

    .stat-card i {
      font-size: 28px;
      color: #667eea;
    }

    .stat-info h4 {
      font-size: 13px;
      color: #666;
      margin-bottom: 6px;
    }

    .stat-info p {
      font-size: 20px;
      font-weight: 700;
      color: #1a1a1a;
    }

    /* 차트 */
    .chart-container {
      background: white;
      border-radius: 8px;
      padding: 24px;
      border: 1px solid #e5e5e5;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      margin-bottom: 40px;
    }

    .chart-container h3 {
      font-size: 16px;
      margin-bottom: 20px;
      color: #1a1a1a;
    }

    /* 최근 공지사항 */
    .notice-list {
      background: white;
      border-radius: 8px;
      border: 1px solid #e5e5e5;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 24px;
    }

    .notice-list h3 {
      font-size: 16px;
      margin-bottom: 20px;
      color: #1a1a1a;
    }

    .notice-list table {
      width: 100%;
      border-collapse: collapse;
    }

    .notice-list th, .notice-list td {
      padding: 12px;
      border-bottom: 1px solid #f0f0f0;
      text-align: left;
      font-size: 14px;
    }

    .notice-list th {
      background: #f5f5f5;
      color: #555;
      font-weight: 600;
    }

    .notice-list tr:hover td {
      background: #f9faff;
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
        <li class="active"><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li><i class="fa-solid fa-users"></i> 회원관리</li>
        <li><i class="fa-solid fa-building"></i> 매물관리</li>
        <li><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li><i class="fa-solid fa-envelope"></i> 문의관리</li>
        <li><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
      <div class="dashboard-header">
        <h2>관리자 대시보드</h2>
      </div>

      <!-- 통계 카드 -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-info">
            <h4>총 회원 수</h4>
            <p>1,245명</p>
          </div>
          <i class="fa-solid fa-user-group"></i>
        </div>

        <div class="stat-card">
          <div class="stat-info">
            <h4>등록 매물</h4>
            <p>382건</p>
          </div>
          <i class="fa-solid fa-building"></i>
        </div>

        <div class="stat-card">
          <div class="stat-info">
            <h4>미처리 문의</h4>
            <p>12건</p>
          </div>
          <i class="fa-solid fa-envelope-circle-check"></i>
        </div>
      </div>

      <!-- 차트 -->
      <div class="chart-container">
        <h3>일별 회원 증감 현황</h3>
        <canvas id="userChart" height="100"></canvas>
      </div>

      <!-- 최근 공지사항 -->
      <div class="notice-list">
        <h3>최근 공지사항</h3>
        <table>
          <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
            <tr><td>5</td><td>AI 매물 추천 기능 개선 안내</td><td>2025-10-10</td></tr>
            <tr><td>4</td><td>신입생 이벤트 결과 발표</td><td>2025-09-28</td></tr>
            <tr><td>3</td><td>중개사 회원가입 절차 변경</td><td>2025-09-20</td></tr>
            <tr><td>2</td><td>모바일 앱 베타 서비스 오픈</td><td>2025-09-01</td></tr>
            <tr><td>1</td><td>UNILAND 관리자 페이지 오픈</td><td>2025-08-15</td></tr>
          </tbody>
        </table>
      </div>
    </main>
  </div>

  <!-- 푸터 -->
  <footer>
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    // 회원 증감 차트
    const ctx = document.getElementById('userChart').getContext('2d');
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: ['10/1', '10/2', '10/3', '10/4', '10/5', '10/6', '10/7'],
        datasets: [{
          label: '신규 회원 수',
          data: [5, 12, 8, 15, 9, 14, 10],
          borderColor: '#667eea',
          backgroundColor: 'rgba(102, 126, 234, 0.15)',
          fill: true,
          tension: 0.3
        }]
      },
      options: {
        plugins: { legend: { display: false } },
        scales: {
          y: { beginAtZero: true, ticks: { stepSize: 5 } }
        }
      }
    });

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
      window.location.href = '${pageContext.request.contextPath}/uniland';
    });

    // 로그아웃
    document.querySelector('.btn-login').addEventListener('click', function() {
      if (confirm('로그아웃 하시겠습니까?')) {
        alert('로그아웃되었습니다.');
        window.location.href = '${pageContext.request.contextPath}/auth/login';
      }
    });
  </script>
</body>
</html>
