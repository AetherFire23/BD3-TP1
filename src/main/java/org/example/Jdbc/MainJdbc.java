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

<<<<<<< HEAD
        client.setName("Georges");
        contact.setEmail("Test23@gmail.com");
        client.modifier();
=======
        client.supprimer();
>>>>>>> adade4f567cd5ac6bdd54954d6f86f72615f33d1
    }
}
