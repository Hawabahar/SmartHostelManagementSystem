/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name            = request.getParameter("name");
        String email           = request.getParameter("email");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role            = request.getParameter("role");

   
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {

            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            response.sendRedirect("register.jsp?error=empty&name=" +
                    java.net.URLEncoder.encode(name, "UTF-8") +
                    "&email=" + java.net.URLEncoder.encode(email, "UTF-8"));
            return;
        }

 
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=mismatch&name=" +
                    java.net.URLEncoder.encode(name, "UTF-8") +
                    "&email=" + java.net.URLEncoder.encode(email, "UTF-8"));
            return;
        }

        UserDAO userDAO = new UserDAO();


        if (userDAO.isEmailExists(email)) {
            response.sendRedirect("register.jsp?error=exists&name=" +
                    java.net.URLEncoder.encode(name, "UTF-8"));
            return;
        }

        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setRole(role);

        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?success=1");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}
