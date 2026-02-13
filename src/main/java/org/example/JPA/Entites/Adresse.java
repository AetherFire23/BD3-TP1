package org.example.JPA.Entites;


//CREATE TABLE ADRESSE
//        (
//                ID NUMBER PRIMARY KEY,
//                RUE VARCHAR2(50),
//VILLE VARCHAR2(50),
//CODEPOSTAL VARCHAR2(50),
//PAYS VARCHAR2(50)
//);

import jakarta.persistence.*;

@Entity
public class Adresse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Id;

    private String rue;
    private String ville;
    private String codepostal;
    private String pays;

    public Adresse() {
    }

    public Adresse(String rue, String ville, String codepostal, String pays) {
        this.rue = rue;
        this.ville = ville;
        this.codepostal = codepostal;
        this.pays = pays;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    public String getRue() {
        return rue;
    }

    public void setRue(String rue) {
        this.rue = rue;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getCodepostal() {
        return codepostal;
    }

    public void setCodepostal(String codepostal) {
        this.codepostal = codepostal;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }
}
