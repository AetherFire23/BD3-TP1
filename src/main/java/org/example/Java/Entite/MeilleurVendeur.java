package org.example.Java.Entite;

public class MeilleurVendeur {
    private int id;
    private String nom;
    private String annee;
    private double total;
    private double moyenne;

    public MeilleurVendeur(String annee, int id, double moyenne, String nom, double total) {
        this.annee = annee;
        this.id = id;
        this.moyenne = moyenne;
        this.nom = nom;
        this.total = total;
    }
}
