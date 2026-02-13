package org.example.JPA.Entites;

import jakarta.persistence.*;
import org.example.JPA.Enums.Genre;

import java.time.LocalDate;


@Entity
public class Client {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // TODO: le split pour son full name
    private String nom;

    private String email;

    @Transient
    private String nomComplet;

    @Enumerated(EnumType.STRING)
    private Genre genre;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(name = "id_adresse")
    private int adresseId;

    public Client() {
    }

    public Client(String nom, String email, Genre genre, LocalDate dateNaissance, int adresseId) {
        this.nom = nom;
        this.email = email;
        this.genre = genre;
        this.dateNaissance = dateNaissance;
        this.adresseId = adresseId;
        // TODO:
        // this.nomComplet = ...
    }
}
