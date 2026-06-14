package com.profile;

import java.io.Serializable;
import java.util.Date;

public class ProfileBean implements Serializable {
    
    private int id;
    private String name;
    private String studentId;
    private String programme;
    private String email;
    private String hobbies;
    private String intro;
    private Date createdAt;
    
    
    public ProfileBean() {}
    
    
    public ProfileBean(String name, String studentId, String programme, 
                       String email, String hobbies, String intro) {
        this.name = name;
        this.studentId = studentId;
        this.programme = programme;
        this.email = email;
        this.hobbies = hobbies;
        this.intro = intro;
    }
    
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public String getProgramme() {
        return programme;
    }
    
    public void setProgramme(String programme) {
        this.programme = programme;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getHobbies() {
        return hobbies;
    }
    
    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }
    
    public String getIntro() {
        return intro;
    }
    
    public void setIntro(String intro) {
        this.intro = intro;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "ProfileBean{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", studentId='" + studentId + '\'' +
                ", programme='" + programme + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}