<%@ page import="com.profile.Profile" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Submitted Successfully</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .content {
            padding: 40px;
        }
        
        .success-icon {
            text-align: center;
            font-size: 80px;
            margin-bottom: 20px;
            animation: bounce 0.5s ease-out;
        }
        
        @keyframes bounce {
            0% {
                transform: scale(0);
            }
            50% {
                transform: scale(1.2);
            }
            100% {
                transform: scale(1);
            }
        }
        
        .info-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 10px;
            padding: 25px;
            margin: 20px 0;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .info-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: bold;
            width: 130px;
            color: #555;
            font-size: 14px;
        }
        
        .info-value {
            flex: 1;
            color: #333;
            font-size: 14px;
            word-break: break-word;
        }
        
        .timestamp {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            border-radius: 8px;
            color: #2e7d32;
            font-weight: 500;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn-home, .btn-view {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-home {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
        }
        
        .btn-view {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            color: white;
        }
        
        .btn-home:hover, .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .btn-home:active, .btn-view:active {
            transform: translateY(0);
        }
        
        @media (max-width: 600px) {
            .content {
                padding: 20px;
            }
            
            .info-row {
                flex-direction: column;
            }
            
            .info-label {
                width: 100%;
                margin-bottom: 5px;
            }
            
            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✅ Profile Submitted Successfully!</h1>
            <p>Your information has been saved to the database</p>
        </div>
        
        <div class="content">
            <div class="success-icon">
                🎉
            </div>
            
            <div class="info-card">
                <div class="info-row">
                    <div class="info-label">📛 Full Name:</div>
                    <div class="info-value"><%= request.getAttribute("name") %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">🆔 Student ID:</div>
                    <div class="info-value"><%= request.getAttribute("studentId") %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">🎓 Programme:</div>
                    <div class="info-value"><%= request.getAttribute("program") %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">📧 Email:</div>
                    <div class="info-value"><%= request.getAttribute("email") %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">🎨 Hobbies:</div>
                    <div class="info-value"><%= (request.getAttribute("hobbies") != null && !request.getAttribute("hobbies").toString().isEmpty()) ? request.getAttribute("hobbies") : "Not specified" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label">💭 Introduction:</div>
                    <div class="info-value"><%= (request.getAttribute("intro") != null && !request.getAttribute("intro").toString().isEmpty()) ? request.getAttribute("intro") : "Not specified" %></div>
                </div>
            </div>
            
            <div class="timestamp">
                📅 Submitted on: <%= new SimpleDateFormat("EEEE, MMMM d, yyyy 'at' h:mm a").format((Date)request.getAttribute("submitTime")) %>
            </div>
            
            <div class="button-group">
                <a href="index.html" class="btn-home">📝 Register Another Profile</a>
                <a href="ProfileServlet?action=viewAll" class="btn-view">📋 View All Profiles</a>
            </div>
        </div>
    </div>
</body>
</html>