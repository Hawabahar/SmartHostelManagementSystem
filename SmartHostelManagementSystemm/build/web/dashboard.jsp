<%-- 
    Document   : dashboard
    Created on : 21 May 2026, 11:18:38 pm
    Author     : User
--%>

<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <title>Dashboard</title>

    <style>

        body{
            font-family: Arial;
            margin: 0;
            background-color: #f2f2f2;
        }

        .navbar{
            background-color: #003366;
            padding: 15px;
        }

        .navbar a{
            color: white;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }

        .container{
            width: 80%;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }

        h1{
            color: #003366;
        }

    </style>

</head>

<body>

<div class="navbar">

    <a href="dashboard.jsp">Dashboard</a>

    <a href="viewRooms.jsp">View Rooms</a>

    <a href="addRoom.jsp">Add Room</a>

    <a href="complaint.jsp">Complaint</a>

    <a href="logout.jsp">Logout</a>

</div>

<div class="container">

    <h1>
        Welcome, <%= user.getName() %>!
    </h1>

    <h3>
        Role: <%= user.getRole() %>
    </h3>

    <p>
        Welcome to Smart Hostel Management System.
    </p>

</div>

</body>
</html>
