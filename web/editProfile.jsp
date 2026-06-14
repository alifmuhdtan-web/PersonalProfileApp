<%@ page import="com.profile.ProfileBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
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
        }
        
        .header {
            background: linear-gradient(135deg, #FF9800 0%, #F57C00 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 { font-size: 28px; margin-bottom: 10px; }
        
        .form-container { padding: 40px; }
        
        .form-group { margin-bottom: 20px; }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .required { color: #e74c3c; }
        
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
        }
        
        textarea { resize: vertical; min-height: 80px; }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn-update {
            flex: 1;
            background: #FF9800;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }
        
        .btn-cancel {
            flex: 1;
            background: #999;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✏️ Edit Profile</h1>
            <p>Update student profile information</p>
        </div>
        
        <div class="form-container">
            <%
                ProfileBean profile = (ProfileBean) request.getAttribute("profile");
                if (profile != null) {
            %>
            <form action="ProfileServlet" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= profile.getId() %>">
                
                <div class="form-group">
                    <label>Full Name <span class="required">*</span></label>
                    <input type="text" name="name" value="<%= profile.getName() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Student ID <span class="required">*</span></label>
                    <input type="text" name="studentId" value="<%= profile.getStudentId() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Programme <span class="required">*</span></label>
                    <input type="text" name="programme" value="<%= profile.getProgramme() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Email <span class="required">*</span></label>
                    <input type="email" name="email" value="<%= profile.getEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label>Hobbies</label>
                    <input type="text" name="hobbies" value="<%= profile.getHobbies() != null ? profile.getHobbies() : "" %>">
                </div>
                
                <div class="form-group">
                    <label>Self Introduction</label>
                    <textarea name="intro"><%= profile.getIntro() != null ? profile.getIntro() : "" %></textarea>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn-update">💾 Update Profile</button>
                    <a href="ProfileServlet?action=list" class="btn-cancel">❌ Cancel</a>
                </div>
            </form>
            <% } else { %>
            <p>Profile not found!</p>
            <a href="ProfileServlet?action=list">Back to list</a>
            <% } %>
        </div>
    </div>
</body>
</html>