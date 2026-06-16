<%@ page import="java.util.List" %>
<%@ page import="model.Complaint" %>
<%@ page import="dao.ComplaintDAO" %>

<%
    ComplaintDAO complaintDAO = new ComplaintDAO();

    List<Complaint> complaintList
            = complaintDAO.getAllComplaints();
%>

<!DOCTYPE html>
<html>
    <head>

        <title>View Complaints</title>

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
                width: 92%;
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
                background: #8b0000;
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
                background-color: #f9f9f9;
            }

            textarea{
                width: 100%;
                border: none;
                resize: none;
                background: transparent;
                font-size: 14px;
            }

            select{
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #ccc;
                margin-bottom: 10px;
                width: 100%;
            }

            button{
                padding: 10px 18px;
                background: #0059b3;
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
            }

            button:hover{
                background: #003366;
            }

            .pending{
                color: orange;
                font-weight: bold;
            }

            .progress{
                color: blue;
                font-weight: bold;
            }

            .resolved{
                color: green;
                font-weight: bold;
            }

            /* FOOTER */

            .footer{
                background: #001f4d;
                color: white;
                text-align: center;
                padding: 18px;
                margin-top: 30px;
            }

            .update-form{
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .update-form select{
                margin-bottom: 0;
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

                <a href="manageUsers.jsp">Manage Users</a>

                <a href="addRoom.jsp">Add Room</a>

                <a href="manageRooms.jsp">Manage Rooms</a>

                <a href="viewComplaints.jsp">View Complaints</a>

                <a href="viewApplications.jsp">View Applications</a>

                <a href="logout.jsp">Logout</a>

            </div>

        </div>

        <!-- HERO SECTION -->

        <div class="hero">

            <img src="<%= request.getContextPath()%>/image/hostel.jpg"
                 alt="Hostel Image">

            <div class="hero-content">

                <h1>Student Complaints</h1>

                <p>
                    Review and manage complaints submitted by hostel students.
                </p>

            </div>

        </div>

        <!-- TABLE SECTION -->

        <div class="table-container">

            <table>

                <tr>

                    <th>Complaint ID</th>
                    <th>Student Name</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Update</th>

                </tr>

                <%
                    for (Complaint complaint : complaintList) {
                %>

                <tr>

                    <td><%= complaint.getComplaintId()%></td>

                    <td><%= complaint.getStudentName()%></td>

                    <td style="max-width:300px;">
                        <%= complaint.getDescription()%>
                    </td>

                    <td>

                        <%
                            String status = complaint.getStatus();

                            if (status.equalsIgnoreCase("Pending")) {
                        %>

                        <span class="pending">
                            Pending
                        </span>

                        <%
                        } else if (status.equalsIgnoreCase("In Progress")) {
                        %>

                        <span class="progress">
                            In Progress
                        </span>

                        <%
                        } else {
                        %>

                        <span class="resolved">
                            Resolved
                        </span>

                        <%
                            }
                        %>

                    </td>

                    <td>

                        <form action="UpdateComplaintServlet"
                              method="post"
                              class="update-form">

                            <input type="hidden"
                                   name="complaintId"
                                   value="<%= complaint.getComplaintId()%>">

                            <select name="status">

                                <option value="Pending">
                                    Pending
                                </option>

                                <option value="In Progress">
                                    In Progress
                                </option>

                                <option value="Resolved">
                                    Resolved
                                </option>

                            </select>

                            <button type="submit">
                                Update
                            </button>

                        </form>

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