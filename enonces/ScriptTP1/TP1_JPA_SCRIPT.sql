-- =================================================================
-- Script de création des tables pour le TP JPA - Librairie en ligne
-- (compatible Oracle 19c / 21c / 23c)
-- =================================================================

-- Suppression des tables existantes (dans l'ordre inverse des FK)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE commandes CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE livres CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE adresses CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE clients CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_clients';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_adresses';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_livres';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_commandes';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- =================================================================
-- 1. Clients
-- =================================================================
CREATE TABLE clients (
    id              NUMBER(12)      PRIMARY KEY,
    nom             VARCHAR2(50)    NOT NULL,
    prenom          VARCHAR2(50)    NOT NULL,
    email           VARCHAR2(100)   UNIQUE,
    date_naissance  DATE,
    genre           VARCHAR2(10),          -- HOMME / FEMME / AUTRE
    adresse_id      NUMBER(12)
);

-- =================================================================
-- 2. Adresses (relation 1:1 avec Client)
-- =================================================================
CREATE TABLE adresses (
    id              NUMBER(12)      PRIMARY KEY,
    rue             VARCHAR2(100),
    ville           VARCHAR2(50),
    code_postal     VARCHAR2(10),
    pays            VARCHAR2(50)
);

-- =================================================================
-- 3. Livres
-- =================================================================
CREATE TABLE livres (
    id              NUMBER(12)      PRIMARY KEY,
    titre           VARCHAR2(150)   NOT NULL,
    isbn            VARCHAR2(20),
    prix            NUMBER(10,2),
    nombre_pages    NUMBER(5),
    categorie       VARCHAR2(30),          -- ROMAN / SCIENCE_FICTION / ...
    disponible      NUMBER(1)       DEFAULT 1  -- 0/1 pour boolean
);

-- =================================================================
-- 4. Commandes
-- =================================================================
CREATE TABLE commandes (
    id              NUMBER(12)      PRIMARY KEY,
    client_id       NUMBER(12)      NOT NULL,
    livre_id        NUMBER(12)      NOT NULL,
    quantite        NUMBER(4)       NOT NULL,
    date_commande   DATE            NOT NULL,
    statut          VARCHAR2(20)    NOT NULL,   -- EN_ATTENTE / PAYEE / ...
    total           NUMBER(10,2)    NOT NULL
);

-- =================================================================
-- Contraintes d'intégrité référentielle
-- =================================================================

ALTER TABLE clients
    ADD CONSTRAINT fk_clients_adresse
    FOREIGN KEY (adresse_id) 
    REFERENCES adresses(id)
    ON DELETE SET NULL;   -- ou ON DELETE CASCADE selon votre choix

ALTER TABLE commandes
    ADD CONSTRAINT fk_commandes_client
    FOREIGN KEY (client_id) 
    REFERENCES clients(id)
    ON DELETE CASCADE;

ALTER TABLE commandes
    ADD CONSTRAINT fk_commandes_livre
    FOREIGN KEY (livre_id) 
    REFERENCES livres(id)
    ON DELETE CASCADE;

-- =================================================================
-- Séquences pour les identifiants (utilisées par JPA)
-- =================================================================

CREATE SEQUENCE seq_clients
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE seq_adresses
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE seq_livres
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE seq_commandes
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- =================================================================
-- Quelques commentaires utiles
-- =================================================================

COMMENT ON TABLE clients      IS 'Clients de la librairie en ligne';
COMMENT ON TABLE adresses     IS 'Adresses postales des clients (relation 1:1)';
COMMENT ON TABLE livres       IS 'Catalogue de livres disponibles';
COMMENT ON TABLE commandes    IS 'Commandes passées par les clients';

COMMENT ON COLUMN clients.genre      IS 'Genre du client : HOMME, FEMME, AUTRE';
COMMENT ON COLUMN livres.categorie   IS 'Catégorie du livre : ROMAN, SCIENCE_FICTION, POLICIER, JEUNESSE, BD, ...';
COMMENT ON COLUMN commandes.statut   IS 'Statut de la commande : EN_ATTENTE, PAYEE, EXPEDIEE, LIVREE, ANNULEE';



-- ============================================================
-- Données de test - Librairie en ligne (Oracle)
-- Ordre: adresses -> clients -> livres -> commandes
-- ============================================================

-- (Optionnel) accélère un peu les inserts en environnement dev
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- ============================================================
-- 1) ADRESSES (25 lignes)
-- ============================================================
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '12 rue des Érables', 'Québec', 'G1K 3A2', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '88 av. Cartier', 'Québec', 'G1R 2S1', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '120 boul. Charest O', 'Québec', 'G1K 1X4', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '45 rue Saint-Jean', 'Québec', 'G1R 1N6', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '9 rue de la Fabrique', 'Québec', 'G1R 3V7', 'Canada');

INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '312 rue Sherbrooke O', 'Montréal', 'H2X 1X4', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '21 rue Sainte-Catherine E', 'Montréal', 'H2X 1K8', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '700 boul. René-Lévesque O', 'Montréal', 'H3B 1X9', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '55 av. du Mont-Royal E', 'Montréal', 'H2T 1N8', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '18 rue Saint-Denis', 'Montréal', 'H2X 3J3', 'Canada');

INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '5 rue Wellington', 'Gatineau', 'J8X 2L3', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '77 rue King O', 'Sherbrooke', 'J1H 1P7', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '1400 boul. des Forges', 'Trois-Rivières', 'G8Z 1T7', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '66 rue Racine E', 'Saguenay', 'G7H 1P9', 'Canada');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '30 rue du Pont', 'Rimouski', 'G5L 5H6', 'Canada');

INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '3 rue de la Paix', 'Paris', '75002', 'France');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '19 rue Victor Hugo', 'Lyon', '69002', 'France');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '8 av. Jean Jaurès', 'Toulouse', '31000', 'France');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '42 rue de la République', 'Marseille', '13001', 'France');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '11 rue Nationale', 'Lille', '59000', 'France');

INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '1 Bahnhofstrasse', 'Zürich', '8001', 'Suisse');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '24 Königstrasse', 'Stuttgart', '70173', 'Allemagne');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '10 Gran Via', 'Madrid', '28013', 'Espagne');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '6 Via Roma', 'Torino', '10121', 'Italie');
INSERT INTO adresses (id, rue, ville, code_postal, pays) VALUES (seq_adresses.NEXTVAL, '2 Oxford Street', 'London', 'W1D 1BS', 'Royaume-Uni');

-- ============================================================
-- 2) CLIENTS (25 lignes) - adresse_id = 1..25
-- ============================================================
INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Tremblay', 'Alexandre', 'alexandre.tremblay@example.com', TO_DATE('1992-04-18','YYYY-MM-DD'), 'HOMME', 1);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Gagnon', 'Léa', 'lea.gagnon@example.com', TO_DATE('1996-09-07','YYYY-MM-DD'), 'FEMME', 2);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Roy', 'Émile', 'emile.roy@example.com', TO_DATE('1988-12-01','YYYY-MM-DD'), 'HOMME', 3);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Bouchard', 'Camille', 'camille.bouchard@example.com', TO_DATE('1999-01-22','YYYY-MM-DD'), 'FEMME', 4);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Côté', 'Noah', 'noah.cote@example.com', TO_DATE('1990-06-11','YYYY-MM-DD'), 'HOMME', 5);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Pelletier', 'Sarah', 'sarah.pelletier@example.com', TO_DATE('1994-08-30','YYYY-MM-DD'), 'FEMME', 6);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Lavoie', 'Thomas', 'thomas.lavoie@example.com', TO_DATE('1985-02-14','YYYY-MM-DD'), 'HOMME', 7);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Fortin', 'Chloé', 'chloe.fortin@example.com', TO_DATE('2000-05-05','YYYY-MM-DD'), 'FEMME', 8);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Girard', 'Maya', 'maya.girard@example.com', TO_DATE('1991-03-09','YYYY-MM-DD'), 'AUTRE', 9);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Lambert', 'Olivier', 'olivier.lambert@example.com', TO_DATE('1987-10-27','YYYY-MM-DD'), 'HOMME', 10);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Morin', 'Zoé', 'zoe.morin@example.com', TO_DATE('1993-07-16','YYYY-MM-DD'), 'FEMME', 11);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Gauthier', 'William', 'william.gauthier@example.com', TO_DATE('1998-11-03','YYYY-MM-DD'), 'HOMME', 12);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Ouellet', 'Alice', 'alice.ouellet@example.com', TO_DATE('1989-01-12','YYYY-MM-DD'), 'FEMME', 13);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Beaulieu', 'Lucas', 'lucas.beaulieu@example.com', TO_DATE('1997-04-29','YYYY-MM-DD'), 'HOMME', 14);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Leclerc', 'Jade', 'jade.leclerc@example.com', TO_DATE('1995-12-24','YYYY-MM-DD'), 'FEMME', 15);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Dubois', 'Nicolas', 'nicolas.dubois@example.com', TO_DATE('1986-09-18','YYYY-MM-DD'), 'HOMME', 16);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Moreau', 'Inès', 'ines.moreau@example.com', TO_DATE('1992-02-02','YYYY-MM-DD'), 'FEMME', 17);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Fournier', 'Hugo', 'hugo.fournier@example.com', TO_DATE('1990-09-09','YYYY-MM-DD'), 'HOMME', 18);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Bernard', 'Manon', 'manon.bernard@example.com', TO_DATE('1984-06-21','YYYY-MM-DD'), 'FEMME', 19);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Petit', 'Arthur', 'arthur.petit@example.com', TO_DATE('1999-10-10','YYYY-MM-DD'), 'HOMME', 20);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Müller', 'Lina', 'lina.muller@example.com', TO_DATE('1996-03-03','YYYY-MM-DD'), 'FEMME', 21);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Schneider', 'Jonas', 'jonas.schneider@example.com', TO_DATE('1988-08-08','YYYY-MM-DD'), 'HOMME', 22);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'García', 'Sofía', 'sofia.garcia@example.com', TO_DATE('1993-05-19','YYYY-MM-DD'), 'FEMME', 23);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Rossi', 'Marco', 'marco.rossi@example.com', TO_DATE('1987-01-07','YYYY-MM-DD'), 'HOMME', 24);

