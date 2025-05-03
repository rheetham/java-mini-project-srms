package com.student.dao;

import com.student.model.Teacher;
import com.student.model.Subject;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {
    // Add a new teacher
    public boolean addTeacher(Teacher teacher) throws SQLException {
        String sql = "INSERT INTO teachers (first_name, last_name, email, phone) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, teacher.getFirstName());
            stmt.setString(2, teacher.getLastName());
            stmt.setString(3, teacher.getEmail());
            stmt.setString(4, teacher.getPhone());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        teacher.setTeacherId(rs.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }
    
    // Get all teachers
    public List<Teacher> getAllTeachers() throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teachers ORDER BY last_name, first_name";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherId(rs.getInt("teacher_id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setLastName(rs.getString("last_name"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPhone(rs.getString("phone"));
                teacher.setCreatedAt(rs.getTimestamp("created_at"));
                
                // Get assigned subjects
                teacher.setAssignedSubjects(getAssignedSubjects(teacher.getTeacherId()));
                
                teachers.add(teacher);
            }
        }
        return teachers;
    }
    
    // Get teacher by ID
    public Teacher getTeacherById(int id) throws SQLException {
        String sql = "SELECT * FROM teachers WHERE teacher_id = ?";
        Teacher teacher = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    teacher = new Teacher();
                    teacher.setTeacherId(rs.getInt("teacher_id"));
                    teacher.setFirstName(rs.getString("first_name"));
                    teacher.setLastName(rs.getString("last_name"));
                    teacher.setEmail(rs.getString("email"));
                    teacher.setPhone(rs.getString("phone"));
                    teacher.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Get assigned subjects
                    teacher.setAssignedSubjects(getAssignedSubjects(teacher.getTeacherId()));
                }
            }
        }
        return teacher;
    }
    
    // Update teacher
    public boolean updateTeacher(Teacher teacher) throws SQLException {
        String sql = "UPDATE teachers SET first_name = ?, last_name = ?, email = ?, phone = ? WHERE teacher_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, teacher.getFirstName());
            stmt.setString(2, teacher.getLastName());
            stmt.setString(3, teacher.getEmail());
            stmt.setString(4, teacher.getPhone());
            stmt.setInt(5, teacher.getTeacherId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Delete teacher
    public boolean deleteTeacher(int id) throws SQLException {
        // First remove all subject assignments
        String deleteAssignments = "DELETE FROM teacher_subjects WHERE teacher_id = ?";
        String deleteTeacher = "DELETE FROM teachers WHERE teacher_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Start transaction
            conn.setAutoCommit(false);
            
            try (PreparedStatement stmtAssignments = conn.prepareStatement(deleteAssignments);
                 PreparedStatement stmtTeacher = conn.prepareStatement(deleteTeacher)) {
                
                stmtAssignments.setInt(1, id);
                stmtTeacher.setInt(1, id);
                
                stmtAssignments.executeUpdate();
                int affectedRows = stmtTeacher.executeUpdate();
                
                conn.commit();
                return affectedRows > 0;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }
    
    // Get subjects assigned to a teacher
    public List<Subject> getAssignedSubjects(int teacherId) throws SQLException {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT s.* FROM subjects s " +
                     "JOIN teacher_subjects ts ON s.subject_id = ts.subject_id " +
                     "WHERE ts.teacher_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, teacherId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Subject subject = new Subject();
                    subject.setSubjectId(rs.getInt("subject_id"));
                    subject.setSubjectName(rs.getString("subject_name"));
                    subject.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    subjects.add(subject);
                }
            }
        }
        return subjects;
    }
    
    // Assign subject to teacher
    public boolean assignSubjectToTeacher(int teacherId, int subjectId) throws SQLException {
        String sql = "INSERT INTO teacher_subjects (teacher_id, subject_id) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, teacherId);
            stmt.setInt(2, subjectId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Remove subject assignment from teacher
    public boolean removeSubjectFromTeacher(int teacherId, int subjectId) throws SQLException {
        String sql = "DELETE FROM teacher_subjects WHERE teacher_id = ? AND subject_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, teacherId);
            stmt.setInt(2, subjectId);
            return stmt.executeUpdate() > 0;
        }
    }
}