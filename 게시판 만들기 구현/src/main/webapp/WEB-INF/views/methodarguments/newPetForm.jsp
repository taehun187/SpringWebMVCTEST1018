<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Pet</title>
</head>
<body>
    <h1>Add New Pet</h1>
    <form action="${pageContext.request.contextPath}/pet/new" method="post">
        <label for="name">Pet Name:</label>
        <input type="text" id="name" name="name" value="${pet.name}" required>
        <br><br>

        <label for="type">Pet Type:</label>
        <input type="text" id="type" name="type" value="${pet.type}" required>
        <br><br>

        <label for="age">Pet Age:</label>
        <input type="number" id="age" name="age" value="${pet.age}" required>
        <br><br>

        <button type="submit">Add Pet</button>
    </form>
</body>
</html>