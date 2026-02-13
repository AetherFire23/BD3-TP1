package org.example.JPA.Entites;

import jakarta.persistence.Column;
import jakarta.persistence.Id;


public class Client {

    @Id
    @Column(name="customer_id")
    private int id;


    // TODO: le split pour son full name
    private String nom;

//    private String prenom;


    private String email;

    private String website;

}
