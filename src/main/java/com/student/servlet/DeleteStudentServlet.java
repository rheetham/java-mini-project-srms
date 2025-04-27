package com.student.servlet;

import com.student.dao.StudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            StudentDAO studentDAO = new StudentDAO();
            boolean success = studentDAO.deleteStudent(id);
            
            if (success) {
                request.getSession().setAttribute("message", "Student deleted successfully!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Failed to delete student!");
                request.getSession().setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect("ViewStudentsServlet");
    }
}