<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Student, com.student.dao.StudentDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js"></script>
</head>
<body>
    <div class="container">
        <header>
            <h1>Delete Student Record</h1>
        </header>
        
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="addStudent.jsp">Add Student</a></li>
                <li><a href="ViewStudentsServlet">View Students</a></li>
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
                
                int studentId = Integer.parseInt(request.getParameter("id"));
                StudentDAO studentDAO = new StudentDAO();
                Student student = studentDAO.getStudentById(studentId);
                
                if (student != null) {
            %>
            <section class="confirmation-section">
                <h2>Confirm Deletion</h2>
                <div class="student-details">
                    <p><strong>ID:</strong> <%= student.getId() %></p>
                    <p><strong>Roll Number:</strong> <%= student.getRollNumber() %></p>
                    <p><strong>Name:</strong> <%= student.getFullName() %></p>
                    <p><strong>Email:</strong> <%= student.getEmail() %></p>
                    <p><strong>Department:</strong> <%= student.getDepartment() %></p>
                </div>
                
                <div class="confirmation-actions">
                    <p>Are you sure you want to permanently delete this student record?</p>
                    <form action="DeleteStudentServlet" method="post">
                        <input type="hidden" name="id" value="<%= student.getId() %>">
                        <button type="submit" class="btn-delete">Yes, Delete Permanently</button>
                        <a href="ViewStudentsServlet" class="btn-cancel">No, Cancel</a>
                    </form>
                </div>
            </section>
            <%
                } else {
            %>
                <div class="message error">
                    Student record not found!
                </div>
                <div class="back-link">
                    <a href="ViewStudentsServlet" class="btn-cancel">Back to Student List</a>
                </div>
            <%
                }
            %>
        </main>
        
        <footer>
            <p>&copy; 2025 Student Record Management System</p>
        </footer>
    </div>
</body>
</html>