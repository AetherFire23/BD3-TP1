package org.example.Jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbManager {
    public static Connection getConnection() {
        Connection connection;
        try {
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "TP1", "QWEQWE123123");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return connection;
    }
}
