<%-- 
    Document   : editRoom
    Created on : 21 May 2026, 11:39:09 pm
    Author     : User
--%>

<%@ page import="model.Room" %>
<%@ page import="dao.RoomDAO" %>

<%
    int roomId = Integer.parseInt(request.getParameter("id"));

    RoomDAO roomDAO = new RoomDAO();

    Room room = roomDAO.getRoomById(roomId);
%>

<!DOCTYPE html>
<html>
<head>

    <title>Edit Room</title>

    <style>

        body{
            font-family: Arial;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container{
            width: 450px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }

        h2{
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        label{
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 8px;
        }

        input, select{
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        button{
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover{
            background-color: #0052a3;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>Edit Room</h2>

    <form action="UpdateRoomServlet" method="post">

        <input type="hidden"
               name="roomId"
               value="<%= room.getRoomId() %>">

        <label>Room Number</label>

        <input type="text"
               name="roomNumber"
               value="<%= room.getRoomNumber() %>"
               required>

        <label>Capacity</label>

        <input type="number"
               name="capacity"
               value="<%= room.getCapacity() %>"
               required>

        <label>Status</label>

        <select name="status">

            <option value="Available"
                <%= room.getStatus().equals("Available") ? "selected" : "" %>>
                Available
            </option>

            <option value="Occupied"
                <%= room.getStatus().equals("Occupied") ? "selected" : "" %>>
                Occupied
            </option>

        </select>

        <button type="submit">
            Update Room
        </button>

    </form>

</div>

</body>
</html>
