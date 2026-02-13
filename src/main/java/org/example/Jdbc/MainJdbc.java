package org.example.Jdbc;

import org.example.Jdbc.Entites.Client;
import org.example.Jdbc.Entites.Contact;

import java.sql.*;

public class MainJdbc {
    public static void main(String[] args) {
        // o	Créer un objet client et contact en remplissant tous les attributs.
        Contact contact = new Contact("Jean", "Lamoureux", "Lhomme-Feu@hotmail.ca", "4503465745");

        Client client = new Client(-1, "Tabourets Élite Inc.", "123 venue pigeon", "www.EliteTabourets.org", 20000, contact);

        client.ajouter();

        System.out.println(client.toString());
        client.setAddress("456 nouvelle-adresse");
        client.setName("Biggus Diggus");
        client.setCredit_limit(12000);

        client.modifier();
        System.out.println(client.toString());

        client.supprimer();

        // crer trois objets client et contact
        Contact contact2 = new Contact("Léo", "Béliveau", "leobeliveau@yahoolca", "124124");
        Client client2 = new Client(-1, "Les Entreprises Dièse Co.", "1202 avenue Sharp", "www.diese.co", 20000, contact);

        Contact contact3 = new Contact("Davy", "Boisselot", "davy_boisselot@hotmail.ca", "124124124");
        Client client3 = new Client(-1, "Pirate Cosplay de Davy Jones.", "123 venue pigeon", "www.davy-jones-le-pirate.org", 7666, contact);

        Contact contact4 = new Contact("Émeric ", "Lincoln", "Emeric-lincoln@hotmail.ca", "161581");
        Client client4 = new Client(-1, "Lincoln fils : l'histoire du fils illégitime", "555 venue pigeon", "", 200, contact);

        getClients();
    }

    public static void getClients() {
        String sql = "SELECT * FROM CUSTOMERS";
        Connection connection = DbManager.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet s = ps.executeQuery();
            while (s.next()) {
                System.out.println(s.getString(1));
                System.out.println(s.getString(2));
                System.out.println(s.getString(3));
                System.out.println(s.getString(4));
                System.out.println(s.getString(5));
            }

            connection.close();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
