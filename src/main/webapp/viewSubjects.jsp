<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Subject, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Subjects</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        header {
    		width: 85vw;
        	margin-top: 15px;
        	border-radius: 10px;
        }
        
        .head {
        	width: 100vw;
        	display: flex;
        	flex-direction: column;
        	align-items: center;
        }
        
        nav {
        	width: 85vw;
        	border-radius: 10px;
        }
        
        li {
        	margin-top: 10px;
        }
		
		ul {
			margin-bottom: 5px;
		}
        .action-btns { white-space: nowrap; }
    </style>
</head>
<body>
	<div class="head">
		<header>
            <h1>Student Record Management System</h1>
        </header>
        
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="ViewStudentsServlet">Students</a></li>
                <li><a href="TeacherServlet">Teachers</a></li>                
                <li><a href="SubjectServlet">Subjects</a></li>
                <li><a href="LogoutServlet">Log Out</a></li>

            </ul>
        </nav>
    </div>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Subject Management</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addSubjectModal">
                Add New Subject
            </button>
        </div>
        
        <%@ include file="messages.jsp" %>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Subject Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
                            if (subjects != null && !subjects.isEmpty()) {
                                for (Subject subject : subjects) { 
                            %>
                                <tr>
                                    <td><%= subject.getSubjectId() %></td>
                                    <td><%= subject.getSubjectName() %></td>
                                    <td class="action-btns">
                                        <a href="#" class="btn btn-sm btn-info" 
                                           data-bs-toggle="modal" 
                                           data-bs-target="#enrollModal<%= subject.getSubjectId() %>">
                                            Enroll Students
                                        </a>
                                        <a href="#" class="btn btn-sm btn-warning" 
                                           data-bs-toggle="modal" 
                                           data-bs-target="#editSubjectModal<%= subject.getSubjectId() %>">
                                            Edit
                                        </a>
                                        <a href="#" class="btn btn-sm btn-danger" 
                                           data-bs-toggle="modal" 
                                           data-bs-target="#deleteSubjectModal<%= subject.getSubjectId() %>">
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            <% 
                                }
                            } else { 
                            %>
                                <tr>
                                    <td colspan="3" class="text-center">No subjects found</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Subject Modal -->
    <div class="modal fade" id="addSubjectModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Subject</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="SubjectServlet" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label">Subject Name</label>
                            <input type="text" class="form-control" name="subjectName" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Subject</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Modals for each subject -->
    <% if (subjects != null) {
        for (Subject subject : subjects) { 
    %>
        <!-- Edit Subject Modal -->
        <div class="modal fade" id="editSubjectModal<%= subject.getSubjectId() %>" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Subject</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="SubjectServlet" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">
                            <div class="mb-3">
                                <label class="form-label">Subject Name</label>
                                <input type="text" class="form-control" name="subjectName" 
                                       value="<%= subject.getSubjectName() %>" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Delete Subject Modal -->
        <div class="modal fade" id="deleteSubjectModal<%= subject.getSubjectId() %>" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="SubjectServlet" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">
                            <p>Are you sure you want to delete "<%= subject.getSubjectName() %>"?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Enroll Students Modal -->
        <div class="modal fade" id="enrollModal<%= subject.getSubjectId() %>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Enroll Students - <%= subject.getSubjectName() %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Enroll New Student</h6>
                                <form action="EnrollmentServlet" method="post">
                                    <input type="hidden" name="action" value="enroll">
                                    <input type="hidden" name="subjectId" value="<%= subject.getSubjectId() %>">
                                    <div class="mb-3">
                                        <label class="form-label">Student ID</label>
                                        <input type="number" class="form-control" name="studentId" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Enroll</button>
                                </form>
                            </div>
                            <div class="col-md-6">
                                <h6>Enrolled Students</h6>
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <tbody>
                                            <tr>
                                                <td colspan="4" class="text-center">
                                                    <a href="SubjectServlet?action=viewEnrollments&subjectId=<%= subject.getSubjectId() %>" 
                                                       class="btn btn-sm btn-info">
                                                        View Enrollments
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <% }
       } %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>