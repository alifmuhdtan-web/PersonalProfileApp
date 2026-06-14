<%@ page isErrorPage="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Student Profile System</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            text-align: center;
            animation: shake 0.5s ease-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        .header {
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
            color: white;
            padding: 40px;
        }
        
        .header h1 {
            font-size: 48px;
            margin-bottom: 10px;
        }
        
        .content {
            padding: 40px;
        }
        
        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        
        .error-message {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            color: #d32f2f;
            font-family: monospace;
        }
        
        .btn-home {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>⚠️ Error</h1>
            <p>Something went wrong</p>
        </div>
        
        <div class="content">
            <div class="error-icon">
                😵
            </div>
            
            <h3>An unexpected error occurred</h3>
            
            <div class="error-message">
                <%= exception != null ? exception.getMessage() : "Unknown error" %>
            </div>
            
            <p>Please try again or contact support.</p>
            
            <a href="index.html" class="btn-home">← Return to Home</a>
        </div>
    </div>
</body>
</html>