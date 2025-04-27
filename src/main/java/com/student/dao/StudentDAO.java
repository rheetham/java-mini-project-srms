package com.student.dao;

import com.student.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    // Add a new student
    public boolean addStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (roll_number, full_name, email, gender, date_of_birth, " +
                     "contact_number, address, department, semester, enrollment_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getRollNumber());
            stmt.setString(2, student.getFullName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getGender());
            stmt.setDate(5, new java.sql.Date(student.getDateOfBirth().getTime()));
            stmt.setString(6, student.getContactNumber());
            stmt.setString(7, student.getAddress());
            stmt.setString(8, student.getDepartment());
            stmt.setInt(9, student.getSemester());
            stmt.setDate(10, new java.sql.Date(student.getEnrollmentDate().getTime()));
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Get all students
    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setRollNumber(rs.getString("roll_number"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setGender(rs.getString("gender"));
                student.setDateOfBirth(rs.getDate("date_of_birth"));
                student.setContactNumber(rs.getString("contact_number"));
                student.setAddress(rs.getString("address"));
                student.setDepartment(rs.getString("department"));
                student.setSemester(rs.getInt("semester"));
                student.setEnrollmentDate(rs.getDate("enrollment_date"));
                
                students.add(student);
            }
        }
        return students;
    }
    
    // Get student by ID
    public Student getStudentById(int id) throws SQLException {
        String sql = "SELECT * FROM students WHERE id = ?";
        Student student = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setRollNumber(rs.getString("roll_number"));
                    student.setFullName(rs.getString("full_name"));
                    student.setEmail(rs.getString("email"));
                    student.setGender(rs.getString("gender"));
                    student.setDateOfBirth(rs.getDate("date_of_birth"));
                    student.setContactNumber(rs.getString("contact_number"));
                    student.setAddress(rs.getString("address"));
                    student.setDepartment(rs.getString("department"));
                    student.setSemester(rs.getInt("semester"));
                    student.setEnrollmentDate(rs.getDate("enrollment_date"));
                }
            }
        }
        return student;
    }
    
    // Update student
    public boolean updateStudent(Student student) throws SQLException {
        String sql = "UPDATE students SET roll_number=?, full_name=?, email=?, gender=?, " +
                     "date_of_birth=?, contact_number=?, address=?, department=?, " +
                     "semester=?, enrollment_date=? WHERE id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getRollNumber());
            stmt.setString(2, student.getFullName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getGender());
            stmt.setDate(5, new java.sql.Date(student.getDateOfBirth().getTime()));
            stmt.setString(6, student.getContactNumber());
            stmt.setString(7, student.getAddress());
            stmt.setString(8, student.getDepartment());
            stmt.setInt(9, student.getSemester());
            stmt.setDate(10, new java.sql.Date(student.getEnrollmentDate().getTime()));
            stmt.setInt(11, student.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Delete student
    public boolean deleteStudent(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
}