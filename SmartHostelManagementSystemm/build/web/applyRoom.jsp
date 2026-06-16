<%-- 
    Document   : applyRoom
    Created on : 22 May 2026, 12:50:12 am
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

    <title>Apply Room</title>

    <style>

        body{
            font-family: Arial;
            background-color: #f2f2f2;
        }

        .container{
            width: 400px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        input{
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }

        button{
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            background-color: green;
            color: white;
            border: none;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>Apply Hostel Room</h2>

    <form action="ApplyRoomServlet" method="post">

        <input type="number"
               name="roomId"
               placeholder="Enter Room ID"
               required>

        <button type="submit">
            Apply Room
        </button>

    </form>

</div>

</body>
</html>
