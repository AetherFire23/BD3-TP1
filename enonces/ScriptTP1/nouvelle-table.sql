CREATE TABLE MEILLEUR_VENDEUR
(
    id      NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    nom     VARCHAR2(50),
    annee   Number(4, 0),
    total   Number(10, 2),
    moyenne Number(10, 2)
);

SELECT * FROM ORDERS;