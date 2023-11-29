-- Ce fichier permet de créer ce qu'on appelle des VIEWs
-- Entre autre cela permet grâce à une simple requête,
-- d'afficher cette "table" plus facilement
-- Aller voir le fichier requetes.sql pour comprendre l'utilité

-- Permettre de lister tous les clients
CREATE VIEW liste_des_clients AS
    SELECT
        clientID,
        CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS NomClient,
        genre AS Genre,
        dateNaissance AS DateDeNaissance,
        DATEDIFF(YEAR, dateNaissance, GETDATE()) AS Age,
        adresse AS Adresse,
        ville AS Ville,
        CP AS CodePostal,
        telephone AS Telephone,
        email AS Email
    FROM Client
GO

-- Permettre de lister tous les produits existants dans la BDD
CREATE VIEW liste_des_produits AS
    SELECT
        produitID,
        nom AS Nom,
        prix AS Prix,
        poids AS Poids,
		bonASavoir AS BonASavoir,
		description AS Description,
		lesPlus AS LesPlusASavoir,
		conseilEntretien AS ConseilsEntretien,
		designer AS Designer,
		Couleur.libelle AS Couleur
    FROM Produit
	INNER JOIN Couleur ON Couleur.couleurID = Produit.couleurID
GO

-- Permettre de lister tous les magasins de France
CREATE VIEW liste_des_magasins AS
	SELECT
		magasinID,
		nom AS Nom,
		ville AS Ville,
		adresse AS Adresse,
		CP AS CodePostal,
		pays AS Pays
	FROM Magasin
GO

-- Permettre de lister tous les personnels et de voir dans quel magasin travaille l'employé
CREATE VIEW liste_des_personnels AS
    SELECT
        personnelID,
        CONCAT(UPPER(Personnel.nom), ' ', CONCAT(UPPER(LEFT(Personnel.prenom, 1)), RIGHT(Personnel.prenom, LEN(Personnel.prenom)-1))) AS NomPersonnel,
        dateNaissance AS DateDeNaissance,
        DATEDIFF(YEAR, dateNaissance, GETDATE()) AS Age,
		genre AS Genre,
        telephone AS Telephone,
		email AS Email,
		anciennete AS Anciennete,
		niveau AS Niveau,
		typeEmploi AS TypeEmploi,
		contrat AS Contrat,
		salaireMensuel AS SalaireAnnuel,
        Magasin.nom AS NomMagasin
    FROM Personnel
    INNER JOIN Magasin ON Magasin.magasinID = Personnel.magasinID
GO

-- Permettre de lister toutes les livraisons faites pour les clients
CREATE VIEW liste_des_livraisons AS
    SELECT
        colisID,
		CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS ClientLivré,
        Produit.nom AS ProduitLivré
    FROM Colis
    INNER JOIN Client ON Client.clientID = Colis.clientID
    INNER JOIN Produit ON Produit.produitID = Colis.produitID
GO

-- Permettre de lister toutes les factures des clients
CREATE VIEW liste_des_factures AS
    SELECT
		CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS NomClient,
		Facture.chemin AS Path,
		Facture.factureID
    FROM Facture
    INNER JOIN Client ON Client.clientID = Facture.clientID
GO

-- Permettre de lister tous les devis réalisés par les clients
CREATE VIEW liste_des_devis AS
    SELECT
		CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS NomClient,
		Devis.chemin AS Path,
		Devis.devisID
    FROM Devis
    INNER JOIN Client ON Client.clientID = Devis.clientID
GO

-- Permettre de lister tous les achats faits par les clients
CREATE VIEW liste_des_achats AS
    SELECT
		CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS NomClient,
		Produit.nom AS ProduitAcheté,
		dateAchat AS DateAchat
    FROM Acheter
    INNER JOIN Client ON Client.clientID = Acheter.clientID
	INNER JOIN Produit ON Produit.produitID = Acheter.produitID
GO

-- Permettre de lister tous les clients fidélisés avec la carte IKEA
CREATE VIEW liste_des_fidelises AS
    SELECT
        CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS NomClient,
		numeroAdherent AS NumeroAdherent,
		pointsFidelite AS PointsDeFidelite,
		statutFidelite AS StatutFidelite
    FROM FidelisationClient
    INNER JOIN Client ON Client.clientID = FidelisationClient.clientID
GO

--  Permettre de lister tous les stockages des produits dans tous les magasins de France
CREATE VIEW liste_des_stockages AS
    SELECT
		Magasin.nom AS NomMagasin,
		Produit.nom AS NomProduit,
		numAllee AS NumeroAllee,
		numPlace AS NumeroPlace,
		quantite AS Quantite
	FROM Stockage
    INNER JOIN Magasin ON Magasin.magasinID = Stockage.magasinID
	INNER JOIN Produit ON Produit.produitID = Stockage.produitID
GO

-- Permettre de lister toutes les offres
CREATE VIEW liste_des_offres AS
	SELECT
		offreID,
		dateDebut AS DateDuDebut,
		dateFin AS DateDeFin,
		libelle AS Libelle,
		categorie AS Categorie,
		dateEnvoi AS DateEnvoiOffre
	FROM Offre
GO

-- Permettre de lister tous les clients éligibles à une réduction d'achat si ils sont abonnés
CREATE VIEW liste_des_clients_eligible_a_une_offre AS
    SELECT
		FidelisationClient.numeroAdherent AS NumeroAdherent,
		CONCAT(UPPER(Client.nom), ' ', CONCAT(UPPER(LEFT(Client.prenom, 1)), RIGHT(Client.prenom, LEN(Client.prenom)-1))) AS NomClient,
		Produit.nom AS NomProduit,
        Produit.prix AS PrixDeBase,
		Reduction.nouveauPrix AS NouveauPrix,
		dateDebut AS DateDuDebut,
		dateFin AS DateDeFin,
		libelle AS Libelle,
		categorie AS Categorie,
		dateEnvoi AS DateEnvoiOffre
	FROM Offre
	INNER JOIN Reduction ON Reduction.offreID = Offre.offreID
	INNER JOIN Produit ON Produit.produitID = Reduction.produitID
    INNER JOIN Elligible ON Elligible.offreID = Offre.offreID
	INNER JOIN FidelisationClient ON FidelisationClient.numeroAdherent = Elligible.numeroAdherent
	INNER JOIN Client ON Client.clientID = FidelisationClient.clientID
    WHERE Produit.prix > Reduction.nouveauPrix
GO

-- Permettre de lister tous les chiffres d'affaires des magasins
CREATE VIEW liste_des_CA AS
    SELECT
		Magasin.nom AS NomMagasin,
		ChiffreAffaires.montant AS Montant,
		YEAR(annee) AS Annee
    FROM ChiffreAffaires
    INNER JOIN Magasin ON Magasin.magasinID = ChiffreAffaires.magasinID
GO

--  Permettre de lister toutes les réductions des produits
CREATE VIEW liste_des_reductions AS
    SELECT
		Reduction.produitID AS ProduitID,
		Produit.nom AS NomProduit,
		Produit.prix AS PrixDeBase,
		Reduction.nouveauPrix AS NouveauPrix
	FROM Reduction
	INNER JOIN Produit ON Produit.produitID = Reduction.produitID
	WHERE Produit.prix > Reduction.nouveauPrix
GO

-- Permettre de lister tous les services
CREATE VIEW liste_des_services AS
    SELECT
		serviceID AS ServiceID,
		libelle AS Service
    FROM Service
GO