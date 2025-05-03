package com.student.dao;

import com.student.model.Enrollment;
import com.student.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {
    // Enroll a student in a subject
    public boolean enrollStudent(int studentId, int subjectId) throws SQLException {
        String sql = "INSERT INTO enrollments (student_id, subject_id) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, subjectId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Get all enrollments for a subject
    public List<Enrollment> getEnrollmentsBySubject(int subjectId) throws SQLException {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, s.full_name, s.roll_number " +
                     "FROM enrollments e " +
                     "JOIN students s ON e.student_id = s.id " +
                     "WHERE e.subject_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, subjectId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
                    enrollment.setStudentId(rs.getInt("student_id"));
                    enrollment.setSubjectId(rs.getInt("subject_id"));
                    enrollment.setEnrolledAt(rs.getTimestamp("enrolled_at"));
                    
                    // Set student details
                    Student student = new Student();
                    student.setId(rs.getInt("student_id"));
                    student.setFullName(rs.getString("full_name"));
                    student.setRollNumber(rs.getString("roll_number"));
                    enrollment.setStudent(student);
                    
                    enrollments.add(enrollment);
                }
            }
        }
        return enrollments;
    }
    
    // Remove enrollment
    public boolean removeEnrollment(int enrollmentId) throws SQLException {
        String sql = "DELETE FROM enrollments WHERE enrollment_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, enrollmentId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Check if student is already enrolled
    public boolean isEnrolled(int studentId, int subjectId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND subject_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, subjectId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}