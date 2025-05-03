package com.student.servlet;

import com.student.dao.EnrollmentDAO;
import com.student.dao.SubjectDAO;
import com.student.model.Enrollment;
import com.student.model.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/SubjectServlet")
public class SubjectServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("viewEnrollments".equals(action)) {
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                
                SubjectDAO subjectDAO = new SubjectDAO();
                EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
                
                Subject subject = subjectDAO.getSubjectById(subjectId);
                List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsBySubject(subjectId);
                
                request.setAttribute("subject", subject);
                request.setAttribute("enrollments", enrollments);
                request.getRequestDispatcher("viewEnrollments.jsp").forward(request, response);
                return;
            }
            
            // Always get fresh list of subjects
            SubjectDAO subjectDAO = new SubjectDAO();
            List<Subject> subjects = subjectDAO.getAllSubjects();
            
            request.setAttribute("subjects", subjects);
            request.getRequestDispatcher("viewSubjects.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Error processing request: " + e.getMessage());
            response.sendRedirect("dashboard.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            SubjectDAO subjectDAO = new SubjectDAO();
            HttpSession session = request.getSession();
            
            if ("add".equals(action)) {
                Subject subject = new Subject();
                subject.setSubjectName(request.getParameter("subjectName"));
                
                boolean success = subjectDAO.addSubject(subject);
                if (success) {
                    session.setAttribute("message", "Subject added successfully!");
                } else {
                    session.setAttribute("error", "Failed to add subject");
                }
                
            } else if ("update".equals(action)) {
                Subject subject = new Subject();
                subject.setSubjectId(Integer.parseInt(request.getParameter("subjectId")));
                subject.setSubjectName(request.getParameter("subjectName"));
                
                boolean success = subjectDAO.updateSubject(subject);
                if (success) {
                    session.setAttribute("message", "Subject updated successfully!");
                } else {
                    session.setAttribute("error", "Failed to update subject");
                }
                
            } else if ("delete".equals(action)) {
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                boolean success = subjectDAO.deleteSubject(subjectId);
                
                if (success) {
                    session.setAttribute("message", "Subject deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete subject");
                }
            }
            
            response.sendRedirect("SubjectServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Error processing subject: " + e.getMessage());
            response.sendRedirect("SubjectServlet");
        }
    }
}