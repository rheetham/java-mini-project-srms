package com.student.dao;

import com.student.model.Subject;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {
    // Add a new subject
    public boolean addSubject(Subject subject) throws SQLException {
        String sql = "INSERT INTO subjects (subject_name) VALUES (?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, subject.getSubjectName());
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Get all subjects
    public List<Subject> getAllSubjects() throws SQLException {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT * FROM subjects ORDER BY subject_name";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setCreatedAt(rs.getTimestamp("created_at"));
                
                subjects.add(subject);
            }
        }
        return subjects;
    }
    
    // Get subject by ID
    public Subject getSubjectById(int id) throws SQLException {
        String sql = "SELECT * FROM subjects WHERE subject_id = ?";
        Subject subject = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    subject = new Subject();
                    subject.setSubjectId(rs.getInt("subject_id"));
                    subject.setSubjectName(rs.getString("subject_name"));
                    subject.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        }
        return subject;
    }
    
    // Update subject
    public boolean updateSubject(Subject subject) throws SQLException {
        String sql = "UPDATE subjects SET subject_name = ? WHERE subject_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, subject.getSubjectName());
            stmt.setInt(2, subject.getSubjectId());
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Delete subject
    public boolean deleteSubject(int id) throws SQLException {
        String deleteAllEnrollments = "DELETE FROM enrollments WHERE subject_id = ?";
        String deleteSubject = "DELETE FROM subjects WHERE subject_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
             PreparedStatement stmtEnrollments = conn.prepareStatement(deleteAllEnrollments);
        	 PreparedStatement stmt = conn.prepareStatement(deleteSubject);
        	 
        	stmtEnrollments.setInt(1, id);
            stmt.setInt(1, id);
            stmtEnrollments.executeUpdate();
            return stmt.executeUpdate() > 0;
        }
    }
}