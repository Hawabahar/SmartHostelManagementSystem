<%@ page import="java.util.List" %>
<%@ page import="model.Application" %>
<%@ page import="dao.ApplicationDAO" %>
<%@ page import="model.User" %>

<%
    // Security check - ensure only logged-in students can view this
    User user = (User) session.getAttribute("user");
    if(user == null || !user.getRole().equalsIgnoreCase("student")){
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch only the applications belonging to this specific student
    ApplicationDAO applicationDAO = new ApplicationDAO();
    List<Application> myList = applicationDAO.getApplicationsByUserId(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <style>
        *{ margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body{ background-color: #f4f6f9; }

        /* NAVBAR */
        .navbar{ background: linear-gradient(to right, #003366, #0059b3); padding: 18px 40px; display: flex; justify-content: space-between; align-items: center; }
        .logo-title{ color: white; font-size: 24px; font-weight: bold; }
        .nav-links a{ color: white; text-decoration: none; margin-left: 25px; font-weight: bold; transition: 0.3s; }
        .nav-links a:hover{ color: #d9e6ff; }

        /* HERO SECTION */
        .hero{ width: 90%; margin: 40px auto 20px; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .hero img{ width: 100%; height: 280px; object-fit: cover; }
        .hero-content{ padding: 35px; text-align: center; }
        .hero-content h1{ color: #003366; font-size: 38px; margin-bottom: 10px; }
        .hero-content p{ color: #666; font-size: 17px; }

        /* TABLE SECTION */
        .table-container{ width: 90%; margin: 30px auto 50px; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); overflow-x: auto; }
        table{ width: 100%; border-collapse: collapse; }
        th{ background: #003366; color: white; padding: 15px; font-size: 16px; }
        td{ padding: 15px; text-align: center; border-bottom: 1px solid #ddd; }
        tr:hover{ background-color: #f5f9ff; }

        /* STATUS COLORS */
        .pending{ color: orange; font-weight: bold; }
        .approved{ color: green; font-weight: bold; }
        .rejected{ color: red; font-weight: bold; }

        /* FOOTER */
        .footer{ background: #003366; color: white; text-align: center; padding: 15px; margin-top: 30px; }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo-title">Smart Hostel</div>
    <div class="nav-links">
        <a href="studentDashboard.jsp">Dashboard</a>
        <a href="viewRooms.jsp">View Rooms</a>
        <a href="myApplications.jsp">My Applications</a>
        <a href="complaint.jsp">Submit Complaint</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="hero">
    <img src="<%= request.getContextPath() %>/image/hostel.jpg" alt="Hostel Image">
    <div class="hero-content">
        <h1>My Room Applications</h1>
        <p>Track the approval status of your hostel room requests.</p>
    </div>
</div>

<div class="table-container">
    <table>
        <tr>
            <th>Application ID</th>
            <th>Room Number</th>
            <th>Status</th>
        </tr>
        <% 
            if(myList.isEmpty()) { 
        %>
            <tr>
                <td colspan="3" style="color: gray; font-style: italic;">You have not applied for any rooms yet.</td>
            </tr>
        <% 
            } else {
                for(Application app : myList){ 
        %>
        <tr>
            <td><%= app.getApplicationId() %></td>
            <td><%= app.getRoomNumber() %></td>
            <td>
                <% if(app.getStatus().equalsIgnoreCase("Pending")){ %>
                    <span class="pending">Pending Admin Approval</span>
                <% } else if(app.getStatus().equalsIgnoreCase("Approved")){ %>
                    <span class="approved">Approved & Reserved</span>
                <% } else { %>
                    <span class="rejected">Rejected</span>
                <% } %>
            </td>
        </tr>
        <% 
                }
            } 
        %>
    </table>
</div>

<div class="footer">
    © 2026 Smart Hostel Management System
</div>

</body>
</html>