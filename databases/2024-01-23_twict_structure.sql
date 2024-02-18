SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données : `twict`
--
DROP DATABASE IF EXISTS `twict`;
CREATE DATABASE IF NOT EXISTS `twict` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `twict`;

-- --------------------------------------------------------

--
-- Structure de la table `bankaccount`
--

DROP TABLE IF EXISTS `bankaccount`;
CREATE TABLE IF NOT EXISTS `bankaccount` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `idOwner` int UNSIGNED NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_BankAccount_Users_idx` (`idOwner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `financialtransaction`
--

DROP TABLE IF EXISTS `financialtransaction`;
CREATE TABLE IF NOT EXISTS `financialtransaction` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` double DEFAULT NULL,
  `idSender` int UNSIGNED NOT NULL,
  `idRecipient` int UNSIGNED NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_FinancialTransaction_BankAccount1_idx` (`idSender`),
  KEY `fk_FinancialTransaction_BankAccount2_idx` (`idRecipient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `transactionmessage`
--

DROP TABLE IF EXISTS `transactionmessage`;
CREATE TABLE IF NOT EXISTS `transactionmessage` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `idTransaction` int UNSIGNED NOT NULL,
  `idAuthor` int UNSIGNED NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_TransactionMessage_FinancialTransaction1_idx` (`idTransaction`),
  KEY `fk_TransactionMessage_Users1_idx` (`idAuthor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `mailAddress` varchar(255) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `mailAddress`, `password`, `createdAt`, `updatedAt`) VALUES
(1, 'Albert', 'Adam', 'albert.adam@twict.dev', '123456', '2023-02-15 00:00:00', '2023-02-15 11:50:22'),
(2, 'Béatrice', 'Blanc', 'beatrice.blanc@twict.dev', '', '2023-02-15 00:00:00', '2023-02-15 11:04:14'),
(3, 'Clément', 'Chevalier', 'clement.chevalier@twict.dev', NULL, '2023-02-15 00:00:00', '2023-02-15 00:00:00');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `bankaccount`
--
ALTER TABLE `bankaccount`
  ADD CONSTRAINT `fk_BankAccount_Users` FOREIGN KEY (`idOwner`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `financialtransaction`
--
ALTER TABLE `financialtransaction`
  ADD CONSTRAINT `fk_FinancialTransaction_BankAccount1` FOREIGN KEY (`idSender`) REFERENCES `bankaccount` (`id`),
  ADD CONSTRAINT `fk_FinancialTransaction_BankAccount2` FOREIGN KEY (`idRecipient`) REFERENCES `bankaccount` (`id`);

--
-- Contraintes pour la table `transactionmessage`
--
ALTER TABLE `transactionmessage`
  ADD CONSTRAINT `fk_TransactionMessage_FinancialTransaction1` FOREIGN KEY (`idTransaction`) REFERENCES `financialtransaction` (`id`),
  ADD CONSTRAINT `fk_TransactionMessage_Users1` FOREIGN KEY (`idAuthor`) REFERENCES `users` (`id`);
COMMIT;