package org.example.Jdbc.Entites;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Contact {
    private int id;
    private int customer_id;

    private String firstName;
    private String lastName;
    private String email;
    private String phone;

    public Contact(String firstName, String lastName, String email, String phone) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void ajouter() {
        String sql = """
                INSERT INTO CONTACTS(FIRST_NAME, LAST_NAME, EMAIL, PHONE, CUSTOMER_ID)
                VALUES (?, ?, ?, ?, ?)
                """;

        Connection connection = DbManager.getConnection();

        try {

            // https://stackoverflow.com/questions/42566782/oracle12c-jdbc-identity-and-getgeneratedkeys
            // aller refetch le ID pour le update
            String[] generatedKeyColumns = new String[]{"contact_id"};

            PreparedStatement ps = connection.prepareStatement(sql, generatedKeyColumns);
            ps.setString(1, this.firstName);
            ps.setString(2, this.lastName);
            ps.setString(3, this.email);
            ps.setString(4, this.phone);
            ps.setInt(5, this.customer_id);

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    this.id = rs.getInt(1);
                }
            }

            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void supprimer() {
        String sql = """
                  DELETE FROM CONTACTS
                  WHERE CONTACT_ID = ?
                """;

        Connection connection = DbManager.getConnection();

        try {

            // https://stackoverflow.com/questions/42566782/oracle12c-jdbc-identity-and-getgeneratedkeys
            // aller refetch le ID pour le update
            String[] generatedKeyColumns = new String[]{"contact_id"};

            PreparedStatement ps = connection.prepareStatement(sql, generatedKeyColumns);
            ps.setInt(1, this.id);

            ps.executeUpdate();


            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    this.id = rs.getInt(1);
                }
            }

            ps.close();
            connection.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        System.out.println("Contact supprime avec id " + this.getId());

    }
}
