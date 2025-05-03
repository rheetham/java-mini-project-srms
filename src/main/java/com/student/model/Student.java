package com.student.model;

import java.util.Date;

public class Student {
    private int id;
    private String rollNumber;
    private String fullName;
    private String email;
    private String gender;
    private Date dateOfBirth;
    private String contactNumber;
    private String address;
    private String department;
    private int semester;
    private Date enrollmentDate;
    
    // Constructors, getters, and setters
    public Student() {}
    
    public Student(String rollNumber, String fullName, String email, String gender, 
                  Date dateOfBirth, String contactNumber, String address, 
                  String department, int semester, Date enrollmentDate) {
        this.setRollNumber(rollNumber);
        this.setFullName(fullName);
        this.setEmail(email);
        this.setGender(gender);
        this.setDateOfBirth(dateOfBirth);
        this.setContactNumber(contactNumber);
        this.setAddress(address);
        this.setDepartment(department);
        this.setSemester(semester);
        this.setEnrollmentDate(enrollmentDate);
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRollNumber() {
		return rollNumber;
	}

	public void setRollNumber(String rollNumber) {
		this.rollNumber = rollNumber;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public int getSemester() {
		return semester;
	}

	public void setSemester(int semester) {
		this.semester = semester;
	}

	public Date getEnrollmentDate() {
		return enrollmentDate;
	}

	public void setEnrollmentDate(Date enrollmentDate) {
		this.enrollmentDate = enrollmentDate;
	}
}