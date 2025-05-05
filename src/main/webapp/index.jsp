<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Record Management System</title>
    <link rel="stylesheet" href="css/style.css">
        <style>
        header {
        	margin-top: 15px;
        }
    	section {
    		height: 50vh;
    		margin-bottom: 50px;
    		display: flex;
    		flex-direction: column;
    		align-items: center;
    		justify-content: center;
    	}
    </style>
</head>
<body>
    <div class="container">
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
        
        <main>
            <section class="welcome">
                <h2>Welcome to SRMS</h2>
                <p>Manage student records efficiently with our system.</p>
            </section>
        </main>
        
        <footer>
            <p>&copy; 2025 Student Record Management System</p>
        </footer>
    </div>
</body>
</html>