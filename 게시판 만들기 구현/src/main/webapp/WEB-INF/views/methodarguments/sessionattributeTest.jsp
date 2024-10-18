<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Session Test</title>
</head>
<body>
    <h2>Session Test Page</h2>

    <!-- Add to session -->
    <form action="${pageContext.request.contextPath}/session/add" method="get">
        <input type="submit" value="Add User to Session">
    </form>
    <br>

    <!-- Get session value -->
    <form action="${pageContext.request.contextPath}/session/get" method="get">
        <input type="submit" value="Get User from Session">
    </form>
    <br>

    <!-- Remove from session -->
    <form action="${pageContext.request.contextPath}/session/remove" method="get">
        <input type="submit" value="Remove User from Session">
    </form>

</body>
</html>