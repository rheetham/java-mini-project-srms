<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Teacher, com.student.model.Subject, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Teacher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Teacher Details</h2>
            <a href="TeacherServlet" class="btn btn-secondary">Back to Teachers</a>
        </div>
        
        <%@ include file="messages.jsp" %>
        
        <div class="card mb-4">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h4><%= ((Teacher) request.getAttribute("teacher")).getFullName() %></h4>
                        <p class="mb-1"><strong>Email:</strong> <%= ((Teacher) request.getAttribute("teacher")).getEmail() %></p>
                        <p class="mb-1"><strong>Phone:</strong> <%= ((Teacher) request.getAttribute("teacher")).getPhone() %></p>
                    </div>
                    <div class="col-md-6 text-end">
                        <a href="TeacherServlet?action=edit&teacherId=<%= ((Teacher) request.getAttribute("teacher")).getTeacherId() %>" 
                           class="btn btn-warning">Edit Teacher</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">Assigned Subjects</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h6>Assign New Subject</h6>
                        <form action="TeacherServlet" method="post">
                            <input type="hidden" name="action" value="assignSubject">
                            <input type="hidden" name="teacherId" 
                                   value="<%= ((Teacher) request.getAttribute("teacher")).getTeacherId() %>">
                            
                            <div class="input-group mb-3">
                                <select class="form-select" name="subjectId" required>
                                    <option value="">Select Subject</option>
                                    <% 
                                    List<Subject> allSubjects = (List<Subject>) request.getAttribute("allSubjects");
                                    if (allSubjects != null) {
                                        for (Subject subject : allSubjects) { 
                                            if (!((Teacher) request.getAttribute("teacher")).getAssignedSubjects().contains(subject)) {
                                    %>
                                        <option value="<%= subject.getSubjectId() %>"><%= subject.getSubjectName() %></option>
                                    <% 
                                            }
                                        }
                                    } 
                                    %>
                                </select>
                                <button type="submit" class="btn btn-primary">Assign</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Subject Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    Teacher teacher = (Teacher) request.getAttribute("teacher");
                                    if (teacher.getAssignedSubjects() != null && !teacher.getAssignedSubjects().isEmpty()) {
                                        for (Subject subject : teacher.getAssignedSubjects()) { 
                                    %>
                                        <tr>
                                            <td><%= subject.getSubjectName() %></td>
                                            <td>
                                                <form action="TeacherServlet" method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="removeSubject">
                                                    <input type="hidden" name="teacherId" value="<%= teacher.getTeacherId() %>">
                                                    <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">
                                                    <button type="submit" class="btn btn-sm btn-danger"
                                                            onclick="return confirm('Are you sure you want to remove this subject assignment?')">
                                                        Remove
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% 
                                        }
                                    } else { 
                                    %>
                                        <tr>
                                            <td colspan="2" class="text-center">No subjects assigned</td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>