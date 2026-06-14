<%@ page import="java.util.List, com.profile.ProfileBean, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 { font-size: 32px; margin-bottom: 10px; }
        .header p { font-size: 14px; opacity: 0.9; }
        
        .content { padding: 30px; }
        
        .stats {
            background: linear-gradient(135deg, #f0f0f0 0%, #e0e0e0 100%);
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            text-align: center;
            font-size: 16px;
            font-weight: 500;
        }
        
        .stats span {
            font-weight: bold;
            color: #667eea;
            font-size: 24px;
        }
        
        .message {
            background: #4CAF50;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .error {
            background: #f44336;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .search-filter-bar {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            flex: 1;
        }
        
        .search-box {
            flex: 2;
            display: flex;
            gap: 10px;
        }
        
        .search-box input {
            flex: 1;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
        }
        
        .filter-box {
            flex: 1;
            display: flex;
            gap: 10px;
        }
        
        .filter-box select {
            flex: 1;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
        }
        
        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary { background: #667eea; color: white; }
        .btn-edit { background: #2196F3; color: white; }
        .btn-delete { background: #f44336; color: white; }
        .btn-add { background: #4CAF50; color: white; }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
        }
        
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        tr:hover { background-color: #f5f5f5; }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .action-buttons a {
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
        }
        
        @media (max-width: 768px) {
            .content { padding: 15px; overflow-x: auto; }
            .top-bar { flex-direction: column; }
            .search-filter-bar { width: 100%; }
            .btn-add { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Student Profile Management System</h1>
            <p>Manage all registered student profiles</p>
        </div>
        
        <div class="content">
            <% 
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
                if (message != null && !message.isEmpty()) {
            %>
            <div class="message"><%= message %></div>
            <% } else if (error != null && !error.isEmpty()) { %>
            <div class="error"><%= error %></div>
            <% } %>
            
            <div class="stats">
                📊 Total Registered Profiles: <span><%= request.getAttribute("totalProfiles") != null ? request.getAttribute("totalProfiles") : "0" %></span> students
            </div>
            
            <div class="top-bar">
                <div class="search-filter-bar">
                    <form action="ProfileServlet" method="GET" class="search-box">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword" placeholder="🔍 Search by name or student ID..." 
                               value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : "" %>">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                    
                    <form action="ProfileServlet" method="GET" class="filter-box">
                        <input type="hidden" name="action" value="filter">
                        <select name="programme">
                            <option value="">All Programmes</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Information Technology">Information Technology</option>
                            <option value="Software Engineering">Software Engineering</option>
                        </select>
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </form>
                </div>
                
                <a href="index.html" class="btn btn-add">➕ Add New Profile</a>
            </div>
            
            <%
                List<ProfileBean> profiles = (List<ProfileBean>) request.getAttribute("profiles");
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                
                if (profiles != null && !profiles.isEmpty()) {
            %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Student ID</th>
                        <th>Programme</th>
                        <th>Email</th>
                        <th>Hobbies</th>
                        <th>Introduction</th>
                        <th>Submitted</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (ProfileBean p : profiles) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><strong><%= p.getName() %></strong></td>
                        <td><%= p.getStudentId() %></td>
                        <td><%= p.getProgramme() %></td>
                        <td><%= p.getEmail() %></td>
                        <td><%= (p.getHobbies() != null && !p.getHobbies().isEmpty()) ? p.getHobbies() : "-" %></td>
                        <td style="max-width: 200px; word-wrap: break-word;">
                            <%= (p.getIntro() != null && p.getIntro().length() > 50) ? p.getIntro().substring(0, 50) + "..." : (p.getIntro() != null ? p.getIntro() : "-") %>
                        </td>
                        <td><%= sdf.format(p.getCreatedAt()) %></td>
                        <td class="action-buttons">
                            <a href="ProfileServlet?action=edit&id=<%= p.getId() %>" class="btn-edit" style="color:white; text-decoration:none;">✏️ Edit</a>
                            <a href="ProfileServlet?action=delete&id=<%= p.getId() %>" class="btn-delete" style="color:white; text-decoration:none;" 
                               onclick="return confirm('Are you sure you want to delete this profile?')">🗑️ Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <div style="text-align: center; padding: 60px;">
                <p style="font-size: 18px; color: #666;">No profiles found!</p>
                <br>
                <a href="index.html" class="btn-add" style="display: inline-block; padding: 10px 20px;">➕ Add your first profile</a>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>