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
        /// TODO : Étant donnée que les erreurs se font catch dans le commit, les prints statements s'éxécute pareil
        executeTransaction((e) -> {
            /**
             *  1 - Création d'un client
             * */
            Adresse adresse = new Adresse("la rue", "Quebec", "G33333< ", "Canada");
            e.persist(adresse);
            Client client = new Client("DeLaJungle2", "Georges", "lecourriel3@courriel.com", Genre.HOMME, LocalDate.now(), adresse.getId());
            e.persist(client);

            /**
             *  2 - Création d'un livre
             * */
            Livre livre = new Livre("Benjamin la tortue1", "14145", new BigDecimal(145.5), 10, Categorie.FANTASY, true);
            e.persist(livre);
            /**
             *  3 - Création de commande
             * */
            Commande commande = new Commande(new BigDecimal(189.78), Statut.PAYEE, LocalDate.now(), 10, livre.getId(), client.getId());
            e.persist(commande);


            System.out.println("Client créé : " + client.getNom());
            System.out.println("Adresse créé : " + adresse.getRue() + " " + adresse.getCodepostal() + " " + adresse.getVille());
            System.out.println("Livre créé : " + livre.getTitre());
            System.out.println("Commande créé : " + " Nom client : " + client.getNom() + ", Nom du livre : "+ livre.getTitre() + " ,Total de la commande : " + commande.getTotal() );

        });

        /**
         *  4 - Affichage du client ayant l'id 10
         * */
        executeTransaction((e) -> {
            Client client = e.find(Client.class, 10);
            Adresse clientAdresse = e.find(Adresse.class, client.getAdresseId());
            System.out.println(client.toString() + "l'adresse du client : " + clientAdresse.toString());
        });
        /**
         *  5 - Modification du prix du livre ayant l'id 15
         * */
        executeTransaction((e) -> {
            Livre livre = e.find(Livre.class, 15);
            livre.setPrix(new BigDecimal(10000.43));
            e.persist(livre);
            System.out.println("Modification du prix du livre (" + livre.getTitre()+") : " + livre.getPrix() );
        });

        /***
         * 6- Supprimer la commandes numéro 4
         */
        executeTransaction((e) -> {
            Commande commande = e.find(Commande.class, 40);
            e.remove(commande);
            System.out.println("Supression de la commande id : " + commande.getId());
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
            e.printStackTrace();
        }finally {
            if (emf != null) {
                emf.close();
            }
            if (em != null) {
                em.close();
            }
        }

    }
}
