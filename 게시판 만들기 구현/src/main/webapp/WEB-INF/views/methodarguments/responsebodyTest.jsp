<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test ResponseBodyController</title>
</head>
<body>
    <h1>Test ResponseBodyController</h1>

    <h2>Test Account Info</h2>
    <button onclick="getAccount()">Get Account Info</button>
    <div id="accountResult">Account details will be displayed here.</div>

    <h2>Download File</h2>
    <button onclick="downloadFile()">Download Example File</button>

    <!-- 스크립트 코드를 body 끝에 배치 -->
    <script>
        // /accounts/{id} 엔드포인트를 호출하여 Account 객체를 가져오는 함수
        function getAccount() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "${pageContext.request.contextPath}/accounts/1", true);
            xhr.setRequestHeader("Content-Type", "application/json");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var account = JSON.parse(xhr.responseText);
                    document.getElementById("accountResult").innerHTML = 
                        "Name: " + account.name + "<br>" + "Email: " + account.email;
                }
            };
            xhr.send();
        }

        // /accounts/download 엔드포인트를 호출하여 파일을 다운로드하는 함수
        function downloadFile() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "${pageContext.request.contextPath}/accounts/download", true);
            xhr.responseType = "blob";  // 바이너리 파일 데이터를 처리하기 위해 blob 사용

            xhr.onload = function() {
                if (xhr.status === 200) {
                    var link = document.createElement("a");
                    link.href = window.URL.createObjectURL(xhr.response);
                    link.download = "example.txt";  // 파일명을 지정
                    link.click();
                }
            };
            xhr.send();
        }
    </script>
</body>
</html>