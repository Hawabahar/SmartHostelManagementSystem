<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>

<%
    int userId = Integer.parseInt(request.getParameter("id"));
    UserDAO userDAO = new UserDAO();
    User editUser = userDAO.getUserById(userId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <style>
        body{ font-family: Arial; background-color: #f2f2f2; margin: 0; padding: 0; }
        .container{ width: 450px; margin: 60px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        h2{ text-align: center; margin-bottom: 30px; color: #333; }
        label{ font-weight: bold; display: block; margin-top: 15px; margin-bottom: 8px; }
        input, select{ width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 15px; }
        button{ width: 100%; padding: 12px; margin-top: 25px; background-color: #0066cc; color: white; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; }
        button:hover{ background-color: #0052a3; }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit User</h2>
    
    <form action="UpdateUserServlet" method="post">
        
        <input type="hidden" name="userId" value="<%= editUser.getUserId() %>">

        <label>Name</label>
        <input type="text" name="name" value="<%= editUser.getName() %>" required>

        <label>Email</label>
        <input type="email" name="email" value="<%= editUser.getEmail() %>" required>

        <label>Password</label>
        <input type="text" name="password" value="<%= editUser.getPassword() %>" required>

        <label>Role</label>
        <select name="role">
            <option value="student" <%= editUser.getRole().equals("student") ? "selected" : "" %>>Student</option>
            <option value="admin" <%= editUser.getRole().equals("admin") ? "selected" : "" %>>Admin</option>
        </select>

        <button type="submit">Update User</button>
        
    </form>
</div>

</body>
</html>