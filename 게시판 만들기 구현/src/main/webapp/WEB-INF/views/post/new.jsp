<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Post</title>
</head>
<body>
    <h1>Create New Post</h1>

    <form:form method="post" action="${pageContext.request.contextPath}/posts" modelAttribute="post">
        <label for="title">Title:</label>
        <form:input path="title" />
        <br />

        <label for="email">Email:</label>
        <form:input path="email" />
        <br />

        <label for="web">Website:</label>
        <form:input path="web" />
        <br />

        <label for="content">Text:</label>
        <form:textarea path="content" />
        <br />

        <button type="submit" class="btn">Submit</button>
        <a href="${pageContext.request.contextPath}/posts" class="btn btn-cancel">Cancel</a>
    </form:form>
</body>
</html>