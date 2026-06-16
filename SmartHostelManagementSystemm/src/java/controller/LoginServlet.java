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
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

     
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            response.sendRedirect("login.jsp?error=2");
            return;
        }

        UserDAO userDAO = new UserDAO();

        User user = userDAO.loginUser(email.trim(), password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.getRole().equals("admin")) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("studentDashboard.jsp");
            }

        } else {

 
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
