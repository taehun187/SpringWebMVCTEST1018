<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test Request Headers</title>
</head>
<body>
    <h1>Test Request Header</h1>
    <form action="requestheader" method="get">
        <button type="button" onclick="sendRequest()">Get Request Headers</button>
    </form>
    <h2 id="result"></h2>

    <h1>Test /demo Request Header</h1>
    <form action="demo" method="get">
        <button type="button" onclick="sendDemoRequest()">Get Demo Headers</button>
    </form>
    <h2 id="demoResult"></h2>

    <script>
        // Function to test /requestheader endpoint
        function sendRequest() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/requestheader", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("result").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        // Function to test /demo endpoint
        function sendDemoRequest() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/demo", true);
            xhr.setRequestHeader("Accept-Encoding", "gzip, deflate");
            xhr.setRequestHeader("Keep-Alive", "300");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("demoResult").innerHTML = "Request sent successfully, check server logs for header details.";
                }
            };
            xhr.send();
        }
    </script>
</body>
</html>