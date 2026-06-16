/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.RoomDAO;
import model.Room;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateRoomServlet")
public class UpdateRoomServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int roomId = Integer.parseInt(
                request.getParameter("roomId"));

        String roomNumber =
                request.getParameter("roomNumber");

        int capacity = Integer.parseInt(
                request.getParameter("capacity"));

        String status =
                request.getParameter("status");

        Room room = new Room();

        room.setRoomId(roomId);
        room.setRoomNumber(roomNumber);
        room.setCapacity(capacity);
        room.setStatus(status);

        RoomDAO roomDAO = new RoomDAO();

        boolean success = roomDAO.updateRoom(room);

        if(success){

            response.sendRedirect("manageRooms.jsp");

        } else {

            response.getWriter().println("Update Failed!");
        }
    }
}