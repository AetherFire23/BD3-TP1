package org.example.JPA;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import org.example.JPA.Entites.Adresse;
import org.example.JPA.Entites.Client;
import org.example.JPA.Enums.Genre;

import java.time.LocalDate;
import java.util.function.Consumer;

public class JpaMain {
    public static void main(String[] args) {
        EntityManager em = null;
        System.out.println("Allo");
//        try (EntityManagerFactory emf = Persistence.createEntityManagerFactory("bibliothequePU")) {
//            em = emf.createEntityManager();
//            var transaction = em.getTransaction();
//            transaction.begin();
//            Adresse adresse = new Adresse("ASD", "SADDS", "ASDASD< ", "ASDASD");
//
//            em.persist(adresse);
//
//            Client client = new Client("Richer", "adsad", Genre.HOMME, LocalDate.now(), adresse.getId());
//            em.persist(client);
//            transaction.commit();
//        } catch (Exception e) {
//            if (em != null) {
//                em.close();
//            }
//        }

        executeTransaction((e) -> {
            Adresse adresse = new Adresse("ASD", "SADDS", "ASDASD< ", "ASDASD");
            e.persist(adresse);
            Client client = new Client("Richer", "adsad", Genre.HOMME, LocalDate.now(), adresse.getId());
            e.persist(client);
        });
    }

    /**
     * Methode pour Wrapper un appel Avec transaction.
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
