<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중개사 문의하기 - UNILAND</title>
</head>
<body>
    <h1>중개사 문의하기</h1>

    <!-- TODO: 중개사 문의 작성 폼 구현 -->
    <!--
    - 매물 정보 표시 (propertyId로 조회)
    - 문의 제목 입력
    - 문의 내용 입력
    - 제출 버튼
    -->

    <form action="${pageContext.request.contextPath}/inquiry/realtor" method="post">
        <input type="hidden" name="inquiryType" value="REALTOR">
        <input type="hidden" name="propertyId" value="${param.propertyId}">
        <!-- TODO: realtorId, userId 추가 -->

        <!-- TODO: 폼 필드 추가 -->

        <button type="submit">문의하기</button>
    </form>
</body>
</html>
