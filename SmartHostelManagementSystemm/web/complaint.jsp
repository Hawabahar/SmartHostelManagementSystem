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

    <title>Submit Complaint</title>

    <style>

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body{
            background-color: #f4f6f9;
        }

        /* NAVBAR */

        .navbar{
            background: linear-gradient(to right, #003366, #0059b3);
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-title{
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links a{
            color: white;
            text-decoration: none;
            margin-left: 25px;
            font-weight: bold;
            transition: 0.3s;
        }

        .nav-links a:hover{
            color: #d9e6ff;
        }

        /* HERO SECTION */

        .hero{
            width: 90%;
            margin: 40px auto 20px;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .hero img{
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .hero-content{
            padding: 35px;
            text-align: center;
        }

        .hero-content h1{
            color: #003366;
            font-size: 38px;
            margin-bottom: 10px;
        }

        .hero-content p{
            color: #666;
            font-size: 17px;
        }

        /* FORM SECTION */

        .container{
            width: 50%;
            margin: 30px auto 50px;
            background: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .container h2{
            text-align: center;
            color: #003366;
            margin-bottom: 25px;
        }

        textarea{
            width: 100%;
            height: 180px;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 10px;
            resize: none;
            font-size: 15px;
            transition: 0.3s;
        }

        textarea:focus{
            border-color: #0059b3;
            outline: none;
            box-shadow: 0 0 5px rgba(0,89,179,0.3);
        }

        button{
            width: 100%;
            padding: 14px;
            margin-top: 20px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover{
            background: #b02a37;
        }

        /* FOOTER */

        .footer{
            background: #003366;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 30px;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

    <div class="logo-title">
        Smart Hostel
    </div>

    <div class="nav-links">

        <a href="studentDashboard.jsp">Dashboard</a>

        <a href="viewRooms.jsp">View Rooms</a>

        <a href="myApplications.jsp">My Applications</a>
        
        <a href="complaint.jsp">Submit Complaint</a>

        <a href="logout.jsp">Logout</a>

    </div>

</div>

<!-- HERO SECTION -->

<div class="hero">

    <img src="<%= request.getContextPath() %>/image/hostel.jpg"
         alt="Hostel Image">

    <div class="hero-content">

        <h1>Submit Complaint</h1>

        <p>
            Report hostel issues and help us improve your living experience.
        </p>

    </div>

</div>

<!-- FORM -->

<div class="container">

    <h2>Complaint Form</h2>

    <form action="ComplaintServlet" method="post">

        <textarea name="description"
                  placeholder="Describe your complaint here..."
                  required></textarea>

        <button type="submit">
            Submit Complaint
        </button>

    </form>

</div>

<!-- FOOTER -->

<div class="footer">

    © 2026 Smart Hostel Management System

</div>

</body>
</html>