INSERT INTO clients (id, nom, prenom, email, date_naissance, genre, adresse_id)
VALUES (seq_clients.NEXTVAL, 'Smith', 'Emily', 'emily.smith@example.com', TO_DATE('1991-11-15','YYYY-MM-DD'), 'FEMME', 25);

-- ============================================================
-- 3) LIVRES (30 lignes)
-- ============================================================
INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Le Chant des Étoiles', '978-2-1234-0001-1', 19.90, 320, 'ROMAN', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'L''Archipel des Brumes', '978-2-1234-0002-8', 24.50, 410, 'ROMAN', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Chroniques de Neptune', '978-2-1234-0003-5', 21.00, 380, 'SCIENCE_FICTION', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Au-delà de la Nébuleuse', '978-2-1234-0004-2', 18.75, 290, 'SCIENCE_FICTION', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Enquête au Vieux-Port', '978-2-1234-0005-9', 16.95, 250, 'POLICIER', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Le Dossier Saphir', '978-2-1234-0006-6', 17.50, 270, 'POLICIER', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Histoires du Couchant', '978-2-1234-0007-3', 14.90, 180, 'JEUNESSE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Le Petit Robot Curieux', '978-2-1234-0008-0', 12.90, 96, 'JEUNESSE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'BD: Les Aventuriers du Nord', '978-2-1234-0009-7', 15.50, 64, 'BD', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'BD: Pixel et Dragon', '978-2-1234-0010-3', 16.20, 72, 'BD', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Cuisine Express', '978-2-1234-0011-0', 22.00, 200, 'CUISINE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Boulangerie Maison', '978-2-1234-0012-7', 26.90, 240, 'CUISINE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Python pour Débutants', '978-2-1234-0013-4', 29.90, 520, 'INFORMATIQUE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Java et JPA: Pratique', '978-2-1234-0014-1', 34.90, 610, 'INFORMATIQUE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Réseaux: Concepts Essentiels', '978-2-1234-0015-8', 31.50, 480, 'INFORMATIQUE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Histoire du Québec Moderne', '978-2-1234-0016-5', 27.90, 430, 'HISTOIRE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Mythes et Légendes', '978-2-1234-0017-2', 20.00, 350, 'FANTASY', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Le Royaume d''Ambre', '978-2-1234-0018-9', 23.90, 410, 'FANTASY', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Économie en 20 Leçons', '978-2-1234-0019-6', 25.00, 300, 'ESSAI', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Philo du Quotidien', '978-2-1234-0020-2', 18.00, 260, 'ESSAI', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Poèmes d''Hiver', '978-2-1234-0021-9', 13.50, 120, 'POESIE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Carnets de Voyage', '978-2-1234-0022-6', 21.90, 280, 'VOYAGE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Gestion du Temps', '978-2-1234-0023-3', 19.00, 210, 'DEV_PERSO', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Mindset et Motivation', '978-2-1234-0024-0', 20.50, 240, 'DEV_PERSO', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Initiation à la Photo', '978-2-1234-0025-7', 24.00, 260, 'ART', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Dessiner en 30 Jours', '978-2-1234-0026-4', 18.90, 190, 'ART', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Biologie: Les Bases', '978-2-1234-0027-1', 28.00, 540, 'SCIENCE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Astronomie Facile', '978-2-1234-0028-8', 26.00, 360, 'SCIENCE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Statistiques Sans Douleur', '978-2-1234-0029-5', 33.00, 620, 'SCIENCE', 1);

