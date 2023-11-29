CREATE TABLE Magasin(
   magasinID INT NOT NULL IDENTITY(1,1),
   nom VARCHAR(50),
   ville VARCHAR(50),
   adresse VARCHAR(255),
   CP CHAR(5),
   pays VARCHAR(50),
   CONSTRAINT pk_magasin PRIMARY KEY(magasinID)
)
GO

CREATE TABLE Personnel(
   personnelID INT NOT NULL IDENTITY(1,1),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   dateNaissance DATE,
   genre VARCHAR(50),
   telephone CHAR(10),
   email VARCHAR(360),
   anciennete DATE,
   niveau VARCHAR(50),
   typeEmploi VARCHAR(50),
   contrat VARCHAR(50),
   salaireMensuel DECIMAL(10,2),
   magasinID INT NOT NULL,
   CONSTRAINT pk_personnel PRIMARY KEY(personnelID),
   CONSTRAINT fk_personnel_magasin FOREIGN KEY(magasinID) REFERENCES Magasin(magasinID)
)
GO

CREATE TABLE Client(
   clientID INT NOT NULL IDENTITY(1,1),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   genre VARCHAR(50),
   dateNaissance DATE,
   adresse VARCHAR(255),
   ville VARCHAR(50),
   CP CHAR(5),
   telephone CHAR(10),
   email VARCHAR(360),
   CONSTRAINT pk_client PRIMARY KEY(clientID)
)
GO

CREATE TABLE FidelisationClient(
   numeroAdherent CHAR(22) NOT NULL,
   pointsFidelite INT,
   statutFidelite VARCHAR(50),
   clientID INT,
   CONSTRAINT pk_fidelisation PRIMARY KEY(numeroAdherent),
   CONSTRAINT fk_fidelisation_client FOREIGN KEY(clientID) REFERENCES Client(clientID)
)
GO

CREATE TABLE Facture(
   factureID INT NOT NULL IDENTITY(1,1),
   chemin CHAR(20),
   clientID INT NOT NULL,
   CONSTRAINT pk_facture PRIMARY KEY(factureID),
   CONSTRAINT fk_facture_client FOREIGN KEY(clientID) REFERENCES Client(clientID)
)
GO

CREATE TABLE Devis(
   devisID INT NOT NULL IDENTITY(1,1),
   chemin CHAR(20) NOT NULL,
   clientID INT NOT NULL,
   CONSTRAINT pk_devis PRIMARY KEY(devisID),
   CONSTRAINT fk_devis_client FOREIGN KEY(clientID) REFERENCES Client(clientID)
)
GO

CREATE TABLE Service(
   serviceID INT NOT NULL IDENTITY(1,1),
   libelle VARCHAR(50),
   CONSTRAINT pk_service PRIMARY KEY(serviceID)
)
GO

CREATE TABLE Newsletter(
   newsletterID INT NOT NULL IDENTITY(1,1),
   libelle VARCHAR(50),
   categorie VARCHAR(50),
   dateEnvoi DATE,
   CONSTRAINT pk_newsletter PRIMARY KEY(newsletterID)
)
GO

CREATE TABLE Couleur(
   couleurId INT NOT NULL IDENTITY(1,1),
   libelle VARCHAR(50),
   CONSTRAINT pk_couleur PRIMARY KEY(couleurId)
)
GO

CREATE TABLE ChiffreAffaires(
   chiffreAffairesID INT NOT NULL IDENTITY(1,1),
   montant DECIMAL(15, 2),
   annee DATE,
   magasinID INT NOT NULL,
   CONSTRAINT pk_chiffreAffaires PRIMARY KEY(chiffreAffairesID),
   CONSTRAINT fk_chiffreAffaires_magasin FOREIGN KEY(magasinID) REFERENCES Magasin(magasinID)
)
GO

CREATE TABLE Produit(
   produitID INT NOT NULL IDENTITY(1,1),
   nom VARCHAR(50),
   prix DECIMAL(10,2),
   poids DECIMAL(10,2),
   bonASavoir TEXT,
   description TEXT,
   lesPlus TEXT,
   conseilEntretien TEXT,
   designer VARCHAR(50),
   couleurID INT NOT NULL,
   CONSTRAINT pk_produit PRIMARY KEY(produitID),
   CONSTRAINT fk_produit_couleur FOREIGN KEY(couleurID) REFERENCES Couleur(couleurID)
)
GO

CREATE TABLE Colis(
   colisID INT NOT NULL IDENTITY(1,1),
   clientID INT NOT NULL,
   produitID INT NOT NULL,
   CONSTRAINT pk_colis PRIMARY KEY(colisID),
   CONSTRAINT fk_colis_client FOREIGN KEY(clientID) REFERENCES Client(clientID),
   CONSTRAINT fk_colis_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID)
)
GO

