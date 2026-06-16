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
    <title>Admin Dashboard</title>
    <style>
        *{ margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body{ background-color: #f4f6f9; }

        /* NAVBAR */
        .navbar{ background: linear-gradient(to right, #001f4d, #0059b3); padding: 18px 40px; display: flex; justify-content: space-between; align-items: center; }
        .logo-title{ color: white; font-size: 26px; font-weight: bold; }
        .nav-links a{ color: white; text-decoration: none; margin-left: 25px; font-weight: bold; transition: 0.3s; }
        .nav-links a:hover{ color: #d9e6ff; }

        /* HERO SECTION */
        .hero{ width: 90%; margin: 40px auto; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .hero img{ width: 100%; height: 380px; object-fit: cover; }
        .hero-content{ padding: 40px; text-align: center; }
        .hero-content h1{ color: #003366; font-size: 42px; margin-bottom: 15px; }
        .hero-content p{ color: #666; font-size: 18px; margin-bottom: 30px; }

        /* DASHBOARD CARDS */
        .dashboard-cards{ width: 90%; margin: auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; margin-bottom: 50px; }
        .card{ background: white; padding: 30px; border-radius: 18px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: 0.3s; }
        .card:hover{ transform: translateY(-5px); }
        .card h3{ color: #003366; margin-bottom: 15px; font-size: 24px; }
        .card p{ color: #666; margin-bottom: 20px; line-height: 1.5; }
        .card a{ display: inline-block; padding: 10px 20px; background: #0059b3; color: white; text-decoration: none; border-radius: 8px; font-weight: bold; transition: 0.3s; }
        .card a:hover{ background: #003366; }

        /* FOOTER */
        .footer{ background: #001f4d; color: white; text-align: center; padding: 18px; margin-top: 40px; }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo-title">Smart Hostel Admin</div>
    <div class="nav-links">
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="manageUsers.jsp">Manage Users</a>
        <a href="addRoom.jsp">Add Room</a>
        <a href="manageRooms.jsp">Manage Rooms</a>
        <a href="viewComplaints.jsp">View Complaints</a>
        <a href="viewApplications.jsp">View Applications</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="hero">
    <img src="<%= request.getContextPath() %>/image/hostel.jpg" alt="Hostel Image">
    <div class="hero-content">
        <h1>Welcome,  <%= user.getName() %></h1>
        <p>Manage hostel rooms, student applications, and complaints efficiently through the Smart Hostel Management System.</p>
    </div>
</div>

<div class="dashboard-cards">
    <div class="card">
        <h3>Manage Users</h3>
        <p>View, edit, and remove registered students and users.</p>
        <a href="manageUsers.jsp">Manage Users</a>
    </div>
    
    <div class="card">
        <h3>Add Rooms</h3>
        <p>Add new hostel rooms and update room availability easily.</p>
        <a href="addRoom.jsp">Add Room</a>
    </div>
    <div class="card">
        <h3>Manage Rooms</h3>
        <p>View, edit, and manage all hostel room information.</p>
        <a href="manageRooms.jsp">Manage</a>
    </div>
    <div class="card">
        <h3>View Complaints</h3>
        <p>Check and respond to student complaints and hostel issues.</p>
        <a href="viewComplaints.jsp">View Complaints</a>
    </div>
    <div class="card">
        <h3>Room Applications</h3>
        <p>Review student room applications and approve requests.</p>
        <a href="viewApplications.jsp">View Applications</a>
    </div>
</div>

<div class="footer">
    © 2026 Smart Hostel Management System | Admin Dashboard
</div>

</body>
</html>