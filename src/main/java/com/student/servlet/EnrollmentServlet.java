package com.student.servlet;

import com.student.dao.EnrollmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/EnrollmentServlet")
public class EnrollmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        
        try {
            EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
            HttpSession session = request.getSession();
            
            if ("enroll".equals(action)) {
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                
                if (!enrollmentDAO.isEnrolled(studentId, subjectId)) {
                    boolean success = enrollmentDAO.enrollStudent(studentId, subjectId);
                    if (success) {
                        session.setAttribute("message", "Student enrolled successfully!");
                    } else {
                        session.setAttribute("error", "Failed to enroll student");
                    }
                } else {
                    session.setAttribute("error", "Student is already enrolled in this subject");
                }
                
            } else if ("remove".equals(action)) {
                int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
                boolean success = enrollmentDAO.removeEnrollment(enrollmentId);
                
                if (success) {
                    session.setAttribute("message", "Enrollment removed successfully!");
                } else {
                    session.setAttribute("error", "Failed to remove enrollment");
                }
            }
            
            response.sendRedirect("SubjectServlet?action=viewEnrollments&subjectId=" + subjectId);
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Error processing enrollment: " + e.getMessage());
            response.sendRedirect("SubjectServlet");
        }
    }
}