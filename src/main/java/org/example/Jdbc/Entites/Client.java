package org.example.Jdbc.Entites;

import org.example.Jdbc.DbManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Client {
    private int id;
    private String name;
    private String address;
    private String website;
    private double credit_limit;

    private Contact contact;

    public Client(int id, String name, String address, String website, double credit_limit, Contact contact) {
        this.name = name;
        this.address = address;
        this.website = website;
        this.credit_limit = credit_limit;
        this.contact = contact;
    }

    public Contact getContact() {
        return contact;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public double getCredit_limit() {
        return credit_limit;
    }

    public void setCredit_limit(double credit_limit) {
        this.credit_limit = credit_limit;
    }

    public void ajouter() {
        // AJOUTER CLIENT
        String sql = """
                INSERT INTO CUSTOMERS(name, address, website, credit_limit)
                VALUES(?, ?, ?, ?)
                """;

        Connection connection = DbManager.getConnection();

        try {

            // https://stackoverflow.com/questions/42566782/oracle12c-jdbc-identity-and-getgeneratedkeys
            // aller refetch le ID pour le update
            String[] generatedKeyColumns = new String[]{"customer_id"};

            PreparedStatement ps = connection.prepareStatement(sql, generatedKeyColumns);
            ps.setString(1, this.name);
            ps.setString(2, this.address);
            ps.setString(3, this.website);
            ps.setDouble(4, this.credit_limit);

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    this.id = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // AJOUTER CONTACT

        // Set le id pour eviter les problemes de foreign key
        this.contact.setCustomer_id(this.getId());

        this.contact.ajouter();
    }

    public void modifier() {
        Connection connection = DbManager.getConnection();

        String sql = """
                UPDATE CUSTOMERS SET NAME = ?, ADDRESS = ?, WEBSITE = ?, CREDIT_LIMIT = ?  WHERE CUSTOMER_ID = ?                                                                                                    
                """;

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, this.name);
            preparedStatement.setString(2, this.address);
            preparedStatement.setString(3, this.website);
            preparedStatement.setDouble(4, this.credit_limit);
            preparedStatement.setInt(5, this.id);
            preparedStatement.executeUpdate();

            //Modifier le contact
            preparedStatement.close();
            this.contact.modifier();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void supprimer() {

        this.contact.supprimer();

        String sql = """
                DELETE FROM CUSTOMERS
                WHERE CUSTOMER_ID = ?
                """;

        Connection connection = DbManager.getConnection();

        try {
            // https://stackoverflow.com/questions/42566782/oracle12c-jdbc-identity-and-getgeneratedkeys
            // aller refetch le ID pour le update
            String[] generatedKeyColumns = new String[]{"customer_id"};

            PreparedStatement ps = connection.prepareStatement(sql, generatedKeyColumns);
            ps.setInt(1, this.id);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    this.id = rs.getInt(1);
                }
            }

            connection.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        System.out.println("Client supprime avec id " + this.id);
    }

    @Override
    public String toString() {
        return "Client{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", website='" + website + '\'' +
                ", credit_limit=" + credit_limit +
                ", contact=" + contact +
                '}';
    }
}
