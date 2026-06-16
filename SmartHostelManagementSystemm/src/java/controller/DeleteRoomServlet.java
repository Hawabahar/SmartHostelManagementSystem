/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.RoomDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteRoomServlet")
public class DeleteRoomServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int roomId = Integer.parseInt(
                request.getParameter("id"));

        RoomDAO roomDAO = new RoomDAO();

        boolean success = roomDAO.deleteRoom(roomId);

        if(success){

            response.sendRedirect("manageRooms.jsp");

        } else {

            response.getWriter().println("Delete Failed!");
        }
    }
}
