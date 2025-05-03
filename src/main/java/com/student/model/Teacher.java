// Teacher.java
package com.student.model;

import java.sql.Timestamp;
import java.util.List;

public class Teacher {
    private int teacherId;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private Timestamp createdAt;
    private List<Subject> assignedSubjects;
    
    // Constructors
    public Teacher() {}
    
    public Teacher(String firstName, String lastName, String email, String phone) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
    }
    
    // Getters and Setters
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public List<Subject> getAssignedSubjects() { return assignedSubjects; }
    public void setAssignedSubjects(List<Subject> assignedSubjects) { 
        this.assignedSubjects = assignedSubjects; 
    }
    
    public String getFullName() {
        return firstName + " " + lastName;
    }
}