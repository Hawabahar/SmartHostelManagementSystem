package controller;

import dao.ApplicationDAO;
import dao.RoomDAO;
import model.Application;
import model.Room;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateApplicationServlet")
public class UpdateApplicationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        String newStatus = request.getParameter("status");
        
        // Grab the page and filter settings so we can redirect perfectly
        String currentPage = request.getParameter("page");
        String filterStatus = request.getParameter("filterStatus");
        
        String redirectParams = "?page=" + (currentPage != null ? currentPage : "1");
        if (filterStatus != null && !filterStatus.isEmpty()) {
            redirectParams += "&filterStatus=" + filterStatus;
        }

        ApplicationDAO applicationDAO = new ApplicationDAO();
        RoomDAO roomDAO = new RoomDAO();

        Application app = applicationDAO.getApplicationById(applicationId);
        Room room = null;
        
        if (app != null) {
            room = roomDAO.getRoomById(app.getRoomId());
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (app != null && room != null) {
            String oldStatus = app.getStatus();

            // SCENARIO 1: Admin is trying to APPROVE a student
            if (newStatus.equals("Approved") && !oldStatus.equals("Approved")) {
                if (room.getCapacity() <= 0) {
                    out.println("<script>");
                    out.println("alert('Action Blocked: Cannot approve application! Room " + room.getRoomNumber() + " is already full.');");
                    out.println("window.location='viewApplications.jsp" + redirectParams + "';");
                    out.println("</script>");
                    return; 
                } 
                else {
                    room.setCapacity(room.getCapacity() - 1);
                    if (room.getCapacity() == 0) {
                        room.setStatus("Full");
                    }
                    roomDAO.updateRoom(room);
                }
            }
            
            // SCENARIO 2: Admin changes an "Approved" student to "Rejected" or "Pending"
            else if (oldStatus.equals("Approved") && !newStatus.equals("Approved")) {
                room.setCapacity(room.getCapacity() + 1);
                if (room.getCapacity() > 0) {
                    room.setStatus("Available");
                }
                roomDAO.updateRoom(room);
            }

            // Update the application status
            boolean success = applicationDAO.updateApplicationStatus(applicationId, newStatus);

            if (success) {
                response.sendRedirect("viewApplications.jsp" + redirectParams);
            } else {
                out.println("<script>");
                out.println("alert('System Error: Failed to Update Application!');");
                out.println("window.location='viewApplications.jsp" + redirectParams + "';");
                out.println("</script>");
            }
            
        } else {
            response.sendRedirect("viewApplications.jsp");
        }
    }
}