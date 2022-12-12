-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 26/11/2021 às 16:06
-- Versão do servidor: 5.7.36-log-cll-lve
-- Versão do PHP: 7.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ccompj_teste`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `config_publicgoods`
--

CREATE TABLE `config_publicgoods` (
  `id` int(11) NOT NULL,
  `adminId` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `publicConfig` tinyint(1) NOT NULL,
  `publicData` tinyint(1) NOT NULL,
  `key` varchar(30) DEFAULT NULL,
  `onlyContribution` tinyint(1) NOT NULL,
  `maxTokens` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `factor` int(11) DEFAULT NULL,
  `maxTrys` int(11) DEFAULT NULL,
  `realPlayers` int(11) DEFAULT NULL,
  `notRealPlayers` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `descri` varchar(200) DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `showRounds` tinyint(1) NOT NULL,
  `timeDistribution` int(11) NOT NULL,
  `timeElection` int(11) NOT NULL,
  `contributionsVariation` int(11) NOT NULL,
  `distributionVariation` int(11) NOT NULL,
  `unfairDistribution` int(11) NOT NULL,
  `stable` int(11) NOT NULL,
  `limitVotes` int(11) NOT NULL,
  `waitingRounds` int(11) NOT NULL,
  `electionRule` varchar(60) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Despejando dados para a tabela `config_publicgoods`
--

INSERT INTO `config_publicgoods` (`id`, `adminId`, `publicConfig`, `publicData`, `key`, `onlyContribution`, `maxTokens`, `time`, `factor`, `maxTrys`, `realPlayers`, `notRealPlayers`, `name`, `descri`, `start`, `end`, `showRounds`, `timeDistribution`, `timeElection`, `contributionsVariation`, `distributionVariation`, `unfairDistribution`, `stable`, `limitVotes`, `waitingRounds`, `electionRule`, `active`) VALUES
(1, '0', 0, 0, 'PGteste', 0, 10, 10, 3, 30, 0, 5, '3', 'Jogo Padrão9', '2020-03-21 07:30:00', '2020-10-01 17:07:03', 0, 10, 10, 2, 10, 20, 5, 4, 3, 'recurring election disabled', 0),
(2, '0', 1, 1, 'PG1', 1, 10, 10, 3, 5, 0, 5, 'intermittent election disabled', 'Jogo Padrão 1', '2020-03-21 07:30:00', '2020-09-18 16:10:34', 0, 10, 10, 2, 10, 20, 5, 4, 3, 'intermittent election disabled', 0),
(3, '0', 1, 1, 'PG2', 0, 10, 10, 3, 30, 0, 5, 'intermittent election enabled', 'Jogo Padrão 2', '2020-03-21 07:30:00', '2020-08-01 17:07:03', 0, 10, 10, 2, 10, 20, 5, 4, 3, 'intermittent election enabled', 0),
(4, 'usuario', 1, 1, 'PG4', 0, 10, 10, 3, 30, 0, 5, 'recurring election enabled', 'Jogo Padrão 4', '2020-03-21 00:00:01', '2020-10-01 23:59:59', 0, 10, 10, 2, 10, 20, 5, 4, 3, 'recurring election enabled', 0),

-- --------------------------------------------------------

--
-- Estrutura para tabela `public_goods_rounds`
--

CREATE TABLE `public_goods_rounds` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `round` int(11) DEFAULT NULL,
  `investment` int(11) DEFAULT NULL,
  `positionToken` int(11) DEFAULT NULL,
  `earning` int(11) DEFAULT NULL,
  `rib` int(11) DEFAULT NULL,
  `wallet` int(11) DEFAULT NULL,
  `distribution` tinyint(1) DEFAULT NULL,
  `suspended` tinyint(1) DEFAULT NULL,
  `electionCount` int(11) DEFAULT NULL,
  `votes` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `time_taken_round_pg`
--

CREATE TABLE `time_taken_round_pg` (
  `id` int(11) NOT NULL,
  `drag_token` time DEFAULT NULL,
  `distribution` time DEFAULT NULL,
  `election` time DEFAULT NULL,
  `round` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `educationLevel` varchar(100) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `cours` varchar(100) DEFAULT NULL,
  `experiment` varchar(30) CHARACTER SET latin1 NOT NULL,
  `device` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Índices para tabelas despejadas
--


-- Índices de tabela `config_publicgoods`
--
ALTER TABLE `config_publicgoods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),

--
-- Índices de tabela `public_goods_rounds`
--
ALTER TABLE `public_goods_rounds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `public_goods_rounds` (`userId`);

--
-- Índices de tabela `time_taken_round_pg`
--
ALTER TABLE `time_taken_round_pg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `time_taken_tutorial_pg`
--
ALTER TABLE `time_taken_tutorial_pg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `config_publicgoods`
--
ALTER TABLE `config_publicgoods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT de tabela `public_goods_rounds`
--
ALTER TABLE `public_goods_rounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4782;

--
-- AUTO_INCREMENT de tabela `time_taken_round_pg`
--
ALTER TABLE `time_taken_round_pg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3418;

--
-- AUTO_INCREMENT de tabela `time_taken_tutorial_pg`
--
ALTER TABLE `time_taken_tutorial_pg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=537;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