CREATE TABLE DimensionsProduit(
   dimensionsProduitID INT NOT NULL IDENTITY(1,1),
   libelle VARCHAR(50),
   dimension DECIMAL(10,2),
   produitID INT NOT NULL,
   CONSTRAINT pk_dimensionsProduit PRIMARY KEY(dimensionsProduitID),
   CONSTRAINT fk_dimensionsProduits_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID)
)
GO

CREATE TABLE DimensionsColis(
   dimensionsColisID INT NOT NULL IDENTITY(1,1),
   libelle VARCHAR(50),
   dimension DECIMAL(10,2),
   colisID INT NOT NULL,
   CONSTRAINT pk_dimensionsColis PRIMARY KEY(dimensionsColisID),
   CONSTRAINT fk_dimensionsColis_colis FOREIGN KEY(colisID) REFERENCES Colis(colisID)
)
GO

CREATE TABLE Image(
   imageId INT NOT NULL IDENTITY(1,1),
   chemin CHAR(20),
   produitID INT,
   CONSTRAINT pk_image PRIMARY KEY(imageId),
   CONSTRAINT fk_image_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID)
)
GO

CREATE TABLE Offre(
   offreID INT NOT NULL IDENTITY(1,1),
   dateDebut DATE,
   dateFin DATE,
   libelle VARCHAR(255),
   categorie VARCHAR(255),
   dateEnvoi DATE,
   CONSTRAINT pk_offre PRIMARY KEY(offreID)
)
GO

CREATE TABLE Reduction(
   reductionID INT NOT NULL IDENTITY(1,1),
   produitID INT NOT NULL,
   offreID INT NOT NULL,
   nouveauPrix DECIMAL(10,2),
   CONSTRAINT pk_reduction PRIMARY KEY(reductionID),
   CONSTRAINT fk_reduction_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID),
   CONSTRAINT fk_reduction_offre FOREIGN KEY(offreID) REFERENCES Offre(offreID)
)
GO

CREATE TABLE stockage(
   stockageID INT NOT NULL IDENTITY(1,1),
   numAllee INT,
   numPlace INT,
   quantite INT,
   magasinID INT NOT NULL,
   produitID INT NOT NULL,
   CONSTRAINT pk_stockage PRIMARY KEY(stockageID),
   CONSTRAINT fk_stockage_magasin FOREIGN KEY(magasinID) REFERENCES Magasin(magasinID),
   CONSTRAINT fk_stockage_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID)
)
GO

CREATE TABLE Acheter(
   achatID INT NOT NULL IDENTITY(1,1),
   dateAchat DATE,
   produitID INT NOT NULL,
   clientID INT NOT NULL,
   CONSTRAINT pk_produitClient PRIMARY KEY(achatID),
   CONSTRAINT fk_produitClient_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID),
   CONSTRAINT fk_produitClient_client FOREIGN KEY(clientID) REFERENCES Client(clientID)
)
GO

CREATE TABLE ProposerService(
   proposerServiceIP INT NOT NULL IDENTITY(1,1),
   produitID INT NOT NULL,
   serviceID INT NOT NULL,
   CONSTRAINT pk_produitService PRIMARY KEY(proposerServiceIP),
   CONSTRAINT fk_produitService_produit FOREIGN KEY(produitID) REFERENCES Produit(produitID),
   CONSTRAINT fk_produitService_service FOREIGN KEY(serviceID) REFERENCES Service(serviceID)
)
GO

CREATE TABLE AbonnerAuxNewsletter(
   abonneID INT NOT NULL IDENTITY(1,1),
   clientID INT NOT NULL,
   newsletterID INT NOT NULL,
   CONSTRAINT pk_abonnementNewsletter PRIMARY KEY(abonneID),
   CONSTRAINT fk_abonnementNewsletter_client FOREIGN KEY(clientID) REFERENCES Client(clientID),
   CONSTRAINT fk_abonnementNewsletter_newsletter FOREIGN KEY(newsletterID) REFERENCES Newsletter(newsletterID)
)
GO

CREATE TABLE Elligible(
   elligibiliteID INT NOT NULL IDENTITY(1,1),
   numeroAdherent CHAR(22) NOT NULL,
   offreID INT NOT NULL,
   CONSTRAINT pk_elligible PRIMARY KEY(elligibiliteID),
   CONSTRAINT fk_elligible_fidelisationClient FOREIGN KEY(numeroAdherent) REFERENCES FidelisationClient(numeroAdherent),
   CONSTRAINT fk_elligible_offre FOREIGN KEY(offreID) REFERENCES Offre(offreID)
)
GO