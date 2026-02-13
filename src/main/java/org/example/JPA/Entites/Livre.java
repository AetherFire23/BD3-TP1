package org.example.JPA.Entites;

import jakarta.persistence.*;
import org.example.JPA.Enums.Categorie;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="livres")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "jpa_seq_livres")
    @SequenceGenerator(name = "jpa_seq_livres", sequenceName = "seq_livres", allocationSize = 1)
    private int id;

    @Column(name="titre")
    private String titre;

    @Column(name="isbn")
    private String isbn;

    @Column(name="prix")
    private BigDecimal prix;

    @Column(name="nombre_pages")
    private int nombrePages;

    @Column(name="categorie")
    @Enumerated(EnumType.STRING)
    private Categorie categorie;

    @Column(name="disponible")
    private boolean disponible;


    public Livre(String titre, String isbn, BigDecimal prix, int nombrePages, Categorie categorie, boolean disponible) {
        this.titre = titre;
        this.isbn = isbn;
        this.prix = prix;
        this.nombrePages = nombrePages;
        this.categorie = categorie;
        this.disponible = disponible;
    }

    public Livre(){}

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    public int getNombrePages() {
        return nombrePages;
    }

    public void setNombrePages(int nombrePages) {
        this.nombrePages = nombrePages;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


}
