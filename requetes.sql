
-- =====AFFICHAGE pour les magasins===== --

-- Affichage du CA de IKEA Bordeaux sur l'année passée (2022)
SELECT * FROM liste_des_CA
WHERE NomMagasin LIKE '%Bordeaux%'
AND Annee = '2022'
ORDER BY NomMagasin
GO

-- Affichage du CA de IKEA Bordeaux, de Paris et de Marseille sur cette année (2023)
SELECT * FROM liste_des_CA
WHERE (
    NomMagasin LIKE '%Bordeaux%'
    OR NomMagasin LIKE '%Paris%'
    OR NomMagasin LIKE '%Marseille%'
) AND Annee = '2022'
ORDER BY NomMagasin
GO

-- Affichage des produits en stock dans le IKEA de Bordeaux avec leur emplacement
SELECT * FROM liste_des_stockages
WHERE Quantite > 0
AND NomMagasin LIKE '%Bordeaux%'
ORDER BY NomMagasin
GO



-- =====AFFICHAGE pour les produits===== --

-- Affichage simple des produits (avec prix de base)
SELECT produitID, Nom, Prix, Couleur FROM liste_des_produits
ORDER BY Nom
GO

-- Affichage des produits (avec reduction)
SELECT * FROM liste_des_reductions
ORDER BY NomProduit
GO

-- Affichage détaillé des produits
SELECT * FROM liste_des_produits
ORDER BY Nom
GO



-- =====AFFICHAGE pour les clients===== --

-- Affichage des factures
SELECT * FROM liste_des_factures
ORDER BY NomCLient
GO

-- Affichage des devis
SELECT * FROM liste_des_devis
ORDER BY NomCLient
GO

-- Affichage des clients particuliers (fidelises)
SELECT * FROM liste_des_fidelises
ORDER BY NomClient
GO



-- =====AFFICHAGE pour les personnels===== --
SELECT * FROM liste_des_personnels
ORDER BY NomPersonnel
GO

-- =====AFFICHAGE pour les services===== --
SELECT * FROM liste_des_services
ORDER BY Service
GO

-- =====BONUS : AFFICHAGE des clients éligibles aux offres===== --
SELECT * FROM liste_des_clients_eligible_a_une_offre
ORDER BY NomClient
GO