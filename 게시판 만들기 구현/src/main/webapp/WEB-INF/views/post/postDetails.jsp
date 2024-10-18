<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Post Detail</title>
</head>
<body>
    <h1>${post.title}</h1>
    <p><strong>Author:</strong> ${post.username}</p>
    <p><strong>Email:</strong> ${post.email}</p>
    <p><strong>Website:</strong> ${post.web}</p>
    <p><strong>Content:</strong> ${post.content}</p>

    <!-- 게시글 수정 -->
    <a href="${pageContext.request.contextPath}/posts/${post.id}/edit" class="btn">Edit Post</a>

    <!-- 댓글 목록 -->
    <h2>Comments</h2>
    <c:if test="${!empty comments}">
        <ul>
            <c:forEach var="comment" items="${comments}">
                <li>
                    <strong>${comment.name} (${comment.email})</strong>: ${comment.text}
                    <form method="get" action="${pageContext.request.contextPath}/posts/${post.id}/comments/${comment.id}/edit" style="display:inline;">
                        <button type="submit">Edit</button>
                    </form>
                    <form method="post" action="${pageContext.request.contextPath}/posts/${post.id}/comments/${comment.id}/delete" style="display:inline;">
                        <button type="submit" onclick="return confirm('Are you sure you want to delete this comment?');">Delete</button>
                    </form>
                </li>
            </c:forEach>
        </ul>
    </c:if>
    <c:if test="${empty comments}">
        <p>No comments yet.</p>
    </c:if>

    <!-- 댓글 추가 폼 -->
    <h2>Add a Comment</h2>
    <form:form method="post" modelAttribute="comment" action="${pageContext.request.contextPath}/posts/${post.id}/comments">
        <label for="name">Name:</label>
        <form:input path="name" />
        <br/>
        <label for="email">Email:</label>
        <form:input path="email" />
        <br/>
        <label for="text">Comment:</label>
        <form:textarea path="text"></form:textarea>
        <br/>
        <button type="submit">Submit Comment</button>
    </form:form>

    <!-- 게시글 삭제 -->
    <form action="${pageContext.request.contextPath}/posts/${post.id}/delete" method="post">
        <button type="submit" class="btn btn-cancel" onclick="return confirm('Are you sure you want to delete this post?');">Delete Post</button>
    </form>

    <a href="${pageContext.request.contextPath}/posts">Back to Posts</a>
</body>
</html>
