package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewStudentsServlet")
public class ViewStudentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            StudentDAO studentDAO = new StudentDAO();
            List<Student> students = studentDAO.getAllStudents();
            
            request.setAttribute("students", students);
            request.getRequestDispatcher("viewStudents.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect("index.jsp");
        }
    }
}