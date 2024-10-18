<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pet List</title>
</head>
<body>
    <h1>Pet List</h1>

    <c:choose>
        <c:when test="${not empty petList}">
            <ul>
                <c:forEach var="pet" items="${petList}">
                    <li>Pet ID: ${pet.petId}, Name: ${pet.name}, Type: ${pet.type}, Age: ${pet.age}</li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <p>${message}</p>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/pet/new">Add New Pet</a>
</body>
</html>