INSERT INTO livres (id, titre, isbn, prix, nombre_pages, categorie, disponible)
VALUES (seq_livres.NEXTVAL, 'Le Guide du Thé', '978-2-1234-0030-1', 17.90, 160, 'CUISINE', 0);

-- ============================================================
-- 4) COMMANDES (60 lignes)
-- Hypothèses:
--  - clients: id 1..25 (créés via seq_clients)
--  - livres:  id 1..30 (créés via seq_livres)
--  - total = prix * quantite (prix référencés ci-dessus)
-- Statuts: EN_ATTENTE, PAYEE, EXPEDIEE, LIVREE, ANNULEE
-- ============================================================

-- Pour simplifier: on référence directement les IDs 1..N,
-- puisque tes séquences démarrent à 1 et on vient d’insérer N lignes.

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 1, 1, 1, TO_DATE('2025-11-02','YYYY-MM-DD'), 'PAYEE', 19.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 2, 3, 2, TO_DATE('2025-11-05','YYYY-MM-DD'), 'EXPEDIEE', 42.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 3, 5, 1, TO_DATE('2025-11-08','YYYY-MM-DD'), 'LIVREE', 16.95);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 4, 14, 1, TO_DATE('2025-11-10','YYYY-MM-DD'), 'PAYEE', 34.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 5, 8, 3, TO_DATE('2025-11-10','YYYY-MM-DD'), 'EN_ATTENTE', 38.70);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 6, 10, 1, TO_DATE('2025-11-12','YYYY-MM-DD'), 'LIVREE', 16.20);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 7, 13, 1, TO_DATE('2025-11-13','YYYY-MM-DD'), 'PAYEE', 29.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 8, 2, 2, TO_DATE('2025-11-15','YYYY-MM-DD'), 'EXPEDIEE', 49.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 9, 7, 1, TO_DATE('2025-11-16','YYYY-MM-DD'), 'ANNULEE', 14.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 10, 16, 1, TO_DATE('2025-11-18','YYYY-MM-DD'), 'LIVREE', 27.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 11, 12, 1, TO_DATE('2025-11-18','YYYY-MM-DD'), 'PAYEE', 26.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 12, 6, 2, TO_DATE('2025-11-20','YYYY-MM-DD'), 'EXPEDIEE', 35.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 13, 9, 1, TO_DATE('2025-11-22','YYYY-MM-DD'), 'PAYEE', 15.50);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 14, 18, 1, TO_DATE('2025-11-23','YYYY-MM-DD'), 'EN_ATTENTE', 23.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 15, 20, 2, TO_DATE('2025-11-24','YYYY-MM-DD'), 'PAYEE', 36.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 16, 21, 1, TO_DATE('2025-11-25','YYYY-MM-DD'), 'EXPEDIEE', 13.50);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 17, 4, 1, TO_DATE('2025-11-26','YYYY-MM-DD'), 'LIVREE', 18.75);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 18, 15, 1, TO_DATE('2025-11-27','YYYY-MM-DD'), 'PAYEE', 31.50);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 19, 11, 1, TO_DATE('2025-11-28','YYYY-MM-DD'), 'EN_ATTENTE', 22.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 20, 22, 1, TO_DATE('2025-11-29','YYYY-MM-DD'), 'PAYEE', 21.90);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 21, 23, 2, TO_DATE('2025-11-30','YYYY-MM-DD'), 'EXPEDIEE', 38.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 22, 24, 1, TO_DATE('2025-12-01','YYYY-MM-DD'), 'LIVREE', 20.50);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 23, 25, 1, TO_DATE('2025-12-02','YYYY-MM-DD'), 'PAYEE', 24.00);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 24, 26, 2, TO_DATE('2025-12-03','YYYY-MM-DD'), 'PAYEE', 37.80);

INSERT INTO commandes (id, client_id, livre_id, quantite, date_commande, statut, total)
VALUES (seq_commandes.NEXTVAL, 25, 27, 1, TO_DATE('2025-12-03','YYYY-MM-DD'), 'EN_ATTENTE', 28.00);

