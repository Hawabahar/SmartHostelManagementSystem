<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Smart Hostel Register</title>

    <style>

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body{
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(to right, #003366, #0059b3);
        }

        .container{
            width: 420px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
        }

        .logo{
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 20px;
            border: 4px solid #003366;
        }

        h2{
            margin-bottom: 10px;
            color: #003366;
            font-size: 32px;
        }

        .subtitle{
            color: gray;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .input-box{
            margin-bottom: 20px;
            text-align: left;
        }

        .input-box label{
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .input-box input{
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
        }

        .input-box input:focus{
            border-color: #0059b3;
            outline: none;
            box-shadow: 0 0 5px rgba(0,89,179,0.3);
        }

        button{
            width: 100%;
            padding: 12px;
            background: #003366;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover{
            background: #0059b3;
        }

        .login-link{
            margin-top: 20px;
            font-size: 14px;
        }

        .login-link a{
            color: #003366;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover{
            text-decoration: underline;
        }

        .error-msg {
            color: red;
            background: #ffe5e5;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

    </style>

</head>

<body>

<div class="container">

    <img src="<%= request.getContextPath() %>/image/logo hostel.jpg"
         alt="Hostel Logo"
         class="logo">

    <h2>Create Account</h2>

    <p class="subtitle">
        Register to access Smart Hostel
    </p>

    <%
        String error = request.getParameter("error");
        if (error != null) {
            String msg = "";
            if (error.equals("empty"))         msg = "All Fields Are Required!";
            else if (error.equals("mismatch")) msg = "Confirmation Password Not Match!";
            else if (error.equals("exists"))   msg = "Email Already Registered!";
            else if (error.equals("failed"))   msg = "Registration Failed! Please Try Again.";
            if (!msg.isEmpty()) {
    %>
        <p class="error-msg"><%= msg %></p>
    <%
            }
        }
    %>

    <form action="RegisterServlet" method="post">

        <div class="input-box">
            <label>Full Name</label>
            <input type="text"
                   name="name"
                   placeholder="Enter your full name"
                   value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
        </div>

        <div class="input-box">
            <label>Email</label>
            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
        </div>

        <div class="input-box">
            <label>Password</label>
            <input type="password"
                   name="password"
                   placeholder="Enter your password">
        </div>

        <div class="input-box">
            <label>Confirm Password</label>
            <input type="password"
                   name="confirmPassword"
                   placeholder="Re-enter your password">
        </div>

        <input type="hidden" name="role" value="student">

        <button type="submit">
            Register
        </button>

    </form>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Login Here</a>
    </div>

</div>

</body>
</html>


