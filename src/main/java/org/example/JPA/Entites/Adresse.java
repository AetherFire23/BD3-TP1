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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_seq")
    @SequenceGenerator( name = "user_seq", sequenceName = "user_sequence", allocationSize = 1 )
    private int Id;

    private String rue;
    private String ville;
    private String codepostal;
    private String pays;


    public Adresse(String rue, String ville, String codepostal, String pays) {

        this.rue = rue;
        this.ville = ville;
        this.codepostal = codepostal;
        this.pays = pays;
    }
}
