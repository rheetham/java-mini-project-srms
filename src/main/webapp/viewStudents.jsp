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
            </ul>
        </nav>
        
        <main>
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
                        <% 
                        List<Student> students = (List<Student>) request.getAttribute("students");
                        if (students != null && !students.isEmpty()) {
                            for (Student student : students) { 
                        %>
                        <tr>
                            <td><%= student.getId() %></td>
                            <td><%= student.getRollNumber() %></td>
                            <td><%= student.getFullName() %></td>
                            <td><%= student.getEmail() %></td>
                            <td><%= student.getDepartment() %></td>
                            <td><%= student.getSemester() %></td>
                            <td class="actions">
                                <a href="editStudent.jsp?id=<%= student.getId() %>" class="btn-edit">Edit</a>
                                <a href="DeleteStudentServlet?id=<%= student.getId() %>" class="btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                            </td>
                        </tr>
                        <% 
                            }
                        } else { 
                        %>
                        <tr>
                            <td colspan="7" class="no-records">No student records found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Student Record Management System</p>
        </footer>
    </div>
</body>
</html>