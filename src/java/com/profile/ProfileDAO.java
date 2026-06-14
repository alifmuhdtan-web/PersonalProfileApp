package com.profile;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProfileDAO {
    
    private static final Logger LOGGER = Logger.getLogger(ProfileDAO.class.getName());
    
    
    public boolean insertProfile(ProfileBean profile) {
        String sql = "INSERT INTO profiles (name, student_id, programme, email, hobbies, intro) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getStudentId());
            pstmt.setString(3, profile.getProgramme());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntro());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting profile: {0}", e.getMessage());
            return false;
        }
    }
    
    
    public List<ProfileBean> getAllProfiles() {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profiles ORDER BY id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("student_id"));
                profile.setProgramme(rs.getString("programme"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntro(rs.getString("intro"));
                profile.setCreatedAt(rs.getTimestamp("created_at"));
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all profiles: {0}", e.getMessage());
        }
        
        return profiles;
    }
    
    
    public ProfileBean getProfileById(int id) {
        String sql = "SELECT * FROM profiles WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("student_id"));
                profile.setProgramme(rs.getString("programme"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntro(rs.getString("intro"));
                profile.setCreatedAt(rs.getTimestamp("created_at"));
                return profile;
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting profile by id {0}: {1}", new Object[]{id, e.getMessage()});
        }
        
        return null;
    }
    
    
    public List<ProfileBean> searchProfiles(String keyword) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profiles WHERE name LIKE ? OR student_id LIKE ? ORDER BY id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("student_id"));
                profile.setProgramme(rs.getString("programme"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntro(rs.getString("intro"));
                profile.setCreatedAt(rs.getTimestamp("created_at"));
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching profiles with keyword {0}: {1}", new Object[]{keyword, e.getMessage()});
        }
        
        return profiles;
    }
    
    
    public List<ProfileBean> filterByProgramme(String programme) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profiles WHERE programme LIKE ? ORDER BY id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + programme + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("student_id"));
                profile.setProgramme(rs.getString("programme"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntro(rs.getString("intro"));
                profile.setCreatedAt(rs.getTimestamp("created_at"));
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error filtering by programme {0}: {1}", new Object[]{programme, e.getMessage()});
        }
        
        return profiles;
    }
    
    
    public boolean updateProfile(ProfileBean profile) {
        String sql = "UPDATE profiles SET name=?, student_id=?, programme=?, email=?, hobbies=?, intro=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getStudentId());
            pstmt.setString(3, profile.getProgramme());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntro());
            pstmt.setInt(7, profile.getId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating profile id {0}: {1}", new Object[]{profile.getId(), e.getMessage()});
            return false;
        }
    }
    
    
    public boolean deleteProfile(int id) {
        String sql = "DELETE FROM profiles WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting profile id {0}: {1}", new Object[]{id, e.getMessage()});
            return false;
        }
    }
}