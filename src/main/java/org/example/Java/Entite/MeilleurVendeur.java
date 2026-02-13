package org.example.Java.Entite;

public class  MeilleurVendeur {
    private int id;
    private String nom;
    private String annee;
    private double total;
    private double moyenne;

    public MeilleurVendeur(String annee, double moyenne, String nom, double total) {
        this.annee = annee;
        this.id = id;
        this.moyenne = moyenne;
        this.nom = nom;
        this.total = total;
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

    public String getAnnee() {
        return annee;
    }

    public void setAnnee(String annee) {
        this.annee = annee;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getMoyenne() {
        return moyenne;
    }

    public void setMoyenne(double moyenne) {
        this.moyenne = moyenne;
    }

    @Override
    public String toString() {
        return "MeilleurVendeur{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", annee='" + annee + '\'' +
                ", total=" + total +
                ", moyenne=" + moyenne +
                '}';
    }
}
