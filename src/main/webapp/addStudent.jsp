<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Add New Student</h1>
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
            <section class="form-container">
                <form action="AddStudentServlet" method="get">
                    <div class="form-group">
                        <label for="rollNumber">Roll Number:</label>
                        <input type="text" id="rollNumber" name="rollNumber" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="fullName">Full Name:</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Gender:</label>
                        <div class="radio-group">
                            <input type="radio" id="male" name="gender" value="Male" required>
                            <label for="male">Male</label>
                            
                            <input type="radio" id="female" name="gender" value="Female">
                            <label for="female">Female</label>
                            
                            <input type="radio" id="other" name="gender" value="Other">
                            <label for="other">Other</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="dateOfBirth">Date of Birth:</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactNumber">Contact Number:</label>
                        <input type="tel" id="contactNumber" name="contactNumber" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea id="address" name="address" rows="3" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="department">Department:</label>
                        <select id="department" name="department" required>
                            <option value="">Select Department</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Electrical Engineering">Electrical Engineering</option>
                            <option value="Mechanical Engineering">Mechanical Engineering</option>
                            <option value="Civil Engineering">Civil Engineering</option>
                            <option value="Business Administration">Business Administration</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="semester">Semester:</label>
                        <input type="number" id="semester" name="semester" min="1" max="8" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="enrollmentDate">Enrollment Date:</label>
                        <input type="date" id="enrollmentDate" name="enrollmentDate" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn-submit">Add Student</button>
                        <button type="reset" class="btn-reset">Reset</button>
                    </div>
                </form>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 Student Record Management System</p>
        </footer>
    </div>
</body>
</html>