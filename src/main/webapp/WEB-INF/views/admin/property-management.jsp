<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>UNILAND 관리자 - 매물관리</title>
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

    .admin-container { flex: 1; display: flex; min-height: calc(100vh - 150px); }

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
    .total-count {
      font-size: 14px;
      color: #666;
      margin-left: 10px;
    }

    /* 검색 & 페이지 사이즈 선택 */
    .control-box {
      background: white;
      border: 1px solid #e5e5e5;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .search-box {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 15px;
    }
    .page-size-box {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .page-size-box label {
      font-size: 14px;
      color: #555;
      font-weight: 500;
    }
    .search-box select, .search-box input, .page-size-box select {
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }
    .search-box select { width: 130px; }
    .search-box input { flex: 1; }
    .page-size-box select { width: 100px; }
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

    table {
      width: 100%;
      background: white;
      border-collapse: collapse;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
      margin-bottom: 20px;
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

    .action-btns {
      display: flex;
      justify-content: center;
      gap: 5px;
    }
    .action-btns button {
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      transition: all 0.2s;
    }
    .btn-edit { background: #48bb78; color: white; }
    .btn-edit:hover { background: #38a169; }
    .btn-delete { background: #e53e3e; color: white; }
    .btn-delete:hover { background: #c53030; }

    .status-active { color: #48bb78; font-weight: 600; }
    .status-reserved { color: #ed8936; font-weight: 600; }
    .status-completed { color: #4299e1; font-weight: 600; }

    /* 페이징 */
    .pagination {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 8px;
      margin-top: 30px;
      padding: 20px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .pagination button {
      border: 1px solid #ddd;
      background: white;
      padding: 8px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      transition: all 0.2s;
      min-width: 36px;
    }
    .pagination button:hover:not(:disabled) {
      background: #f0f2ff;
      border-color: #667eea;
      color: #667eea;
    }
    .pagination button:disabled {
      cursor: not-allowed;
      opacity: 0.5;
    }
    .pagination button.active {
      background: #667eea;
      color: white;
      border-color: #667eea;
      font-weight: 600;
    }
    .pagination .page-info {
      margin: 0 15px;
      font-size: 14px;
      color: #666;
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
      justify-content: center;
      align-items: center;
    }
    .modal-content {
      background: white;
      padding: 30px;
      border-radius: 12px;
      width: 400px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.3);
    }
    .modal-header {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 20px;
      color: #333;
    }
    .modal-body {
      margin-bottom: 20px;
    }
    .modal-body label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #555;
    }
    .modal-body select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }
    .modal-footer {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }
    .btn-cancel {
      background: #e2e8f0;
      color: #333;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
    }
    .btn-confirm {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
    }

    .loading {
      display: none;
      text-align: center;
      padding: 20px;
      color: #666;
    }

    .empty-list {
      text-align: center;
      padding: 40px;
      color: #999;
      background: white;
      border-radius: 8px;
    }

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
    <aside class="sidebar">
      <h3>관리 메뉴</h3>
      <ul>
        <li><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li><i class="fa-solid fa-users"></i> 회원관리</li>
        <li class="active"><i class="fa-solid fa-building"></i> 매물관리</li>
        <li><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li><i class="fa-solid fa-envelope"></i> 문의관리</li>
        <li><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <main class="main-content">
      <div class="page-header">
        <div>
          <h2>매물관리 <span class="total-count" id="totalCount">총 ${pageInfo.totalElements}건</span></h2>
        </div>
      </div>

      <div class="control-box">
        <div class="search-box">
          <select id="searchCategory" name="currentSearchCategory">
            <option value="name">건물명</option>
            <option value="type">유형</option>
            <option value="price">가격</option>
            <option value="location">위치</option>
            <option value="owner">등록자</option>
            <option value="contact">연락처</option>
            <option value="date">등록일</option>
          </select>
          <input type="text" id="searchInput" placeholder="검색어를 입력하세요" onkeypress="handleEnterKey(event)" name="currentSearchKeyword">
          <button class="btn-search" onclick="searchListing()"><i class="fa-solid fa-magnifying-glass"></i> 검색</button>
        </div>
        <div class="page-size-box">
          <label>페이지당 항목 수:</label>
          <select id="pageSizeSelect" onchange="changePageSize()">
            <option value="10" ${pageInfo.size == 10 ? 'selected' : ''}>10개</option>
            <option value="20" ${pageInfo.size == 20 ? 'selected' : ''}>20개</option>
            <option value="30" ${pageInfo.size == 30 ? 'selected' : ''}>30개</option>
            <option value="50" ${pageInfo.size == 50 ? 'selected' : ''}>50개</option>
          </select>
        </div>
      </div>

      <div class="loading" id="loading">
        <i class="fa-solid fa-spinner fa-spin"></i> 로딩 중...
      </div>

      <div id="tableContainer">
        <c:choose>
          <c:when test="${empty propertyList}">
            <div class="empty-list">
              <i class="fa-solid fa-folder-open" style="font-size: 48px; color: #ddd; margin-bottom: 10px;"></i>
              <p>등록된 매물이 없습니다.</p>
            </div>
          </c:when>
          <c:otherwise>
            <table>
              <thead>
                <tr>
                  <th>No.</th>
                  <th>건물명</th>
                  <th>유형</th>
                  <th>가격</th>
                  <th>위치</th>
                  <th>등록자</th>
                  <th>등록자 구분</th>
                  <th>연락처</th>
                  <th>상태</th>
                  <th>등록일</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody id="listingTable">
                <c:forEach items="${propertyList}" var="property" varStatus="status">
                  <tr>
                    <td>${(pageInfo.currentPage - 1) * pageInfo.size + status.count}</td>
                    <td>${property.propertyName}</td>
                    <td>${property.propertyType}</td>
                    <td>${property.priceDisplay}</td>
                    <td>${property.location}</td>
                    <td>${property.ownerName}</td>
                    <td>${property.ownerType}</td>
                    <td>${property.ownerContact}</td>
                    <td>
                      <c:choose>
                        <c:when test="${property.status == 'ACTIVE'}">
                          <span class="status-active">등록</span>
                        </c:when>
                        <c:when test="${property.status == 'RESERVED'}">
                          <span class="status-reserved">예약중</span>
                        </c:when>
                        <c:when test="${property.status == 'COMPLETED'}">
                          <span class="status-completed">거래완료</span>
                        </c:when>
                        <c:otherwise>
                          <span>${property.status}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td><fmt:formatDate value="${property.createdAt}" pattern="yyyy-MM-dd" /></td>
                    <td class="action-btns">
                      <button class="btn-edit" onclick="openStatusModal(${property.propertyNo}, '${property.status}')">
                        <i class="fa-solid fa-pen"></i> 수정
                      </button>
                      <button class="btn-delete" onclick="deleteProperty(${property.propertyNo})">
                        <i class="fa-solid fa-trash"></i> 삭제
                      </button>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 페이징 -->
      <div class="pagination" id="pagination">
      
        <button onclick="goToPage(1)" ${pageInfo.first ? 'disabled' : ''}>
          <i class="fa-solid fa-angles-left"></i>
        </button>
        
        <button onclick="goToPage(${pageInfo.currentPage - 1})" ${!pageInfo.hasPrevious ? 'disabled' : ''}>
          <i class="fa-solid fa-angle-left"><</i>
        </button>
        
        <c:forEach items="${pageInfo.pageNumbers}" var="pageNum">
          <button onclick="goToPage(${pageNum})" class="${pageNum == pageInfo.currentPage ? 'active' : ''}">
            ${pageNum}
          </button>
        </c:forEach>
        
        <button onclick="goToPage(${pageInfo.currentPage + 1})" ${!pageInfo.hasNext ? 'disabled' : ''}>
          <i class="fa-solid fa-angle-right">></i>
        </button>
        
        <button onclick="goToPage(${pageInfo.totalPages})" ${pageInfo.last ? 'disabled' : ''}>
          <i class="fa-solid fa-angles-right"></i>
        </button>
        
        <span class="page-info">${pageInfo.currentPage} / ${pageInfo.totalPages} 페이지</span>
      </div>
    </main>
  </div>

  <div class="modal" id="statusModal">
    <div class="modal-content">
      <div class="modal-header">매물 상태 변경</div>
      <div class="modal-body">
        <label for="statusSelect">변경할 상태를 선택하세요:</label>
        <select id="statusSelect">
          <option value="ACTIVE">등록</option>
          <option value="RESERVED">예약중</option>
          <option value="COMPLETED">거래완료</option>
        </select>
      </div>
      <div class="modal-footer">
        <button class="btn-cancel" onclick="closeStatusModal()">취소</button>
        <button class="btn-confirm" onclick="confirmStatusChange()">확인</button>
      </div>
    </div>
  </div>

  <footer>
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    let currentPropertyNo = null;
    let currentPage = ${pageInfo.currentPage};
    let currentPageSize = ${pageInfo.size};
    let currentSearchCategory = '';
    let currentSearchKeyword = '';
    
    let totalPages = ${pageInfo.totalPages};

    function goToPage(page) {
        if (page < 1 || page > totalPages) return;

        const url = '${pageContext.request.contextPath}/admin/api/properties/search' +
                    '?page=' + page +
                    '&size=' + currentPageSize +
                    '&searchCategory=' + encodeURIComponent(currentSearchCategory) +
                    '&searchKeyword=' + encodeURIComponent(currentSearchKeyword);
        
        loadProperties(url);
      }


    function changePageSize() {
      currentPageSize = document.getElementById('pageSizeSelect').value;
      goToPage(1);
    }

    function searchListing() {
      currentSearchCategory = document.getElementById('searchCategory').value;
      currentSearchKeyword = document.getElementById('searchInput').value.trim();
      currentPage = 1;
      goToPage(1);
    }

    function handleEnterKey(event) {
      if (event.key === 'Enter') {
        searchListing();
      }
    }

    function loadProperties(url) {
      document.getElementById('loading').style.display = 'block';
      document.getElementById('tableContainer').style.display = 'none';

      fetch(url)
        .then(response => response.json())
        .then(pageResponse => {
          console.log('응답 데이터:', pageResponse);
          
          if (pageResponse && pageResponse.content) {
            renderTable(pageResponse.content, pageResponse);
            renderPagination(pageResponse);
            document.getElementById('totalCount').textContent = '총 ' + pageResponse.totalElements + '건';
            currentPage = pageResponse.currentPage;
          } else {
            alert('조회 중 오류가 발생했습니다.');
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert('조회 중 오류가 발생했습니다: ' + error.message);
        })
        .finally(() => {
          document.getElementById('loading').style.display = 'none';
          document.getElementById('tableContainer').style.display = 'block';
        });
      
      
      totalPages = pageResponse.totalPages;
      
      console.log("📍 현재 페이지:", pageResponse.currentPage);
      console.log("📍 총 페이지 수:", pageResponse.totalPages);
      console.log("📍 받은 데이터 개수:", pageResponse.content.length);
    }

    function renderTable(properties, pageInfo) {
       const tbody = document.querySelector('#listingTable');
       if (!tbody) return; // table 구조가 처음 없으면 무시

       if (properties.length === 0) {
         tbody.innerHTML = `
           <tr><td colspan="11" style="text-align:center;">검색 결과가 없습니다.</td></tr>
         `;
         return;
       }

       let rows = '';
       properties.forEach((property, index) => {
         const rowNum = (pageInfo.currentPage - 1) * pageInfo.size + index + 1;
         const createdDate = new Date(property.createdAt).toISOString().split('T')[0];
         const statusClass = property.status === 'ACTIVE' ? 'status-active' :
                            property.status === 'RESERVED' ? 'status-reserved' :
                            property.status === 'COMPLETED' ? 'status-completed' : '';

         rows += `
           <tr>
             <td>${rowNum}</td>
             <td>${property.propertyName || '-'}</td>
             <td>${property.propertyType || '-'}</td>
             <td>${property.priceDisplay || '-'}</td>
             <td>${property.location || '-'}</td>
             <td>${property.ownerName || '-'}</td>
             <td>${property.ownerType || '-'}</td>
             <td>${property.ownerContact || '-'}</td>
             <td><span class="${statusClass}">${property.status}</span></td>
             <td>${createdDate}</td>
             <td class="action-btns">
               <button class="btn-edit" onclick="openStatusModal(${property.propertyNo}, '${property.status}')">
                 <i class="fa-solid fa-pen"></i> 수정
               </button>
               <button class="btn-delete" onclick="deleteProperty(${property.propertyNo})">
                 <i class="fa-solid fa-trash"></i> 삭제
               </button>
             </td>
           </tr>
         `;
       });
       tbody.innerHTML = rows;
     }

    function renderPagination(pageInfo) {
      const container = document.getElementById('pagination');
      
      let paginationHTML = `
        <button onclick="goToPage(1)" ${pageInfo.first ? 'disabled' : ''}>
          <i class="fa-solid fa-angles-left"></i>
        </button>
        <button onclick="goToPage(${pageInfo.currentPage - 1})" ${!pageInfo.hasPrevious ? 'disabled' : ''}>
          <i class="fa-solid fa-angle-left"></i>
        </button>
      `;
      
      pageInfo.pageNumbers.forEach(pageNum => {
        paginationHTML += `
          <button onclick="goToPage(${pageNum})" class="${pageNum == pageInfo.currentPage ? 'active' : ''}">
            ${pageNum}
          </button>
        `;
      });
      
      paginationHTML += `
        <button onclick="goToPage(${pageInfo.currentPage + 1})" ${!pageInfo.hasNext ? 'disabled' : ''}>
          <i class="fa-solid fa-angle-right"></i>
        </button>
        <button onclick="goToPage(${pageInfo.totalPages})" ${pageInfo.last ? 'disabled' : ''}>
          <i class="fa-solid fa-angles-right"></i>
        </button>
        <span class="page-info">${pageInfo.currentPage} / ${pageInfo.totalPages} 페이지</span>
      `;
      
      container.innerHTML = paginationHTML;
    }

    function openStatusModal(propertyNo, currentStatus) {
      currentPropertyNo = propertyNo;
      document.getElementById('statusSelect').value = currentStatus;
      document.getElementById('statusModal').style.display = 'flex';
    }

    function closeStatusModal() {
      document.getElementById('statusModal').style.display = 'none';
      currentPropertyNo = null;
    }

    function confirmStatusChange() {
      const newStatus = document.getElementById('statusSelect').value;

      fetch('${pageContext.request.contextPath}/admin/api/properties/' + currentPropertyNo + '/status?status=' + newStatus, {
        method: 'PUT'
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          alert(data.message);
          closeStatusModal();
          goToPage(currentPage);
        } else {
          alert(data.message);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('상태 변경 중 오류가 발생했습니다.');
      });
    }

    function deleteProperty(propertyNo) {
      if (!confirm('정말 삭제하시겠습니까?\n삭제된 매물은 복구할 수 없습니다.')) {
        return;
      }

      fetch('${pageContext.request.contextPath}/admin/api/properties/' + propertyNo, {
        method: 'DELETE'
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          alert(data.message);
          goToPage(currentPage);
        } else {
          alert(data.message);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('삭제 중 오류가 발생했습니다.');
      });
    }

    document.querySelectorAll('.sidebar li').forEach((item, index) => {
      item.addEventListener('click', function() {
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

    document.querySelector('.logo').addEventListener('click', function() {
      window.location.href = '${pageContext.request.contextPath}/uniland';
    });

    function logout() {
      if (confirm('로그아웃 하시겠습니까?')) {
        window.location.href = '${pageContext.request.contextPath}/auth/logout';
      }
    }
  </script>
</body>
</html>