<%-- 
    Document   : Update Employee
    Created on : Oct 20, 2024, 2:24:03 PM
    Author     : Nguyen Hoang Quan - CE181867
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Employee</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/update.css">
    </head>
    <body>

        <div class="container mt-5">
            <h2 class="text-center">Update Employee</h2>

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

                    // Display employee information to update
                    String empID = request.getParameter("empID");

                    String sql = "SELECT * FROM Employee WHERE empID = ?";
                    pstmt = connection.prepareStatement(sql);
                    pstmt.setString(1, empID);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String empName = rs.getString("empName");
                        String empEmail = rs.getString("empEmail");
                        String empPhone = rs.getString("empPhone");
                        double empSalary = rs.getDouble("empSalary");
                        String departmentName = rs.getString("departmentName");
            %>
            <form action="${pageContext.request.contextPath}/emp_update.jsp" method="post">
                <div class="form-group">
                    <label>ID:</label>
                    <input type="text" name="empID" value="<%= empID %>" class="form-control" readonly />
                </div>
                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" name="empName" value="<%= empName %>" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="empEmail" value="<%= empEmail %>" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Phone:</label>
                    <input type="text" name="empPhone" value="<%= empPhone %>" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Salary:</label>
                    <input type="number" name="empSalary" value="<%= empSalary %>" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Department:</label>
                    <select name="departmentName" class="form-control" required>
                        <option value="Executive" <c:if test="${departmentName == 'Executive'}"></c:if>Executive</option>
                        <option value="Purchasing" <c:if test="${departmentName == 'Purchasing'}"></c:if>Purchasing</option>
                        <option value="IT" <c:if test="${departmentName == 'IT'}"></c:if>>IT</option>
                        <option value="Shipping" <c:if test="${departmentName == 'Shipping'}"></c:if>Shipping</option>
                        <option value="Sales" <c:if test="${departmentName == 'Sales'}"></c:if>Sales</option>
                        <option value="Finance" <c:if test="${departmentName == 'Finance'}"></c:if>Finance</option>
                        <option value="Administration" <c:if test="${departmentName == 'Administration'}"></c:if>Administration</option>
                        <option value="Marketing" <c:if test="${departmentName == 'Marketing'}"></c:if>Marketing</option>
                    </select>
                </div>
                <button type="submit" name="action" value="update" class="btn btn-primary">Update</button>
            </form>
            <%
                    } else {
                        out.println("<div class='alert alert-danger'>Employee not found.</div>");
                    }

                    // Handle update if requested
                    String action = request.getParameter("action");
                    if ("update".equals(action)) {
                        empID = request.getParameter("empID");
                        String empName = request.getParameter("empName");
                        String empEmail = request.getParameter("empEmail");
                        String empPhone = request.getParameter("empPhone");
                        String empSalary = request.getParameter("empSalary");
                        String departmentName = request.getParameter("departmentName");

                        String updateSql = "UPDATE Employee SET empName=?, empEmail=?, empPhone=?, empSalary=?, departmentName=? WHERE empID=?";
                        pstmt = connection.prepareStatement(updateSql);
                        pstmt.setString(1, empName);
                        pstmt.setString(2, empEmail);
                        pstmt.setString(3, empPhone);
                        pstmt.setDouble(4, Double.parseDouble(empSalary));
                        pstmt.setString(5, departmentName);
                        pstmt.setString(6, empID);

                        int rowsUpdated = pstmt.executeUpdate();
                        if (rowsUpdated > 0) {
                            response.sendRedirect("emp_manage.jsp");
                            return; 
                        } else {
                            out.println("<div class='alert alert-danger'>Error updating employee. Please try again.</div>");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                    try { if (connection != null) connection.close(); } catch (Exception e) {}
                }
            %>

            <button class="btn btn-secondary" onclick="location.href = 'emp_manage.jsp';">Back</button>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
