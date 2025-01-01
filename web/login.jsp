<%-- 
    Document   : Login
    Created on : Oct 20, 2024, 2:24:03 PM
    Author     : Nguyen Hoang Quan - CE181867
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
<div class="container d-flex flex-column align-items-center justify-content-center vh-100">
    <img src="${pageContext.request.contextPath}/image/login3.jpg" alt="Login Image" class="form__img mb-4" style="max-width: 100%; height: auto;">
    <form action="login.jsp" method="POST" class="border p-4 rounded shadow">
        <h2 class="text-center">Login</h2>
        <div class="form-group">
            <label for="accId">Username</label>
            <input type="text" class="form-control" name="accId" id="accId" required />
        </div>
        <div class="form-group">
            <label for="accPass">Password</label>
            <input type="password" class="form-control" name="accPass" id="accPass" required />
        </div>
        <div class="form-group text-center">
            <button type="submit" class="btn btn-primary">Login</button>
            <button type="reset" class="btn btn-secondary">Cancel</button>
        </div>
        <div class="text-center">
            <a href="RegisterAccount.jsp">Register</a>
        </div>
    </form>

    <%
    String accId = request.getParameter("accId");
    String accPass = request.getParameter("accPass");

    if (accId != null && accPass != null) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeDB";
            String user = "se";
            String password = "12345";
            connection = DriverManager.getConnection(url, user, password);
        
            String sql = "SELECT * FROM Account WHERE accId = ? AND accPass = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, accId);
            pstmt.setString(2, accPass);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("emp_manage.jsp");
                return; 
            } else {
                out.println("<div class='alert alert-danger text-center mt-3'>Invalid username or password.</div>");
            }
        } catch (SQLException | ClassNotFoundException e) {
            out.println("<div class='alert alert-danger text-center mt-3'>Error: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
