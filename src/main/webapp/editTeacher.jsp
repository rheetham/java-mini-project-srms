<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Teacher" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Teacher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Edit Teacher</h2>
            <a href="TeacherServlet" class="btn btn-secondary">Back to Teachers</a>
        </div>
        
        <%@ include file="messages.jsp" %>
        
        <div class="card">
            <div class="card-body">
                <form action="TeacherServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="teacherId" 
                           value="<%= ((Teacher) request.getAttribute("teacher")).getTeacherId() %>">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" name="firstName" 
                                   value="<%= ((Teacher) request.getAttribute("teacher")).getFirstName() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" name="lastName" 
                                   value="<%= ((Teacher) request.getAttribute("teacher")).getLastName() %>" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" 
                                   value="<%= ((Teacher) request.getAttribute("teacher")).getEmail() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phone" 
                                   value="<%= ((Teacher) request.getAttribute("teacher")).getPhone() %>">
                        </div>
                    </div>
                    
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Update Teacher</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>