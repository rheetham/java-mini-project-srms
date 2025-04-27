package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/EditStudentServlet")
public class EditStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new IllegalArgumentException("Student ID is required");
            }
            
            int id = Integer.parseInt(idParam);
            StudentDAO studentDAO = new StudentDAO();
            Student student = studentDAO.getStudentById(id);
            
            if (student == null) {
                request.getSession().setAttribute("error", "No student found with ID: " + id);
                response.sendRedirect("ViewStudentsServlet");
                return;
            }
            
            request.setAttribute("student", student);
            request.getRequestDispatcher("editStudent.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid student ID format");
            response.sendRedirect("ViewStudentsServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect("ViewStudentsServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
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
            
            Student student = new Student();
            student.setId(id);
            student.setRollNumber(rollNumber);
            student.setFullName(fullName);
            student.setEmail(email);
            student.setGender(gender);
            student.setDateOfBirth(dateOfBirth);
            student.setContactNumber(contactNumber);
            student.setAddress(address);
            student.setDepartment(department);
            student.setSemester(semester);
            student.setEnrollmentDate(enrollmentDate);
            
            StudentDAO studentDAO = new StudentDAO();
            boolean success = studentDAO.updateStudent(student);
            
            if (success) {
                request.getSession().setAttribute("message", "Student updated successfully!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("error", "Failed to update student!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error updating student: " + e.getMessage());
        }
        
        response.sendRedirect("ViewStudentsServlet");
    }
}