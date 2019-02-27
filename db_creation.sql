
###################################################
###############Database NewFashion#################
###################################################


###################################################
CREATE DATABASE newfashion;########################						
###################################################


###################TABLE creation###################





CREATE TABLE Linee (
    categoria      CHAR(50) NOT NULL,
PRIMARY KEY (categoria));


CREATE TABLE Carrello (
    codice_carrello INT NOT NULL UNIQUE,
PRIMARY KEY (codice_carrello));


CREATE TABLE Utenti (
    nome           CHAR(50) NOT NULL,
    cognome        CHAR(50) NOT NULL,
    data_di_nascita DATE NULL,
    indirizzo      CHAR(50) NOT NULL,
    citta          CHAR(50) NOT NULL,
    nazione        CHAR(50) NOT NULL,
    email          CHAR(50) NOT NULL UNIQUE,
    password       CHAR(50) NOT NULL,
    linea_preferita CHAR(50) NOT NULL,
    capo_preferito CHAR(50) NOT NULL,
    colore_sfondo  CHAR(50) NOT NULL,
    colore_elementi CHAR(50) NOT NULL,
    codice_carrello INT NOT NULL,
PRIMARY KEY (email),
CONSTRAINT fk_Utenti FOREIGN KEY (codice_carrello)
    REFERENCES Carrello (codice_carrello)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
	
	
CREATE TABLE Ordini (
    codice_ordine  INT NOT NULL UNIQUE,
    prezzo_totale  FLOAT(20) NOT NULL,
    metodo_di_pagamento CHAR(50) NOT NULL,
    codice_spedizione INT NOT NULL UNIQUE,
    email          CHAR(50) NOT NULL,
PRIMARY KEY (codice_ordine),
CONSTRAINT fk_Ordini FOREIGN KEY (email)
    REFERENCES Utenti (email)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE Prodotti (
    codice_prodotto INT NOT NULL UNIQUE,
    nome           CHAR(50) NOT NULL,
    colore         CHAR(50) NOT NULL,
    prezzo         FLOAT(20) NOT NULL,
    immagine       CHAR(150) NOT NULL UNIQUE,
    categoria      CHAR(50) NOT NULL,
PRIMARY KEY (codice_prodotto),
CONSTRAINT fk_Prodotti FOREIGN KEY (categoria)
    REFERENCES Linee (categoria)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE ordini_prodotti (
    codice_ordine  INT NOT NULL,
    codice_prodotto INT NOT NULL,
    taglia         CHAR(10) NOT NULL,
    quantita       INT NOT NULL,
PRIMARY KEY (codice_ordine,codice_prodotto,taglia),
CONSTRAINT fk_ordini_prodotti FOREIGN KEY (codice_ordine)
    REFERENCES Ordini (codice_ordine)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT fk_ordini_prodotti2 FOREIGN KEY (codice_prodotto)
    REFERENCES Prodotti (codice_prodotto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE Sfilate (
    data           DATE NOT NULL,
    ora            TIME NOT NULL,
    luogo          CHAR(50) NOT NULL,
    categoria      CHAR(50) NOT NULL,
PRIMARY KEY (data,luogo),
CONSTRAINT fk_Sfilate FOREIGN KEY (categoria)
    REFERENCES Linee (categoria)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE Dettagli (
    codice         INT NOT NULL,
    taglia         CHAR(10) NOT NULL,
    quantita       INT NOT NULL,
    codice_prodotto INT NOT NULL,
PRIMARY KEY (codice,taglia),
CONSTRAINT fk_Dettagli FOREIGN KEY (codice_prodotto)
    REFERENCES Prodotti (codice_prodotto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE carrello_prodotti (
    codice_carrello INT NOT NULL,
    codice_prodotto INT NOT NULL,
    taglia_scelta  CHAR(10) NOT NULL,
    quantita_scelta INT NOT NULL,
PRIMARY KEY (codice_carrello,codice_prodotto,taglia_scelta),
CONSTRAINT fk_carrello_prodotti FOREIGN KEY (codice_carrello)
    REFERENCES Carrello (codice_carrello)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT fk_carrello_prodotti2 FOREIGN KEY (codice_prodotto)
    REFERENCES Prodotti (codice_prodotto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
