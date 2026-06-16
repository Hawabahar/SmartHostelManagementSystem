<%-- 
    Document   : logout
    Created on : 21 May 2026, 11:52:12 pm
    Author     : User
--%>

<%
    session.invalidate();

    response.sendRedirect("login.jsp");
%>
