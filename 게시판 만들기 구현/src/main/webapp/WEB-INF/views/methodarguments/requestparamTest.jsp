<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test Request Params, Search Pets, and Process Form</title>
</head>
<body>
    <h1>Test Request Params, Search Pets, and Process Form</h1>

    <!-- Test /requestparam endpoint -->
    <h2>Test RequestParam (name)</h2>
    <form action="requestparam" method="get">
        <label for="name">Enter your name:</label>
        <input type="text" id="name" name="name">
        <button type="button" onclick="sendRequest()">Submit with Name</button>
        <button type="button" onclick="sendRequestWithoutName()">Submit Without Name</button>
    </form>
    <h3>Result from /requestparam:</h3>
    <h2 id="requestParamResult"></h2>

    <!-- Test /search endpoint -->
    <h2>Test Search Pets (types)</h2>
    <form action="search" method="get">
        <label for="type1">Enter pet type 1:</label>
        <input type="text" id="type1" name="type">
        <br>
        <label for="type2">Enter pet type 2:</label>
        <input type="text" id="type2" name="type">
        <br>
        <button type="button" onclick="sendSearchRequest()">Search Pets</button>
    </form>
    <h3>Result from /search:</h3>
    <h2 id="searchResult"></h2>

    <!-- Test /process endpoint -->
    <h2>Test Process Form</h2>
    <form id="processForm">
        <label for="key1">Key 1:</label>
        <input type="text" id="key1" name="key1">
        <br>
        <label for="key2">Key 2:</label>
        <input type="text" id="key2" name="key2">
        <br>
        <button type="button" onclick="sendProcessForm()">Submit Form</button>
    </form>
    <h3>Result from /process:</h3>
    <h2 id="processResult"></h2>

    <script>
        // Function to test /requestparam endpoint with a name parameter
        function sendRequest() {
            var name = document.getElementById("name").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/requestparam?name=" + encodeURIComponent(name), true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("requestParamResult").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        // Function to test /requestparam endpoint without a name parameter
        function sendRequestWithoutName() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/requestparam", true); // name 파라미터 없이 전송
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("requestParamResult").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        // Function to test /search endpoint with pet types
        function sendSearchRequest() {
            var type1 = document.getElementById("type1").value;
            var type2 = document.getElementById("type2").value;
            
            var params = "type=" + encodeURIComponent(type1);
            if (type2) {
                params += "&type=" + encodeURIComponent(type2);
            }

            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/search?" + params, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("searchResult").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        // Function to test /process endpoint with form data
        function sendProcessForm() {
            var formData = new FormData(document.getElementById("processForm"));
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/process", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            // Converting formData to URL-encoded format
            var params = new URLSearchParams(formData).toString();

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("processResult").innerHTML = xhr.responseText;
                }
            };
            xhr.send(params);
        }
    </script>
</body>
</html>