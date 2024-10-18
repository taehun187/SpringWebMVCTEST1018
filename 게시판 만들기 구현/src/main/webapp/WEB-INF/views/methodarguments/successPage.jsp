<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Success</title>
</head>
<body>
    <h2>Form Submission Successful!</h2>
    <p>User Name: ${param.name}</p>
    <p>User Age: ${param.age}</p>
    <!-- 플래시 속성 사용 -->
    <c:if test="${not empty successMessage}">
        <p>${successMessage}</p>
    </c:if>
</body>
</html>