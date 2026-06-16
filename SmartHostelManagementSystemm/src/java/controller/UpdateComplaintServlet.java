/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ComplaintDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateComplaintServlet")
public class UpdateComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int complaintId = Integer.parseInt(
                request.getParameter("complaintId"));

        String status =
                request.getParameter("status");

        ComplaintDAO complaintDAO =
                new ComplaintDAO();

        boolean success =
            complaintDAO.updateComplaintStatus(
                    complaintId,
                    status
            );

        if(success){

            response.sendRedirect("viewComplaints.jsp");

        } else {

            response.getWriter().println(
                    "Failed to Update Complaint!");
        }
    }
}