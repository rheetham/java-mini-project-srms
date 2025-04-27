package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String rollNumber = request.getParameter("rollNumber");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        Date dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        String department = request.getParameter("department");
        int semester = Integer.parseInt(request.getParameter("semester"));
        Date enrollmentDate = Date.valueOf(request.getParameter("enrollmentDate"));
        
        Student student = new Student(rollNumber, fullName, email, gender, dateOfBirth, 
                                    contactNumber, address, department, semester, enrollmentDate);
        
        try {
            StudentDAO studentDAO = new StudentDAO();
            boolean success = studentDAO.addStudent(student);
            
            if (success) {
                request.getSession().setAttribute("message", "Student added successfully!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Failed to add student!");
                request.getSession().setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect("addStudent.jsp");
    }
}