package org.example.Java;

import org.example.Java.Entite.MeilleurVendeur;
import org.example.Jdbc.DbManager;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MainJava {
    public static void main(String[] args) {
        var connection = DbManager.getConnection();
        String violentSql =
                """
                            SELECT * FROM COMMANDES_INFO
                        """;

        try (
                PreparedStatement s = connection.prepareStatement(violentSql);
                ResultSet rs = s.executeQuery();
        ) {
            while (rs.next()) {
                var annee = rs.getString(1);
                var totalVentesDuMeilleurVenduer = rs.getDouble(2);
                var salesmanId = rs.getInt(3);
                var moyenneVentes = rs.getDouble(4);

                var meilleurVendeur = new MeilleurVendeur(annee, );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
