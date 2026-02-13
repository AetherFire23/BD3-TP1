package org.example.JPA;

import jakarta.persistence.*;
import org.example.JPA.Entites.Adresse;

public class JpaMain {
    public static void main(String[] args) {

        System.out.println("Allo");
        try (EntityManagerFactory emf = Persistence.createEntityManagerFactory("bibliothequePU")) {
            EntityManager em = emf.createEntityManager();

            Adresse adresse = new Adresse("ASD", "SADDS", "ASDASD< ", "ASDASD");


            em.close();
        }
    }
}
