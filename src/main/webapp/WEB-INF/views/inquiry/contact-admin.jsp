<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 문의하기 - UNILAND</title>
</head>
<body>
    <h1>관리자 문의하기</h1>

    <!-- TODO: 관리자 문의 작성 폼 구현 -->
    <!--
    - 문의 카테고리 선택 (일반문의, 건의사항, 허위매물신고, 기타)
    - 허위매물신고 선택 시 매물 검색 기능
    - 문의 제목 입력
    - 문의 내용 입력
    - 제출 버튼
    -->

    <form action="${pageContext.request.contextPath}/inquiry/admin" method="post">
        <input type="hidden" name="inquiryType" value="ADMIN">
        <!-- TODO: userId 추가 -->

        <label>카테고리:</label>
        <select name="category">
            <option value="일반문의">일반문의</option>
            <option value="건의사항">건의사항</option>
            <option value="허위매물신고">허위매물신고</option>
            <option value="기타">기타</option>
        </select>

        <!-- TODO: 폼 필드 추가 -->

        <button type="submit">문의하기</button>
    </form>
</body>
</html>
