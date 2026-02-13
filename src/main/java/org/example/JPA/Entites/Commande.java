package org.example.JPA.Entites;

import jakarta.persistence.*;
import org.example.JPA.Enums.Statut;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "commandes")
public class Commande {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "jpa_seq_commandes")
    @SequenceGenerator(name = "jpa_seq_commandes", sequenceName = "seq_commandes", allocationSize = 1)
    private int id;

    @Column(name = "client_id")
    private int idClient;

    @Column(name = "livre_id")
    private int idLivre;

    @Column
    private int quantite;

    @Column(name = "date_commande")
    private LocalDate dateCommande;

    @Enumerated(EnumType.STRING)
    private Statut statut;
    @Column
    private BigDecimal total;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdClient() {
        return idClient;
    }

    public void setIdClient(int idClient) {
        this.idClient = idClient;
    }

    public int getIdLivre() {
        return idLivre;
    }

    public void setIdLivre(int idLivre) {
        this.idLivre = idLivre;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public LocalDate getDateCommande() {
        return dateCommande;
    }

    public void setDateCommande(LocalDate dateCommande) {
        this.dateCommande = dateCommande;
    }

    public Statut getStatut() {
        return statut;
    }

    public void setStatut(Statut statut) {
        this.statut = statut;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public Commande(BigDecimal total, Statut statut, LocalDate dateCommande, int quantite, int idLivre, int idClient) {
        this.total = total;
        this.statut = statut;
        this.dateCommande = dateCommande;
        this.quantite = quantite;
        this.idLivre = idLivre;
        this.idClient = idClient;
    }

    public Commande() {

    }
}
