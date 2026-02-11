package org.example;


import java.sql.*;
import java.util.Properties;

public class InstallMain {
    public static void main(String[] args)  {

        Properties props = new Properties();
        props.setProperty("user", "sys");
        props.setProperty("password", "admin");
        props.setProperty("internal_logon", "sysdba");

        Connection conn = null;
        try {
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE",
                    props
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}