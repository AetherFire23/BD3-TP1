package org.example.Java;

import org.example.Java.Entite.MeilleurVendeur;
import org.example.Jdbc.DbManager;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MainJava {
    public static void main(String[] args) {
        var connection = DbManager.getConnection();
        List<MeilleurVendeur> meilleurVendeurs = new ArrayList<>();
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
                var moyenneVentes = rs.getDouble(4);
                var firstName = rs.getString(5);
                var lastName = rs.getString(6);

                meilleurVendeurs.add(new MeilleurVendeur(annee, moyenneVentes, firstName + " " + lastName, totalVentesDuMeilleurVenduer));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        for (MeilleurVendeur meilleurVendeur : meilleurVendeurs) {
            String insertData = """
                    INSERT INTO MEILLEUR_VENDEUR(nom, annee, total, moyenne)
                    VALUES (?, ?, ?, ?)
                    """;
            try (
                    PreparedStatement s = connection.prepareStatement(insertData);
            ) {

                s.setString(1, meilleurVendeur.getNom());
                s.setString(2, meilleurVendeur.getAnnee());
                s.setDouble(3, meilleurVendeur.getTotal());
                s.setDouble(4, meilleurVendeur.getMoyenne());

                System.out.println("Ajout du meilleur vendeur :" + meilleurVendeur.toString());
                s.executeUpdate();

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
}
