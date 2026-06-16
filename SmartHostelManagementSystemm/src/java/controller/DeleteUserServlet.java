package controller;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteUserServlet", urlPatterns = {"/DeleteUserServlet"})
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        int userId = Integer.parseInt(request.getParameter("id"));
        
        UserDAO userDAO = new UserDAO();
        userDAO.deleteUser(userId);
        
        // Return straight to the table after deleting
        response.sendRedirect("manageUsers.jsp");
    }
}