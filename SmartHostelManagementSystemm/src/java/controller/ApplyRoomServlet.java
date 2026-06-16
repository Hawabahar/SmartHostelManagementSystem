package controller;

import dao.ApplicationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Application;
import model.User;

@WebServlet(name = "ApplyRoomServlet", urlPatterns = {"/ApplyRoomServlet"})
public class ApplyRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Security Check
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equalsIgnoreCase("student")) {
            response.sendRedirect("login.jsp");
            return;
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        ApplicationDAO applicationDAO = new ApplicationDAO();

        // 2. CHECK RULE: Can the student apply?
        List<Application> existingApps = applicationDAO.getApplicationsByUserId(user.getUserId());
        boolean canApply = true;
        
        for (Application app : existingApps) {
            // If they already have a Pending or Approved room, block the new application
            if (app.getStatus().equalsIgnoreCase("Pending") || app.getStatus().equalsIgnoreCase("Approved")) {
                canApply = false;
                break;
            }
        }

        // 3. Block application if rule is violated
        if (!canApply) {
            out.println("<script>");
            out.println("alert('You already have an active room application! You can only apply again if your current application is rejected.');");
            out.println("window.location='myApplications.jsp';"); 
            out.println("</script>");
            return; // Stop execution here
        }

        // 4. Proceed with application if they are cleared
        int roomId = Integer.parseInt(request.getParameter("roomId"));

        Application application = new Application();
        application.setUserId(user.getUserId());
        application.setRoomId(roomId);
        application.setStatus("Pending");

        boolean success = applicationDAO.applyRoom(application);

        if (success) {
            out.println("<script>");
            out.println("alert('Application Submitted! Awaiting Admin Approval.');");
            out.println("window.location='myApplications.jsp';"); 
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('Failed to Apply Room!');");
            out.println("window.location='viewRooms.jsp';");
            out.println("</script>");
        }
    }
}