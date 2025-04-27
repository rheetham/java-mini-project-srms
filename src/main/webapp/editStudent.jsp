<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Student, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Edit Student</h1>
        </header>
        
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="addStudent.jsp">Add Student</a></li>
                <li><a href="ViewStudentsServlet">View Students</a></li>
            </ul>
        </nav>
        
        <main>
            <section class="form-container">
                <%
                    Student student = (Student) request.getAttribute("student");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                %>
                <form action="EditStudentServlet" method="post">
                    <input type="hidden" name="id" value="<%= student.getId() %>">
                    
                    <div class="form-group">
                        <label for="rollNumber">Roll Number:</label>
                        <input type="text" id="rollNumber" name="rollNumber" 
                               value="<%= student.getRollNumber() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="fullName">Full Name:</label>
                        <input type="text" id="fullName" name="fullName" 
                               value="<%= student.getFullName() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" 
                               value="<%= student.getEmail() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Gender:</label>
                        <div class="radio-group">
                            <input type="radio" id="male" name="gender" value="Male" 
                                   <%= "Male".equals(student.getGender()) ? "checked" : "" %> required>
                            <label for="male">Male</label>
                            
                            <input type="radio" id="female" name="gender" value="Female"
                                   <%= "Female".equals(student.getGender()) ? "checked" : "" %>>
                            <label for="female">Female</label>
                            
                            <input type="radio" id="other" name="gender" value="Other"
                                   <%= "Other".equals(student.getGender()) ? "checked" : "" %>>
                            <label for="other">Other</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="dateOfBirth">Date of Birth:</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" 
                               value="<%= sdf.format(student.getDateOfBirth()) %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactNumber">Contact Number:</label>
                        <input type="tel" id="contactNumber" name="contactNumber" 
                               value="<%= student.getContactNumber() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea id="address" name="address" rows="3" required><%= student.getAddress() %></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="department">Department:</label>
                        <select id="department" name="department" required>
                            <option value="">Select Department</option>
                            <option value="Computer Science" <%= "Computer Science".equals(student.getDepartment()) ? "selected" : "" %>>Computer Science</option>
                            <option value="Electrical Engineering" <%= "Electrical Engineering".equals(student.getDepartment()) ? "selected" : "" %>>Electrical Engineering</option>
                            <option value="Mechanical Engineering" <%= "Mechanical Engineering".equals(student.getDepartment()) ? "selected" : "" %>>Mechanical Engineering</option>
                            <option value="Civil Engineering" <%= "Civil Engineering".equals(student.getDepartment()) ? "selected" : "" %>>Civil Engineering</option>
                            <option value="Business Administration" <%= "Business Administration".equals(student.getDepartment()) ? "selected" : "" %>>Business Administration</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="semester">Semester:</label>
                        <input type="number" id="semester" name="semester" min="1" max="8" 
                               value="<%= student.getSemester() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="enrollmentDate">Enrollment Date:</label>
                        <input type="date" id="enrollmentDate" name="enrollmentDate" 
                               value="<%= sdf.format(student.getEnrollmentDate()) %>" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-submit">Update Student</button>
                        <a href="ViewStudentsServlet" class="btn-cancel">Cancel</a>
                    </div>
                </form>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2023 Student Record Management System</p>
        </footer>
    </div>
</body>
</html>