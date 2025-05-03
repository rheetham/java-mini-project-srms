package com.student.model;

import java.sql.Timestamp;

public class Subject {
    private int subjectId;
    private String subjectName;
    private Timestamp createdAt;
    
    // Constructors
    public Subject() {}
    
    public Subject(String subjectName) {
        this.subjectName = subjectName;
    }
    
    // Getters and Setters
    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }
    
    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}