<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account Registration</title>
</head>
<body>
    <h1>Account Registration Form</h1>

    <form onsubmit="event.preventDefault(); submitForm();">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        <br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email">
        <br><br>

        <button type="submit">Submit</button>
    </form>

    <h2 id="result">Result will be displayed here</h2>

    <!-- 자바스크립트 코드를 body 끝에 배치 -->
    <script>
        function submitForm() {
            console.log("submitForm function called");

            // 폼 데이터 가져오기
            var account = {
                name: document.getElementById("name").value,
                email: document.getElementById("email").value
            };

            // AJAX 요청을 통해 JSON 데이터 전송
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/accounts", true);
            xhr.setRequestHeader("Content-Type", "application/json");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("result").innerHTML = "Account successfully submitted!";
                } else if (xhr.readyState === 4) {
                    document.getElementById("result").innerHTML = "Error: " + xhr.status;
                }
            };

            // JSON 데이터를 전송
            xhr.send(JSON.stringify(account));
        }
    </script>
</body>
</html>