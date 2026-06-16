/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ComplaintDAO;
import model.Complaint;
import model.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        String description =
                request.getParameter("description");

        Complaint complaint = new Complaint();

        complaint.setUserId(user.getUserId());
        complaint.setDescription(description);
        complaint.setStatus("Pending");

        ComplaintDAO complaintDAO = new ComplaintDAO();

        boolean success =
                complaintDAO.addComplaint(complaint);

        if(success){

            response.getWriter().println(
                    "Complaint Submitted Successfully!");

        } else {

            response.getWriter().println(
                    "Failed to Submit Complaint!");
        }
    }
}