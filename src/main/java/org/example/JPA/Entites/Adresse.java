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
@Table(name = "adresses")
public class Adresse {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "jpa_seq_adresses")
    @SequenceGenerator(name = "jpa_seq_adresses", sequenceName = "seq_adresses", allocationSize = 1)
    private int Id;
    @Column
    private String rue;
    @Column
    private String ville;
    @Column(name = "code_postal")
    private String codepostal;
    @Column
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

    @Override
    public String toString() {
        return "Adresse{" +
                "Id=" + Id +
                ", rue='" + rue + '\'' +
                ", ville='" + ville + '\'' +
                ", codepostal='" + codepostal + '\'' +
                ", pays='" + pays + '\'' +
                '}';
    }
}
