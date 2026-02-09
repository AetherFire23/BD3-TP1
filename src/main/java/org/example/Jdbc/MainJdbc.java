package org.example.Jdbc;

import org.example.Jdbc.Entites.Client;

import java.sql.*;

public class MainJdbc {
    public static void main(String[] args) {
        // o	Créer un objet client et contact en remplissant tous les attributs.

        Client client = new Client(1, "Tabourets Élite Inc.", "123 venue pigeon", "www.EliteTabourets.org", 20000);

        client.ajouter();
    }
}