-- 35 commandes supplémentaires (variées)
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 1, 14, 1, TO_DATE('2025-12-04','YYYY-MM-DD'), 'PAYEE', 34.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 2, 13, 1, TO_DATE('2025-12-05','YYYY-MM-DD'), 'LIVREE', 29.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 3, 12, 2, TO_DATE('2025-12-05','YYYY-MM-DD'), 'EXPEDIEE', 53.80);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 4, 1, 2, TO_DATE('2025-12-06','YYYY-MM-DD'), 'PAYEE', 39.80);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 5, 3, 1, TO_DATE('2025-12-06','YYYY-MM-DD'), 'ANNULEE', 21.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 6, 6, 1, TO_DATE('2025-12-07','YYYY-MM-DD'), 'PAYEE', 17.50);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 7, 7, 2, TO_DATE('2025-12-08','YYYY-MM-DD'), 'EXPEDIEE', 29.80);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 8, 8, 1, TO_DATE('2025-12-09','YYYY-MM-DD'), 'LIVREE', 12.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 9, 9, 3, TO_DATE('2025-12-09','YYYY-MM-DD'), 'PAYEE', 46.50);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 10, 10, 1, TO_DATE('2025-12-10','YYYY-MM-DD'), 'EN_ATTENTE', 16.20);

INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 11, 16, 1, TO_DATE('2025-12-10','YYYY-MM-DD'), 'PAYEE', 27.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 12, 18, 1, TO_DATE('2025-12-11','YYYY-MM-DD'), 'EXPEDIEE', 23.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 13, 20, 1, TO_DATE('2025-12-12','YYYY-MM-DD'), 'LIVREE', 18.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 14, 21, 2, TO_DATE('2025-12-12','YYYY-MM-DD'), 'PAYEE', 27.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 15, 22, 1, TO_DATE('2025-12-13','YYYY-MM-DD'), 'ANNULEE', 21.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 16, 23, 1, TO_DATE('2025-12-14','YYYY-MM-DD'), 'PAYEE', 19.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 17, 24, 2, TO_DATE('2025-12-14','YYYY-MM-DD'), 'EXPEDIEE', 41.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 18, 25, 1, TO_DATE('2025-12-15','YYYY-MM-DD'), 'LIVREE', 24.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 19, 26, 1, TO_DATE('2025-12-15','YYYY-MM-DD'), 'PAYEE', 18.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 20, 27, 2, TO_DATE('2025-12-16','YYYY-MM-DD'), 'EN_ATTENTE', 56.00);

INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 21, 28, 1, TO_DATE('2025-12-16','YYYY-MM-DD'), 'PAYEE', 26.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 22, 29, 1, TO_DATE('2025-12-17','YYYY-MM-DD'), 'EXPEDIEE', 33.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 23, 30, 1, TO_DATE('2025-12-18','YYYY-MM-DD'), 'LIVREE', 17.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 24, 2, 1, TO_DATE('2025-12-18','YYYY-MM-DD'), 'PAYEE', 24.50);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 25, 4, 3, TO_DATE('2025-12-19','YYYY-MM-DD'), 'PAYEE', 56.25);

INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 1, 5, 1, TO_DATE('2025-12-19','YYYY-MM-DD'), 'LIVREE', 16.95);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 2, 6, 1, TO_DATE('2025-12-20','YYYY-MM-DD'), 'EN_ATTENTE', 17.50);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 3, 11, 2, TO_DATE('2025-12-20','YYYY-MM-DD'), 'PAYEE', 44.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 4, 12, 1, TO_DATE('2025-12-21','YYYY-MM-DD'), 'EXPEDIEE', 26.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 5, 15, 1, TO_DATE('2025-12-22','YYYY-MM-DD'), 'PAYEE', 31.50);

INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 6, 16, 1, TO_DATE('2025-12-22','YYYY-MM-DD'), 'LIVREE', 27.90);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 7, 17, 1, TO_DATE('2025-12-23','YYYY-MM-DD'), 'ANNULEE', 20.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 8, 18, 2, TO_DATE('2025-12-24','YYYY-MM-DD'), 'PAYEE', 47.80);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 9, 19, 1, TO_DATE('2025-12-24','YYYY-MM-DD'), 'EXPEDIEE', 25.00);
INSERT INTO commandes VALUES (seq_commandes.NEXTVAL, 10, 14, 1, TO_DATE('2025-12-25','YYYY-MM-DD'), 'LIVREE', 34.90);

COMMIT;

