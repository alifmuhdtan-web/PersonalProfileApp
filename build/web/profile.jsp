<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Profile Information</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="profile-card">

    <h1>Student Profile</h1>

    <div class="profile-row">
        <strong>Full Name:</strong>
        <span>${name}</span>
    </div>

    <div class="profile-row">
        <strong>Student ID:</strong>
        <span>${studentId}</span>
    </div>

    <div class="profile-row">
        <strong>Program:</strong>
        <span>${program}</span>
    </div>

    <div class="profile-row">
        <strong>Email:</strong>
        <span>${email}</span>
    </div>

    <div class="profile-row">
        <strong>Hobbies:</strong>
        <span>${hobbies}</span>
    </div>

    <div class="profile-row">
        <strong>Introduction:</strong>
        <span>${intro}</span>
    </div>

    <div class="profile-row">
        <strong>Submitted On:</strong>
        <span>${submitTime}</span>
    </div>

    <br>

    <a class="back-btn" href="index.html">Back to Form</a>

</div>

</body>
</html>