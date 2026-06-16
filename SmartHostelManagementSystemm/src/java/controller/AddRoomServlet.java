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

@WebServlet("/AddRoomServlet")
public class AddRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String roomNumber = request.getParameter("roomNumber");

        int capacity = Integer.parseInt(
                request.getParameter("capacity"));

        String status = request.getParameter("status");

        Room room = new Room();

        room.setRoomNumber(roomNumber);
        room.setCapacity(capacity);
        room.setStatus(status);

        RoomDAO roomDAO = new RoomDAO();

        boolean success = roomDAO.addRoom(room);

        if(success){

            response.sendRedirect("addRoom.jsp?success=true");

        } else {

            response.getWriter().println("Failed to Add Room!");

        }
    }
}