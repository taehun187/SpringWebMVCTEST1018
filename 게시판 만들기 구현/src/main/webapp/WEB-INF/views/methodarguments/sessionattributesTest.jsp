<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test Session Attributes</title>
</head>
<body>
    <h1>Edit Pet</h1>
    
    <!-- Form for submitting Pet details -->
    <form id="petForm">
        <label for="petId">Pet ID:</label>
        <input type="text" id="petId" name="petId" value="1">
        <br><br>

        <label for="name">Pet Name:</label>
        <input type="text" id="name" name="name" value="Buddy">
        <br><br>

        <label for="type">Pet Type:</label>
        <input type="text" id="type" name="type" value="Dog">
        <br><br>

        <label for="age">Pet Age:</label>
        <input type="number" id="age" name="age" value="5">
        <br><br>

        <button type="button" onclick="submitPetForm()">Submit Pet Form</button>
    </form>

    <h2>Server Response for POST:</h2>
    <pre id="postResult"></pre>

    <h1>Get Pet from Session</h1>
    <button type="button" onclick="getPetFromSession()">Get Pet Info</button>

    <h2>Server Response for GET:</h2>
    <pre id="getResult"></pre>

    <script>
        // Function to submit Pet details via POST
        function submitPetForm() {
            var pet = {
                petId: document.getElementById("petId").value,
                name: document.getElementById("name").value,
                type: document.getElementById("type").value,
                age: document.getElementById("age").value
            };

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/pets/1/edit", true);
            xhr.setRequestHeader("Content-Type", "application/json");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("postResult").innerText = xhr.responseText;
                }
            };

            xhr.send(JSON.stringify(pet));
        }

        // Function to get Pet details from the session via GET
        function getPetFromSession() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/pets/1/edit", true);

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("getResult").innerText = xhr.responseText;
                }
            };

            xhr.send();
        }
    </script>
</body>
</html>