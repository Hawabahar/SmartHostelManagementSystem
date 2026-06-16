<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>

<%
    User currentUser = (User) session.getAttribute("user");

    if (currentUser == null || !currentUser.getRole().equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();

    // DELETE USER
    String deleteId = request.getParameter("deleteId");

    if (deleteId != null) {

        userDAO.deleteUser(Integer.parseInt(deleteId));

%>
<script>
    alert("Student deleted successfully!");
    window.location = 'manageUsers.jsp';
</script>
<%    }

    // UPDATE USER
    String update = request.getParameter("update");

    if (update != null) {

        int userId = Integer.parseInt(request.getParameter("userId"));

        User editUser = userDAO.getUserById(userId);

        editUser.setName(request.getParameter("name"));
        editUser.setEmail(request.getParameter("email"));

        // UPDATE SQL
        java.sql.Connection conn = util.DBConnection.getConnection();

        String sql = "UPDATE users SET name=?, email=? WHERE user_id=?";

        java.sql.PreparedStatement ps
                = conn.prepareStatement(sql);

        ps.setString(1, editUser.getName());
        ps.setString(2, editUser.getEmail());
        ps.setInt(3, userId);

        ps.executeUpdate();
%>

<script>
    alert("Student updated successfully!");
    window.location = 'manageUsers.jsp';
</script>

<%
    }

    List<User> userList = userDAO.getAllUsers();
%>

<!DOCTYPE html>
<html>
    <head>

        <title>Manage Users</title>

        <style>

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:Arial;
            }

            body{
                background:#f4f6f9;
            }

            .navbar{
                background:linear-gradient(to right,#001f4d,#0059b3);
                padding:18px 40px;
                display:flex;
                justify-content:space-between;
                align-items:center;
            }

            .logo-title{
                color:white;
                font-size:26px;
                font-weight:bold;
            }

            .nav-links a{
                color:white;
                text-decoration:none;
                margin-left:25px;
                font-weight:bold;
            }

            /* HERO SECTION */

            .hero{

                width:90%;
                margin:40px auto 20px;
                background:white;
                border-radius:20px;
                overflow:hidden;
                box-shadow:0 10px 25px rgba(0,0,0,0.1);

            }

            .hero img{

                width:100%;
                height:320px;
                object-fit:cover;

            }

            .hero-content{

                padding:35px;
                text-align:center;

            }

            .hero-content h1{

                color:#003366;
                font-size:40px;
                margin-bottom:10px;

            }

            .hero-content p{

                color:#666;
                font-size:17px;

            }

            .table-container{

                width:90%;
                margin:40px auto;
                background:white;
                padding:30px;
                border-radius:20px;
                box-shadow:0 5px 15px rgba(0,0,0,0.1);

            }

            h1{
                color:#003366;
                margin-bottom:25px;
                text-align:center;
            }

            table{
                width:100%;
                border-collapse:collapse;
            }

            th{
                background:#003366;
                color:white;
                padding:15px;
            }

            td{
                padding:15px;
                text-align:center;
                border-bottom:1px solid #ddd;
            }

            input[type=text],
            input[type=email]{

                width:100%;
                padding:8px;
                border:1px solid #ccc;
                border-radius:6px;

            }

            .edit-btn{

                background:#28a745;
                color:white;
                padding:8px 15px;
                border:none;
                border-radius:8px;
                cursor:pointer;
                font-weight:bold;

            }

            .delete-btn{

                background:#dc3545;
                color:white;
                padding:8px 15px;
                border:none;
                border-radius:8px;
                cursor:pointer;
                font-weight:bold;

            }

            .role-admin{
                color:purple;
                font-weight:bold;
            }

            .role-student{
                color:#0059b3;
                font-weight:bold;
            }

        </style>

    </head>

    <body>

        <div class="navbar">

            <div class="logo-title">
                Smart Hostel Admin
            </div>

            <div class="nav-links">

                <a href="adminDashboard.jsp">
                    Dashboard
                </a>

                <a href="manageUsers.jsp">
                    Manage Users
                </a>

                <a href="addRoom.jsp">
                    Add Room
                </a>

                <a href="manageRooms.jsp">
                    Manage Rooms
                </a>

                <a href="viewComplaints.jsp">
                    View Complaints
                </a>

                <a href="viewApplications.jsp">
                    View Applications
                </a>

                <a href="logout.jsp">
                    Logout
                </a>

            </div>

        </div>

        <!-- HERO SECTION -->

        <div class="hero">

            <img src="<%= request.getContextPath()%>/image/hostel.jpg"
                 alt="Hostel Image">

            <div class="hero-content">

                <h1>Manage Users</h1>

                <p>

                    View, edit, and manage registered students and admins efficiently.

                </p>

            </div>

        </div>

        <div class="table-container">

            <h1>Manage Users</h1>

            <table>

                <tr>

                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>

                </tr>

                <% for (User u : userList) {%>

                <tr>

                <form method="post">

                    <td>

                        <%= u.getUserId()%>

                        <input type="hidden"
                               name="userId"
                               value="<%= u.getUserId()%>">

                    </td>

                    <td>

                        <input type="text"
                               name="name"
                               value="<%= u.getName()%>">

                    </td>

                    <td>

                        <input type="email"
                               name="email"
                               value="<%= u.getEmail()%>">

                    </td>

                    <td>

                        <% if (u.getRole().equalsIgnoreCase("admin")) { %>

                        <span class="role-admin">
                            Admin
                        </span>

                        <% } else { %>

                        <span class="role-student">
                            Student
                        </span>

                        <% } %>

                    </td>

                    <td>

                        <button type="submit"
                                name="update"
                                value="true"
                                class="edit-btn">

                            Update

                        </button>

                        <% if (!u.getRole().equalsIgnoreCase("admin")) {%>

                        <button type="button"
                                class="delete-btn"
                                onclick="deleteUser(<%= u.getUserId()%>)">

                            Delete

                        </button>

                        <% } %>

                    </td>

                </form>

                </tr>

                <% }%>

            </table>

        </div>

        <script>

            function deleteUser(id) {

                if (confirm("Are you sure you want to delete this student?")) {

                    window.location =
                            "manageUsers.jsp?deleteId=" + id;
                }
            }

        </script>

    </body>
</html>