<%-- 
    Document   : Add Employee
    Created on : Oct 20, 2024, 2:24:03 PM
    Author     : Nguyen Hoang Quan - CE181867
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Employee</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/addEmp.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Add New Employee</h2>
            <form action="${pageContext.request.contextPath}/emp_addnew.jsp" method="post">
                <div class="form-group">
                    <label for="empID">ID</label>
                    <input type="text" class="form-control" name="empID" required />
                </div>
                <div class="form-group">
                    <label for="empName">Name</label>
                    <input type="text" class="form-control" name="empName" required />
                </div>
                <div class="form-group">
                    <label for="empEmail">Email</label>
                    <input type="email" class="form-control" name="empEmail" required />
                </div>
                <div class="form-group">
                    <label for="empPhone">Phone</label>
                    <input type="text" class="form-control" name="empPhone" required />
                </div>
                <div class="form-group">
                    <label for="empSalary">Salary</label>
                    <input type="number" class="form-control" name="empSalary" required />
                </div>
                <div class="form-group">
                    <label for="departmentName">Department</label>
                    <select name="departmentName" class="form-control" required>
                        <option value="Executive">Executive</option>
                        <option value="Purchasing">Purchasing</option>
                        <option value="IT">IT</option>
                        <option value="Shipping">Shipping</option>
                        <option value="Sales">Sales</option>
                        <option value="Finance">Finance</option>
                        <option value="Administration">Administration</option>
                        <option value="Marketing">Marketing</option>
                    </select>
                </div>
                <div class="form-group text-center">
                    <input type="submit" class="btn btn-primary" value="Save" />
                    <input type="button" class="btn btn-secondary" value="Back to list" onclick="window.location.href = 'emp_manage.jsp'" />
                </div>
            </form>

            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String empID = request.getParameter("empID");
                    String empName = request.getParameter("empName");
                    String empEmail = request.getParameter("empEmail");
                    String empPhone = request.getParameter("empPhone");
                    String empSalary = request.getParameter("empSalary");
                    String departmentName = request.getParameter("departmentName");

                    String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeDB";
                    String jdbcUsername = "se";
                    String jdbcPassword = "12345";
                    Connection connection = null;
                    PreparedStatement pstmt = null;

                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                
                        String sql = "INSERT INTO Employee (empID, empName, empEmail, empPhone, empSalary, departmentName) VALUES (?, ?, ?, ?, ?, ?)";
                        pstmt = connection.prepareStatement(sql);
                        pstmt.setString(1, empID);
                        pstmt.setString(2, empName);
                        pstmt.setString(3, empEmail);
                        pstmt.setString(4, empPhone);
                        pstmt.setDouble(5, Double.parseDouble(empSalary));
                        pstmt.setString(6, departmentName);
                
                        int rowsInserted = pstmt.executeUpdate();
                        if (rowsInserted > 0) {
                            response.sendRedirect("emp_manage.jsp");
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                        e.printStackTrace();
                    } finally {
                        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                        try { if (connection != null) connection.close(); } catch (Exception e) {}
                    }
                }
            %>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
