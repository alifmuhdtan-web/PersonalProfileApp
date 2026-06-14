package com.profile;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {
    
    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());
    
    private static final String URL = "jdbc:mysql://localhost:3306/student_profiles?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";

    private static Connection connection = null;

    private DBConnection() {}

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                LOGGER.info("Database connected successfully!");
            }
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "MySQL JDBC Driver not found! {0}", e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Connection failed: {0}", e.getMessage());
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    LOGGER.info("Database connection closed.");
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing connection: {0}", e.getMessage());
            } finally {
                connection = null;
            }
        }
    }
}