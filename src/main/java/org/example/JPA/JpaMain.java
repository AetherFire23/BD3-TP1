package org.example.JPA;

import jakarta.persistence.*;
import org.example.JPA.Entites.Adresse;
import org.example.JPA.Entites.Client;
import org.example.JPA.Entites.Commande;
import org.example.JPA.Entites.Livre;
import org.example.JPA.Enums.Categorie;
import org.example.JPA.Enums.Genre;
import org.example.JPA.Enums.Statut;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.function.Consumer;

public class JpaMain {
    public static void main(String[] args) {
        EntityManager em = null;

        executeTransaction((e) -> {
            /**
             *  1 - Création d'un client
             * */
            Adresse adresse = new Adresse("la rue", "Quebec", "G33333< ", "Canada");
            e.persist(adresse);
            Client client = new Client("DeLaJungle2", "Georges", "lecourrie@courriel.com", Genre.HOMME, LocalDate.now(), adresse.getId());
            e.persist(client);
            /**
             *  2 - Création d'un livre
             * */
            Livre livre = new Livre("Benjamin la tortue1","14145",new BigDecimal(145.5),10, Categorie.FANTASY,true);
            e.persist(livre);

            Commande commande = new Commande(new BigDecimal(189.78), Statut.PAYEE,LocalDate.now(),10, livre.getId(), client.getId());
            e.persist(commande);
        });





    }

    /**
     * Methode pour Wrapper un appel Avec transaction.
     *
     * @param runnable
     */
    public static void executeTransaction(Consumer<EntityManager> runnable) {

        EntityManagerFactory emf = null;
        EntityManager em = null;
        try {
            emf = Persistence.createEntityManagerFactory("bibliothequePU");
            em = emf.createEntityManager();
            EntityTransaction transaction = em.getTransaction();
            transaction.begin();

            try {
                runnable.accept(em);
            } catch (Exception e) {
                // Si erreur durant l'appel, rollback
                transaction.rollback();
                e.printStackTrace();
            }

            transaction.commit();

        } catch (Exception e) {
            if (emf != null) {
                emf.close();
            }
            if (em != null) {
                em.close();
            }
            e.printStackTrace();
        }
    }
}
