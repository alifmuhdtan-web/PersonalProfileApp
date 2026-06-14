package com.profile;

import java.sql.*;

public class MySQLTest {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student_profiles?useSSL=false", 
                "root", 
                "1234"  // Your password
            );
            System.out.println("✅ MySQL Connection Successful!");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM profiles");
            if (rs.next()) {
                System.out.println("Total profiles in database: " + rs.getInt(1));
            }
            
            // Display all profiles
            rs = stmt.executeQuery("SELECT * FROM profiles");
            System.out.println("\n📋 Profiles in database:");
            while (rs.next()) {
                System.out.println("- " + rs.getString("name") + " (" + rs.getString("student_id") + ")");
            }
            
            conn.close();
            System.out.println("\n✅ Test completed successfully!");
            
        } catch (Exception e) {
            System.err.println("❌ Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}