<%
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html>

    <head>

        <title>Add Room</title>

        <style>

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:Arial,sans-serif;
            }

            body{
                background-color:#f4f6f9;
            }

            /* NAVBAR */

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
                transition:0.3s;

            }

            .nav-links a:hover{
                color:#d9e6ff;
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

            /* FORM SECTION */

            .container{

                width:450px;
                margin:30px auto 50px;
                background:white;
                padding:35px;
                border-radius:20px;
                box-shadow:0 5px 15px rgba(0,0,0,0.1);

            }

            .container h2{

                text-align:center;
                color:#003366;
                margin-bottom:25px;
                font-size:30px;

            }

            .input-box{
                margin-bottom:20px;
            }

            .input-box label{

                display:block;
                margin-bottom:8px;
                font-weight:bold;
                color:#333;

            }

            input,
            select{

                width:100%;
                padding:13px;
                border:1px solid #ccc;
                border-radius:10px;
                font-size:15px;

            }

            input:focus,
            select:focus{

                border-color:#0059b3;
                outline:none;
                box-shadow:0 0 5px rgba(0,89,179,0.3);

            }

            button{

                width:100%;
                padding:14px;
                margin-top:10px;
                background:#0059b3;
                color:white;
                border:none;
                border-radius:10px;
                font-size:16px;
                font-weight:bold;
                cursor:pointer;
                transition:0.3s;

            }

            button:hover{
                background:#003366;
            }

            /* FOOTER */

            .footer{

                background:#001f4d;
                color:white;
                text-align:center;
                padding:18px;
                margin-top:30px;

            }

        </style>

    </head>

    <body>

        <% if (success != null) { %>

        <script>

            alert("Room added successfully!");

        </script>

        <% }%>

        <!-- NAVBAR -->

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

                <h1>Add Hostel Room</h1>

                <p>

                    Add and manage hostel room information efficiently.

                </p>

            </div>

        </div>

        <!-- FORM SECTION -->

        <div class="container">

            <h2>Add Room</h2>

            <form action="AddRoomServlet" method="post">

                <div class="input-box">

                    <label>Room Number</label>

                    <input type="text"
                           name="roomNumber"
                           placeholder="Enter room number"
                           required>

                </div>

                <div class="input-box">

                    <label>Capacity</label>

                    <input type="number"
                           name="capacity"
                           placeholder="Enter room capacity"
                           required>

                </div>

                <div class="input-box">

                    <label>Room Status</label>

                    <select name="status">

                        <option value="Available">

                            Available

                        </option>

                        <option value="Occupied">

                            Occupied

                        </option>

                    </select>

                </div>

                <button type="submit">

                    Add Room

                </button>

            </form>

        </div>

        <!-- FOOTER -->

        <div class="footer">

            © 2026 Smart Hostel Management System | Admin Panel

        </div>

    </body>
</html>