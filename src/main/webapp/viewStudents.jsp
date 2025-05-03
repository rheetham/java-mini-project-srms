<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Student, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Students</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Records</h1>
        </header>
        
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="addStudent.jsp">Add Student</a></li>
                <li><a href="ViewStudentsServlet">View Students</a></li>
                <li><a href="LogoutServlet">Log Out</a></li>                
            </ul>
        </nav>
        
        <main>
            <%
                String message = (String) session.getAttribute("message");
                String messageType = (String) session.getAttribute("messageType");
                
                if (message != null) {
            %>
                <div class="message <%= messageType %>">
                    <%= message %>
                </div>
            <%
                    session.removeAttribute("message");
                    session.removeAttribute("messageType");
                }
                
                List<Student> students = (List<Student>) request.getAttribute("students");
                if (students != null && !students.isEmpty()) {
            %>
                <section class="student-list">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Roll No.</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Department</th>
                                <th>Semester</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Student student : students) { %>
                            <tr>
                                <td><%= student.getId() %></td>
                                <td><%= student.getRollNumber() %></td>
                                <td><%= student.getFullName() %></td>
                                <td><%= student.getEmail() %></td>
                                <td><%= student.getDepartment() %></td>
                                <td><%= student.getSemester() %></td>
                                <td class="actions">
                                    <a href="EditStudentServlet?id=<%= student.getId() %>" class="btn-delete">Edit</a>
                                    <a href="DeleteStudentServlet?id=<%= student.getId() %>" class="btn-delete" 
                                       onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </section>
            <% } else { %>
                <div class="no-records">
                    <p>No student records found.</p>
                </div>
            <% } %>
        </main>
        
        <footer>
            <p>&copy; 2025 Student Record Management System</p>
        </footer>
    </div>
</body>
</html>