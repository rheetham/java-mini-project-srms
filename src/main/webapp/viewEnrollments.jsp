<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Enrollment, com.student.model.Subject, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enrolled Students</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Enrolled Students - <%= ((Subject) request.getAttribute("subject")).getSubjectName() %></h2>
            <a href="SubjectServlet" class="btn btn-secondary">Back to Subjects</a>
        </div>
        
        <%-- Display messages --%>
        <%@ include file="messages.jsp" %>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Enrollment ID</th>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Roll No.</th>
                                <th>Enrolled At</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            List<Enrollment> enrollments = (List<Enrollment>) request.getAttribute("enrollments");
                            Subject subject = (Subject) request.getAttribute("subject");
                            
                            if (enrollments != null && !enrollments.isEmpty()) {
                                for (Enrollment enrollment : enrollments) { 
                            %>
                                <tr>
                                    <td><%= enrollment.getEnrollmentId() %></td>
                                    <td><%= enrollment.getStudentId() %></td>
                                    <td><%= enrollment.getStudent().getFullName() %></td>
                                    <td><%= enrollment.getStudent().getRollNumber() %></td>
                                    <td><%= enrollment.getEnrolledAt() %></td>
                                    <td>
                                        <form action="EnrollmentServlet" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="enrollmentId" value="<%= enrollment.getEnrollmentId() %>">
                                            <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">
                                            <button type="submit" class="btn btn-sm btn-danger" 
                                                    onclick="return confirm('Are you sure you want to remove this enrollment?')">
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
                                    <td colspan="6" class="text-center">No students enrolled in this subject</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <div class="mt-4">
                    <h5>Enroll New Student</h5>
                    <form action="EnrollmentServlet" method="post" class="row g-3">
                        <input type="hidden" name="action" value="enroll">
                        <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">
                        
                        <div class="col-md-6">
                            <label class="form-label">Student ID</label>
                            <input type="number" class="form-control" name="studentId" required>
                        </div>
                        <div class="col-md-6 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary">Enroll Student</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>