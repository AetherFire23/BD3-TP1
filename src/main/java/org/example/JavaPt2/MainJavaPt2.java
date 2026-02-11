package org.example.JavaPt2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class MainJavaPt2 {
    public static void main(String[] args) {
        Properties props = new Properties();

        props.setProperty("user", "sys");
        props.setProperty("passowrd", "admin");
        props.setProperty("internal_logon", "SYSDBA");
        
        Connection connection;
        try {
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "TP1", "QWEQWE123123");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
