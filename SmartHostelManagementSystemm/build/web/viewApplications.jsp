<%@ page import="java.util.List" %>
<%@ page import="model.Application" %>
<%@ page import="dao.ApplicationDAO" %>

<%
    ApplicationDAO applicationDAO = new ApplicationDAO();

    // --- FILTER LOGIC ---
    String filterStatus = request.getParameter("filterStatus");
    // If admin just opened the page, automatically show "Pending" to save them time!
    if (filterStatus == null || filterStatus.isEmpty()) {
        filterStatus = "Pending";
    }

    List<Application> fullList;
    if (filterStatus.equals("All")) {
        fullList = applicationDAO.getAllApplications();
    } else {
        fullList = applicationDAO.getFilteredApplications(filterStatus);
    }

    // --- PAGINATION LOGIC ---
    int pageSize = 5;
    int totalRecords = fullList.size();
    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

    int currentPage = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    if (currentPage < 1) {
        currentPage = 1;
    }
    if (totalPages > 0 && currentPage > totalPages) {
        currentPage = totalPages;
    }

    int startIndex = (currentPage - 1) * pageSize;
    int endIndex = Math.min(startIndex + pageSize, totalRecords);

    List<Application> applicationList = fullList.isEmpty() ? fullList : fullList.subList(startIndex, endIndex);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>View Applications</title>
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

            /* FILTER BAR */
            .filter-bar {
                width: 92%;
                margin: 20px auto;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 15px;
            }
            .filter-bar label {
                font-weight: bold;
                color: #003366;
                font-size: 16px;
            }
            .filter-bar select {
                width: 200px;
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 15px;
                margin-bottom: 0;
            }
            .filter-bar button {
                padding: 10px 20px;
                background: #0059b3;
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
            }
            .filter-bar button:hover {
                background: #003366;
            }

            /* TABLE SECTION */
            .table-container{
                width: 92%;
                margin: 0 auto 20px;
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
                background: darkgreen;
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

            .update-form{
                display: flex;
                align-items: center;
                gap: 10px;
                justify-content: center;
            }
            .update-form select{
                margin-bottom: 0;
                width: auto;
                padding: 8px;
            }
            .update-form button{
                padding: 8px 15px;
                background: #0059b3;
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
            }
            .update-form button:hover{
                background: #003366;
            }

            .pending{
                color: orange;
                font-weight: bold;
            }
            .approved{
                color: green;
                font-weight: bold;
            }
            .rejected{
                color: red;
                font-weight: bold;
            }

            /* PAGINATION SECTION */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                margin-bottom: 50px;
            }
            .pagination a {
                text-decoration: none;
                padding: 10px 20px;
                background: #003366;
                color: white;
                border-radius: 8px;
                font-weight: bold;
                transition: 0.3s;
            }
            .pagination a:hover {
                background: #0059b3;
            }
            .pagination .disabled {
                background: #cccccc;
                color: #666666;
                pointer-events: none;
            }
            .page-info {
                font-weight: bold;
                color: #333;
                font-size: 16px;
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
            <img src="<%= request.getContextPath()%>/image/hostel.jpg" alt="Hostel Image">
            <div class="hero-content">
                <h1>Room Applications</h1>
                <p>Review and manage student hostel room applications efficiently.</p>
            </div>
        </div>

        <div class="filter-bar">
            <form action="viewApplications.jsp" method="get" style="display: flex; gap: 10px; align-items: center;">
                <label>Filter Status: </label>
                <select name="filterStatus">
                    <option value="All" <%= filterStatus.equals("All") ? "selected" : ""%>>All Applications</option>
                    <option value="Pending" <%= filterStatus.equals("Pending") ? "selected" : ""%>>Pending Only</option>
                    <option value="Approved" <%= filterStatus.equals("Approved") ? "selected" : ""%>>Approved Only</option>
                    <option value="Rejected" <%= filterStatus.equals("Rejected") ? "selected" : ""%>>Rejected Only</option>
                </select>
                <button type="submit">Filter</button>
            </form>
        </div>

        <div class="table-container">
            <table>
                <tr>
                    <th>App ID</th>
                    <th>Student Name</th>
                    <th>Room Number</th>
                    <th>Status</th>
                    <th>Update</th>
                </tr>
                <% if (applicationList.isEmpty()) { %>
                <tr>
                    <td colspan="5" style="color: gray; font-style: italic;">No applications found for this status.</td>
                </tr>
                <% } else {
                    for (Application app : applicationList) {%>
                <tr>
                    <td><%= app.getApplicationId()%></td>
                    <td><%= app.getStudentName()%></td>
                    <td><%= app.getRoomNumber()%></td>
                    <td>
                        <% if (app.getStatus().equalsIgnoreCase("Pending")) { %>
                        <span class="pending">Pending</span>
                        <% } else if (app.getStatus().equalsIgnoreCase("Approved")) { %>
                        <span class="approved">Approved</span>
                        <% } else { %>
                        <span class="rejected">Rejected</span>
                        <% }%>
                    </td>
                    <td>
                        <form action="UpdateApplicationServlet" method="post" class="update-form">
                            <input type="hidden" name="applicationId" value="<%= app.getApplicationId()%>">

                            <input type="hidden" name="page" value="<%= currentPage%>">
                            <input type="hidden" name="filterStatus" value="<%= filterStatus%>">

                            <select name="status">
                                <option value="Pending" <%= app.getStatus().equalsIgnoreCase("Pending") ? "selected" : ""%>>Pending</option>
                                <option value="Approved" <%= app.getStatus().equalsIgnoreCase("Approved") ? "selected" : ""%>>Approved</option>
                                <option value="Rejected" <%= app.getStatus().equalsIgnoreCase("Rejected") ? "selected" : ""%>>Rejected</option>
                            </select>
                            <button type="submit">Update</button>
                        </form>
                    </td>
                </tr>
                <%  }
                    } %>
            </table>
        </div>

        <div class="pagination">
            <% if (currentPage > 1) {%>
            <a href="viewApplications.jsp?page=<%= currentPage - 1%>&filterStatus=<%= filterStatus%>">&laquo; Previous</a>
            <% } else { %>
            <a href="#" class="disabled">&laquo; Previous</a>
            <% }%>

            <span class="page-info">Page <%= currentPage%> of <%= totalPages == 0 ? 1 : totalPages%></span>

            <% if (currentPage < totalPages) {%>
            <a href="viewApplications.jsp?page=<%= currentPage + 1%>&filterStatus=<%= filterStatus%>">Next &raquo;</a>
            <% } else { %>
            <a href="#" class="disabled">Next &raquo;</a>
            <% }%>
        </div>

        <div class="footer">
            © 2026 Smart Hostel Management System | Admin Panel
        </div>
    </body>
</html>