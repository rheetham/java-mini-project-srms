// TeacherServlet.java
package com.student.servlet;

import com.student.dao.TeacherDAO;
import com.student.dao.SubjectDAO;
import com.student.model.Teacher;
import com.student.model.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/TeacherServlet")
public class TeacherServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            TeacherDAO teacherDAO = new TeacherDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            
            if ("view".equals(action)) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                Teacher teacher = teacherDAO.getTeacherById(teacherId);
                List<Subject> allSubjects = subjectDAO.getAllSubjects();
                
                request.setAttribute("teacher", teacher);
                request.setAttribute("allSubjects", allSubjects);
                request.getRequestDispatcher("viewTeacher.jsp").forward(request, response);
                return;
            }
            
            if ("edit".equals(action)) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                Teacher teacher = teacherDAO.getTeacherById(teacherId);
                List<Subject> allSubjects = subjectDAO.getAllSubjects();
                
                request.setAttribute("teacher", teacher);
                request.setAttribute("allSubjects", allSubjects);
                request.getRequestDispatcher("editTeacher.jsp").forward(request, response);
                return;
            }
            
            // Default action: show all teachers
            List<Teacher> teachers = teacherDAO.getAllTeachers();
            request.setAttribute("teachers", teachers);
            request.getRequestDispatcher("viewTeachers.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Error processing request: " + e.getMessage());
            response.sendRedirect("index.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            TeacherDAO teacherDAO = new TeacherDAO();
            HttpSession session = request.getSession();
            
            if ("add".equals(action)) {
                Teacher teacher = new Teacher();
                teacher.setFirstName(request.getParameter("firstName"));
                teacher.setLastName(request.getParameter("lastName"));
                teacher.setEmail(request.getParameter("email"));
                teacher.setPhone(request.getParameter("phone"));
                
                boolean success = teacherDAO.addTeacher(teacher);
                if (success) {
                    session.setAttribute("message", "Teacher added successfully!");
                } else {
                    session.setAttribute("error", "Failed to add teacher");
                }
                
            } else if ("update".equals(action)) {
                Teacher teacher = new Teacher();
                teacher.setTeacherId(Integer.parseInt(request.getParameter("teacherId")));
                teacher.setFirstName(request.getParameter("firstName"));
                teacher.setLastName(request.getParameter("lastName"));
                teacher.setEmail(request.getParameter("email"));
                teacher.setPhone(request.getParameter("phone"));
                
                boolean success = teacherDAO.updateTeacher(teacher);
                if (success) {
                    session.setAttribute("message", "Teacher updated successfully!");
                } else {
                    session.setAttribute("error", "Failed to update teacher");
                }
                
            } else if ("delete".equals(action)) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                boolean success = teacherDAO.deleteTeacher(teacherId);
                
                if (success) {
                    session.setAttribute("message", "Teacher deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete teacher");
                }
                
            } else if ("assignSubject".equals(action)) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                
                boolean success = teacherDAO.assignSubjectToTeacher(teacherId, subjectId);
                if (success) {
                    session.setAttribute("message", "Subject assigned successfully!");
                } else {
                    session.setAttribute("error", "Failed to assign subject");
                }
                response.sendRedirect("TeacherServlet?action=view&teacherId=" + teacherId);
                return;
                
            } else if ("removeSubject".equals(action)) {
                int teacherId = Integer.parseInt(request.getParameter("teacherId"));
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                
                boolean success = teacherDAO.removeSubjectFromTeacher(teacherId, subjectId);
                if (success) {
                    session.setAttribute("message", "Subject removed successfully!");
                } else {
                    session.setAttribute("error", "Failed to remove subject");
                }
                response.sendRedirect("TeacherServlet?action=view&teacherId=" + teacherId);
                return;
            }
            
            response.sendRedirect("TeacherServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Error processing teacher: " + e.getMessage());
            response.sendRedirect("TeacherServlet");
        }
    }
}