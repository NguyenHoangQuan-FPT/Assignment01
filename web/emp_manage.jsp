<%-- 
    Document   : Manage Employee
    Created on : Oct 20, 2024, 2:24:03 PM
    Author     : Nguyen Hoang Quan - CE181867
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Employee Management Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/manage.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Employee Management Page</h2>
            <div class="text-center mb-3">
                <form action="emp_addnew.jsp">
                    <input style="background-color: aqua" type="submit" class="btn btn-primary" value="Add New Employee"/>
                </form>
            </div>

            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Salary</th>
                        <th>Department</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeDB";
                        String jdbcUsername = "se";
                        String jdbcPassword = "12345";
                        Connection connection = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                            String deleteEmpID = request.getParameter("deleteEmpID");
                            if (deleteEmpID != null) {
                                String deleteSQL = "DELETE FROM Employee WHERE empID=?";
                                pstmt = connection.prepareStatement(deleteSQL);
                                pstmt.setString(1, deleteEmpID);
                                pstmt.executeUpdate();
                                response.sendRedirect("emp_manage.jsp"); 
                                return; 
                            }

                            String sql = "SELECT * FROM Employee";
                            pstmt = connection.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                int empID = rs.getInt("empID");
                                String empName = rs.getString("empName");
                                String empEmail = rs.getString("empEmail");
                                String empPhone = rs.getString("empPhone");
                                double empSalary = rs.getDouble("empSalary");
                                String departmentName = rs.getString("departmentName");
                    %>
                    <tr>
                        <td><%= empID %></td>
                        <td><%= empName %></td>
                        <td><%= empEmail %></td>
                        <td><%= empPhone %></td>
                        <td><%= empSalary %></td>
                        <td><%= departmentName %></td>
                        <td>
                            <form action="emp_update.jsp" method="POST" style="display: inline">
                                <input type="hidden" name="empID" value="<%= empID %>">
                                <input type="hidden" name="empName" value="<%= empName %>">
                                <input type="hidden" name="empEmail" value="<%= empEmail %>">
                                <input type="hidden" name="empPhone" value="<%= empPhone %>">
                                <input type="hidden" name="empSalary" value="<%= empSalary %>">
                                <input type="hidden" name="departmentName" value="<%= departmentName %>">
                                <button type="submit" class="btn btn-warning btn-sm">Update</button>
                            </form>
                            <form action="" method="POST" style="display: inline">
                                <input type="hidden" name="deleteEmpID" value="<%= empID %>">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Do you want to delete?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                            try { if (connection != null) connection.close(); } catch (Exception e) {}
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
