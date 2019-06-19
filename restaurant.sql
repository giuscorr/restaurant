DROP DATABASE IF EXISTS restaurant;
CREATE DATABASE restaurant;
USE restaurant;

/*Creazione tabella luogo e ristorante, da completare per le altre tabelle*/



--
-- Struttura della tabella `Luogo`
--

CREATE TABLE `Luogo` (
  `IDLuogo` bigint(9) PRIMARY KEY AUTO_INCREMENT,
  `Comune` varchar(40) NOT NULL,
  `Provincia` char(2) NOT NULL,
  `Via` varchar(40) NOT NULL,
  `N_Civico` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `Luogo`
--

INSERT INTO `Luogo` (`Comune`, `Provincia`, `Via`, `N_Civico`) VALUES
('L\'Aquila', 'AQ', 'Germania', '4'),
('Pescara', 'PE', 'Rome', '14/a');

-- --------------------------------------------------------

--
-- Struttura della tabella `Ristorante`
--

CREATE TABLE `Ristorante` (
  `Nome` varchar(30) NOT NULL,
  `Cellulare` varchar(13) NOT NULL,
  `TelefonoFisso` varchar(13) NOT NULL,
  `Proprietario` varchar(80) NOT NULL,
  `GiudizioComplessivo` float NOT NULL,
  `StatoApertura` bit(1) NOT NULL,
  `GiorniDiApertura` longtext NOT NULL,
  `AvvisiAttivi` bit(1) NOT NULL,
  `ChiusoStraordinario` bit(1) NOT NULL,
  `PromozioniAttive` text NOT NULL,
  `EntitaScontoBase` float NOT NULL,
  `EntitaScontoAPunti` float NOT NULL,
  `IDLuogo` bigint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struttura della tabella `Utente`
--

CREATE TABLE `Utente` (
    `Nome` varchar(40) NOT NULL,
    `Cognome` varchar(40) NOT NULL,
    `NomeUtente` varchar(20) NOT NULL,
    `Email` varchar(255) UNIQUE NOT NULL,
    `Telefono` varchar(13) NOT NULL,
    `Password` varchar(40) NOT NULL,
    `Punti` smallint(5),
    `OrdiniCumulati` smallint(5),
    `DataUltimoOrdine` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struttura della tabella `Ordine`
--

CREATE TABLE `Ordine`
(
    `IDOrdine`         bigint(9) PRIMARY KEY AUTO_INCREMENT,
    `DataOrdinazione`  datetime    NOT NULL,
    `DataConsegna`     datetime    NOT NULL,
    `Nota`             varchar(600),
    `PrezzoTotale`     float       NOT NULL,
    `TipoPagamento`    varchar(8)  NOT NULL,
    `StatoOrdine`      varchar(10) NOT NULL,
    `PuntiUsati`       smallint(6) NOT NULL,
    `TelefonoConsegna` varchar(13),
    `NomeUtente`       varchar(20) NOT NULL,
    `IDLuogo`          bigint(9)   NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

)

--
-- Indici per le tabelle `Ristorante`
--
ALTER TABLE `Ristorante`
  ADD PRIMARY KEY (`Nome`),
  ADD KEY `ha_sede_in` (`IDLuogo`);

--
-- Limiti per la tabella `Ristorante`
--
ALTER TABLE `Ristorante`
  ADD CONSTRAINT `ha_sede_in` FOREIGN KEY (`IDLuogo`) REFERENCES `Luogo` (`IDLuogo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Indici per le tabelle `Utente`
--

ALTER TABLE `Utente`
    ADD PRIMARY KEY (`NomeUtente`);

--
-- Indici per le tabelle `Ordine`
--
ALTER TABLE `Ordine`
    ADD KEY `ha effettuato` (`NomeUtente`),
    ADD KEY `va consegnato in` (`IDLuogo`);

--
-- Limiti per la tabella `Ordine`
--

ALTER TABLE `Ordine`
    ADD CONSTRAINT `ha effettuato` FOREIGN KEY (`NomeUtente`) REFERENCES `Utente` (`NomeUtente`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `va consegnato in` FOREIGN KEY (`IDLuogo`) REFERENCES `Luogo` (`IDLuogo`) ON DELETE CASCADE ON UPDATE CASCADE;

