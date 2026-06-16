<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ page import="dao.RoomDAO" %>

<%
    RoomDAO roomDAO = new RoomDAO();

    List<Room> roomList = roomDAO.getAllRooms();
%>

<!DOCTYPE html>
<html>
<head>

    <title>Manage Rooms</title>

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
            background: linear-gradient(to right, #001f4d, #0059b3);
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-title{
            color: white;
            font-size: 26px;
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
            height: 320px;
            object-fit: cover;
        }

        .hero-content{
            padding: 35px;
            text-align: center;
        }

        .hero-content h1{
            color: #003366;
            font-size: 40px;
            margin-bottom: 10px;
        }

        .hero-content p{
            color: #666;
            font-size: 17px;
        }

        /* TABLE SECTION */

        .table-container{
            width: 90%;
            margin: 30px auto 50px;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow-x: auto;
        }

        table{
            width: 100%;
            border-collapse: collapse;
        }

        th{
            background: #003366;
            color: white;
            padding: 15px;
            font-size: 16px;
        }

        td{
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        tr:hover{
            background-color: #f5f9ff;
        }

        .status-available{
            color: green;
            font-weight: bold;
        }

        .status-occupied{
            color: red;
            font-weight: bold;
        }

        .edit-btn{
            text-decoration: none;
            padding: 10px 18px;
            background: #28a745;
            color: white;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .edit-btn:hover{
            background: #218838;
        }

        .delete-btn{
            text-decoration: none;
            padding: 10px 18px;
            background: #dc3545;
            color: white;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .delete-btn:hover{
            background: #b02a37;
        }

        /* FOOTER */

        .footer{
            background: #001f4d;
            color: white;
            text-align: center;
            padding: 18px;
            margin-top: 30px;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

    <div class="logo-title">
        Smart Hostel Admin
    </div>

    <div class="nav-links">

        <a href="adminDashboard.jsp">Dashboard</a>
        
        <a href="manageUsers.jsp"> Manage Users</a>

        <a href="addRoom.jsp">Add Room</a>

        <a href="manageRooms.jsp">Manage Rooms</a>

        <a href="viewComplaints.jsp">View Complaints</a>

        <a href="viewApplications.jsp">View Applications</a>

        <a href="logout.jsp">Logout</a>

    </div>

</div>

<!-- HERO SECTION -->

<div class="hero">

    <img src="<%= request.getContextPath() %>/image/hostel.jpg"
         alt="Hostel Image">

    <div class="hero-content">

        <h1>Manage Hostel Rooms</h1>

        <p>
            View, edit, and manage hostel room information efficiently.
        </p>

    </div>

</div>

<!-- TABLE SECTION -->

<div class="table-container">

<table>

    <tr>

        <th>Room ID</th>
        <th>Room Number</th>
        <th>Capacity</th>
        <th>Status</th>
        <th>Action</th>

    </tr>

<%
    for(Room room : roomList){
%>

<tr>

    <td><%= room.getRoomId() %></td>

    <td><%= room.getRoomNumber() %></td>

    <td><%= room.getCapacity() %></td>

    <td>

        <% if(room.getStatus().equalsIgnoreCase("Available")) { %>

            <span class="status-available">
                Available
            </span>

        <% } else { %>

            <span class="status-occupied">
                Occupied
            </span>

        <% } %>

    </td>

    <td>

        <a href="editRoom.jsp?id=<%= room.getRoomId() %>"
           class="edit-btn">

            Edit

        </a>

        &nbsp;

        <a href="DeleteRoomServlet?id=<%= room.getRoomId() %>"
           class="delete-btn"
           onclick="return confirm('Are you sure to delete this room?');">

            Delete

        </a>

    </td>

</tr>

<%
    }
%>

</table>

</div>

<!-- FOOTER -->

<div class="footer">

    © 2026 Smart Hostel Management System | Admin Panel

</div>

</body>
</html>