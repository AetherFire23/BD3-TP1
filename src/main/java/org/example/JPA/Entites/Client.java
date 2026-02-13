package org.example.JPA.Entites;

import jakarta.persistence.*;
import org.example.JPA.Enums.Genre;

import java.time.LocalDate;


@Entity
@Table(name="clients")
public class Client {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "jpa_seq_clients")
    @SequenceGenerator(name = "jpa_seq_clients", sequenceName = "seq_clients", allocationSize = 1)
    private int id;
    @Column
    private String nom;

    @Column
    private String prenom;

    @Column
    private String email;

    @Transient
    private String nomComplet;

    @Enumerated(EnumType.STRING)
    private Genre genre;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(name = "adresse_id")
    private int adresseId;



    public Client() {
    }

    public Client(String nom,String prenom, String email, Genre genre, LocalDate dateNaissance, int adresseId) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.genre = genre;
        this.dateNaissance = dateNaissance;
        this.adresseId = adresseId;
        this.nomComplet = prenom + " " + nom;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNomComplet() {
        return nomComplet;
    }

    public void setNomComplet(String nomComplet) {
        this.nomComplet = nomComplet;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public int getAdresseId() {
        return adresseId;
    }

    public void setAdresseId(int adresseId) {
        this.adresseId = adresseId;
    }
}
