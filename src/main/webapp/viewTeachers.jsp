<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Teacher, java.util.List" %>
<%@ page import="com.student.model.Subject, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Teachers</title>
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
            <h2>Teacher Management</h2>
            <a href="addTeacher.jsp" class="btn btn-primary">Add New Teacher</a>
        </div>
        
        <%@ include file="messages.jsp" %>
        
        <div class="card">
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Assigned Subjects</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
                        if (teachers != null && !teachers.isEmpty()) {
                            for (Teacher teacher : teachers) { 
                        %>
                            <tr>
                                <td><%= teacher.getTeacherId() %></td>
                                <td><%= teacher.getFullName() %></td>
                                <td><%= teacher.getEmail() %></td>
                                <td><%= teacher.getPhone() %></td>
                                <td>
                                    <% if (teacher.getAssignedSubjects() != null && !teacher.getAssignedSubjects().isEmpty()) { 
                                        for (Subject subject : teacher.getAssignedSubjects()) { %>
                                            <span class="badge bg-primary"><%= subject.getSubjectName() %></span>
                                    <%  }
                                    } else { %>
                                        <span class="text-muted">No subjects assigned</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="TeacherServlet?action=view&teacherId=<%= teacher.getTeacherId() %>" 
                                       class="btn btn-sm btn-info">View</a>
                                    <a href="TeacherServlet?action=edit&teacherId=<%= teacher.getTeacherId() %>" 
                                       class="btn btn-sm btn-warning">Edit</a>
                                    <a href="#" class="btn btn-sm btn-danger" 
                                       data-bs-toggle="modal" 
                                       data-bs-target="#deleteTeacherModal<%= teacher.getTeacherId() %>">Delete</a>
                                </td>
                            </tr>
                            
                            <!-- Delete Teacher Modal -->
                            <div class="modal fade" id="deleteTeacherModal<%= teacher.getTeacherId() %>" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Confirm Delete</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <form action="TeacherServlet" method="post">
                                            <div class="modal-body">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="teacherId" value="<%= teacher.getTeacherId() %>">
                                                <p>Are you sure you want to delete teacher "<%= teacher.getFullName() %>"?</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-danger">Delete</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        <% 
                            }
                        } else { 
                        %>
                            <tr>
                                <td colspan="6" class="text-center">No teachers found</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>