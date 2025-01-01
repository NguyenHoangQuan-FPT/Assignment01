
<%-- 
    Document   : RegisterAccount
    Created on : Oct 20, 2024, 2:24:03 PM
    Author     : Nguyen Hoang Quan - CE181867
--%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Account</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/regesterAcc.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Create a New Account</h2>
            <form action="" method="POST">
                <div class="form-group">
                    <label for="accId">Username</label>
                    <input type="text" class="form-control" id="accId" name="accId" required />
                </div>
                <div class="form-group">
                    <label for="accPass">Password</label>
                    <input type="password" class="form-control" id="accPass" name="accPass" required />
                </div>
                <div class="form-group">
                    <label for="confirm_password">Confirm Password</label>
                    <input type="password" class="form-control" id="confirm_password" name="confirm_password" required />
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Register</button>
                    <input type="button" class="btn btn-secondary" value="Back to Login" onclick="window.location.href = 'login.jsp'" />
                </div>
                <%
                    String message = "";
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String accId = request.getParameter("accId");
                        String accPass = request.getParameter("accPass");
                        String confirmPassword = request.getParameter("confirm_password");

                        if (!accPass.equals(confirmPassword)) {
                            message = "Passwords do not match!";
                        } else {
                            String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeDB";
                            String jdbcUsername = "se";
                            String jdbcPassword = "12345";
                            Connection connection = null;
                            PreparedStatement pstmt = null;

                            try {
                                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                                String sql = "INSERT INTO Account (accId, accPass) VALUES (?, ?)";
                                pstmt = connection.prepareStatement(sql);
                                pstmt.setString(1, accId);
                                pstmt.setString(2, accPass); 

                                int rowsInserted = pstmt.executeUpdate();
                                if (rowsInserted > 0) {
                                    message = "Registration successful!";
                                    response.sendRedirect("login.jsp");
                                    return; 
                                } else {
                                    message = "Error registering account.";
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                message = "Database error: " + e.getMessage();
                            } finally {
                                try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                                try { if (connection != null) connection.close(); } catch (Exception e) {}
                            }
                        }
                    }
                %>
                <% if (!message.isEmpty()) { %>
                <div class="alert alert-danger mt-3">
                    <%= message %>
                </div>
                <% } %>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
