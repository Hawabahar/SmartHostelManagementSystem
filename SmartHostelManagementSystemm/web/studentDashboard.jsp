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

    <title>Student Dashboard</title>

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

        .hero{
            width: 90%;
            margin: 40px auto;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .hero img{
            width: 100%;
            height: 350px;
            object-fit: cover;
        }

        .hero-content{
            padding: 40px;
            text-align: center;
        }

        .hero-content h1{
            color: #003366;
            margin-bottom: 15px;
            font-size: 38px;
        }

        .hero-content p{
            color: #555;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .cards{
            width: 90%;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }

        .card{
            background: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .card:hover{
            transform: translateY(-5px);
        }

        .card h3{
            color: #003366;
            margin-bottom: 15px;
        }

        .card p{
            color: #666;
            margin-bottom: 20px;
        }

        .card a{
            display: inline-block;
            padding: 10px 20px;
            background: #0059b3;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .card a:hover{
            background: #003366;
        }

        .footer{
            background: #003366;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 40px;
        }

    </style>

</head>

<body>

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

<div class="hero">

    <img src="<%= request.getContextPath() %>/image/hostel.jpg"
         alt="Hostel Image">

    <div class="hero-content">

        <h1>
            Welcome, <%= user.getName() %>
        </h1>

        <p>
            Manage your hostel activities easily using the Smart Hostel Management System.
        </p>

    </div>

</div>

<div class="cards">

    <div class="card">

        <h3>View Rooms</h3>

        <p>
            Browse available hostel rooms and check room details.
        </p>

        <a href="viewRooms.jsp">
            View Rooms
        </a>

    </div>

    <div class="card">

        <h3>Submit Complaint</h3>

        <p>
            Report hostel issues and complaints directly to management.
        </p>

        <a href="complaint.jsp">
            Submit Now
        </a>

    </div>


</div>

<div class="footer">

    © 2026 Smart Hostel Management System

</div>

</body>
</html>