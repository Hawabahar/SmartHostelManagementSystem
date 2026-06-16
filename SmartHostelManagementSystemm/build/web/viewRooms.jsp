<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ page import="dao.RoomDAO" %>
<%@ page import="model.User" %>
<%@ page import="model.Application" %>
<%@ page import="dao.ApplicationDAO" %>

<%
    // 1. Security Check
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Check if the student already has an active application
    boolean canApply = true;
    if (user.getRole().equalsIgnoreCase("student")) {
        ApplicationDAO applicationDAO = new ApplicationDAO();
        List<Application> userApps = applicationDAO.getApplicationsByUserId(user.getUserId());
        for (Application app : userApps) {
            if (app.getStatus().equalsIgnoreCase("Pending") || app.getStatus().equalsIgnoreCase("Approved")) {
                canApply = false;
                break;
            }
        }
    }

    // 3. Fetch the rooms
    RoomDAO roomDAO = new RoomDAO();
    List<Room> roomList = roomDAO.getAllRooms();
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Rooms</title>
    <style>
        *{ margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body{ background-color: #f4f6f9; }

        /* NAVBAR */
        .navbar{ background: linear-gradient(to right, #003366, #0059b3); padding: 18px 40px; display: flex; justify-content: space-between; align-items: center; }
        .logo-title{ color: white; font-size: 24px; font-weight: bold; }
        .nav-links a{ color: white; text-decoration: none; margin-left: 25px; font-weight: bold; transition: 0.3s; }
        .nav-links a:hover{ color: #d9e6ff; }

        /* HEADER */
        .header-section{ width: 90%; margin: 40px auto 20px; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .header-section img{ width: 100%; height: 300px; object-fit: cover; }
        .header-content{ padding: 30px; text-align: center; }
        .header-content h2{ color: #003366; font-size: 38px; margin-bottom: 10px; }
        .header-content p{ color: #666; font-size: 17px; }

        /* TABLE */
        .table-container{ width: 90%; margin: 30px auto 50px; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); overflow-x: auto; }
        table{ width: 100%; border-collapse: collapse; }
        th{ background: #003366; color: white; padding: 15px; font-size: 16px; }
        td{ padding: 15px; text-align: center; border-bottom: 1px solid #ddd; }
        tr:hover{ background-color: #f5f9ff; }

        .available{ color: green; font-weight: bold; }
        .occupied{ color: red; font-weight: bold; }
        .full-text{ color: red; font-weight: bold; }

        /* ACTIVE BUTTON */
        .apply-btn{
            background: #28a745;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        .apply-btn:hover:not(:disabled){
            background: #218838;
        }

        /* GREYED OUT DISABLED BUTTON */
        .apply-btn:disabled {
            background: #cccccc;
            color: #666666;
            cursor: not-allowed;
        }

        /* FOOTER */
        .footer{ background: #003366; color: white; text-align: center; padding: 15px; margin-top: 30px; }
    </style>
</head>
<body>

<!-- NAVBAR -->
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

<!-- HEADER -->
<div class="header-section">
    <img src="<%= request.getContextPath() %>/image/hostel.jpg" alt="Hostel Image">
    <div class="header-content">
        <h2>Available Hostel Rooms</h2>
        <p>Browse and apply for available hostel rooms easily.</p>
    </div>
</div>

<!-- TABLE -->
<div class="table-container">
    <table>
        <tr>
            <th>Room ID</th>
            <th>Room Number</th>
            <th>Capacity</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <% for(Room room : roomList){ %>
        <tr>
            <td><%= room.getRoomId() %></td>
            <td><%= room.getRoomNumber() %></td>
            <td><%= room.getCapacity() %></td>
            <td>
                <% if(room.getStatus().equalsIgnoreCase("Available")) { %>
                    <span class="available">Available</span>
                <% } else { %>
                    <span class="occupied">Occupied</span>
                <% } %>
            </td>
            <td>
                <% if(room.getStatus().equalsIgnoreCase("Available")) { %>
                    <form action="ApplyRoomServlet" method="post">
                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">
                        
                        <%-- Conditionally render the button based on user's active applications --%>
                        <% if(canApply) { %>
                            <button type="submit" class="apply-btn">Apply</button>
                        <% } else { %>
                            <button type="button" class="apply-btn" disabled title="you've already applied for a room">Apply</button>
                        <% } %>
                        
                    </form>
                <% } else { %>
                    <span class="full-text">Full</span>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 Smart Hostel Management System
</div>

</body>
</html>