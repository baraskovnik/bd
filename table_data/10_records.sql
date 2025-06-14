-- 1. country
INSERT INTO country (id, country_name) VALUES
(24500, 'Australia'),
(24400, 'USA'),
(24401, 'Brazil'),
(24402, 'Russia'),
(24403, 'France'),
(24404, 'UK'),
(24405, 'Germany'),
(24406, 'Japan'),
(24407, 'Canada'),
(24408, 'Mexico');

-- 2. club
INSERT INTO club (id, club_name, description) VALUES
(23800, 'Freestyle Fighting Gym', 'Joe Lopez, Eugene Berman, Craig Jones'),
(23700, 'Team Jones', 'Brandon Gibson'),
(23701, 'American Top Team', 'Dan Lambert'),
(23702, 'AKA', 'Javier Mendez'),
(23703, 'Jackson Wink MMA', 'Greg Jackson'),
(23704, 'Tristar Gym', 'Firas Zahabi'),
(23705, 'Nova Uniao', 'Andre Pederneiras'),
(23706, 'Tiger Muay Thai', 'George Hickman'),
(23707, 'Alliance MMA', 'Eric Del Fierro'),
(23708, 'Renzo Gracie Academy', 'Renzo Gracie');


-- 3. weight_category
INSERT INTO weight_category (id, category_name, weight_limit) VALUES
(20350, 'Featherweight division', 145),
(20400, 'Heavyweight division', 265),
(20351, 'Lightweight division', 155),
(20352, 'Welterweight division', 170),
(20353, 'Middleweight division', 185),
(20354, 'Light Heavyweight division', 205),
(20355, 'Flyweight division', 125),
(20356, 'Bantamweight division', 135),
(20357, 'Women Strawweight', 115),
(20358, 'Women Flyweight', 125);

-- 4. average_number
INSERT INTO average_number (id, significant_beats, missed_beats, takedown_per_fight, submissions_attempt, knockdowns) VALUES
(10010, 6.18, 3.36, 1.67, 0.16, 0.32),
(10020, 4.38, 2.24, 1.89, 0.46, 0.25),
(10030, 5.22, 2.88, 2.10, 0.22, 0.20),
(10040, 4.05, 2.60, 1.55, 0.30, 0.15),
(10050, 5.10, 3.10, 2.25, 0.25, 0.18),
(10060, 4.92, 2.70, 2.50, 0.12, 0.19),
(10070, 6.00, 2.90, 1.95, 0.28, 0.22),
(10080, 5.87, 3.01, 2.00, 0.14, 0.17),
(10090, 4.75, 2.40, 1.70, 0.20, 0.14),
(10100, 5.60, 3.25, 2.15, 0.19, 0.21);

-- 5. punches
INSERT INTO punches (id, precision_strikes, hits, all_punches) VALUES
(20020, 0.57, 1717, 3018),
(20030, 0.59, 1563, 2625),
(20040, 0.54, 1450, 2700),
(20050, 0.56, 1350, 2100),
(20060, 0.58, 1520, 2500),
(20070, 0.60, 1600, 3200),
(20080, 0.55, 1480, 2800),
(20090, 0.53, 1330, 2000),
(20100, 0.52, 1200, 2200),
(20110, 0.61, 1625, 3220);

-- 6. takedowns
INSERT INTO takedowns (id, successful_takedowns, takedown_protection, all_attempts) VALUES
(30030, 72, 0.70, 210),
(30040, 36, 0.95, 98),
(30050, 40, 0.80, 110),
(30060, 30, 0.85, 100),
(30070, 55, 0.75, 140),
(30080, 60, 0.68, 150),
(30090, 44, 0.82, 130),
(30100, 38, 0.77, 125),
(30110, 49, 0.90, 120),
(30120, 53, 0.73, 180);

-- 7. stats
INSERT INTO stats (id, fight_average_duration, number_of_KO, number_of_submissions, wins_by_decision, id_average_number, id_punches, id_takedowns) VALUES
(21110, '16:21', 13, 3, 11, 10010, 20020, 30030),
(21111, '14:52', 11, 7, 10, 10020, 20030, 30040),
(21112, '15:10', 8, 2, 7, 10030, 20040, 30050),
(21113, '17:05', 10, 5, 9, 10040, 20050, 30060),
(21114, '13:35', 14, 6, 13, 10050, 20060, 30070),
(21115, '14:48', 9, 4, 8, 10060, 20070, 30080),
(21116, '15:59', 7, 3, 6, 10070, 20080, 30090),
(21117, '12:50', 5, 1, 5, 10080, 20090, 30100),
(21118, '16:01', 12, 5, 11, 10100, 20100, 30110),
(21119, '13:33', 10, 2, 7, 10090, 20110, 30120);

-- 8. characteristics
INSERT INTO characteristics (id, age, high, weight, arm_length, leg_length) VALUES
(21100, 36, 66.00, 145.00, 71.50, 36.00),
(21200, 37, 76.00, 237.60, 84.50, 45.00),
(21201, 28, 72.00, 155.00, 70.00, 38.00),
(21202, 30, 71.00, 170.00, 73.00, 39.00),
(21203, 32, 73.00, 185.00, 77.00, 40.00),
(21204, 29, 74.00, 205.00, 80.00, 41.00),
(21205, 27, 68.00, 135.00, 67.00, 35.00),
(21206, 26, 65.00, 125.00, 65.00, 34.00),
(21207, 25, 66.00, 115.00, 64.00, 33.00),
(21208, 24, 67.00, 125.00, 66.00, 34.00);

-- 9. fight_stats (реальные бои, реальные имена)
INSERT INTO fight_stats (id, strikes, stats) VALUES
(10800, 'Volkanovski:165 Lopes:71\nRound 1: Volkanovski:31 Lopes:11\nRound 2: Volkanovski:27 Lopes:17\nRound 3: Volkanovski:25 Lopes:9\nRound 4: Volkanovski:39 Lopes:16\nRound 5: Volkanovski:43 Lopes:18', 'Volkanovski in head:136 Volkanovski in body:8 Volkanovski in legs:14 Lopes in head:49 Lopes in body:7 Lopes in legs:7\n...'),
(10900, 'Jones:8 Gane:7\nRound 1: Jones:8 Gane:7', 'Jones in head:2 Jones in body:0 Jones in legs:3 Gane in head:1 Gane in body:2 Gane in legs:3\n...'),
(10901, 'Makhachev:15 Oliveira:10', 'Makhachev in head:8 Makhachev in body:2 Makhachev in legs:5 Oliveira in head:6 Oliveira in body:2 Oliveira in legs:2\n...'),
(10902, 'Adesanya:11 Pereira:9', 'Adesanya in head:5 Pereira in body:2 Adesanya in legs:4 Pereira in head:5 Pereira in body:2 Pereira in legs:2\n...'),
(10903, 'McGregor:20 Poirier:17', 'McGregor in head:13 McGregor in body:3 McGregor in legs:4 Poirier in head:10 Poirier in body:4 Poirier in legs:3\n...'),
(10904, 'Shevchenko:13 Grasso:7', 'Shevchenko in head:6 Shevchenko in body:3 Shevchenko in legs:4 Grasso in head:5 Grasso in body:1 Grasso in legs:1\n...'),
(10905, 'Usman:19 Covington:12', 'Usman in head:12 Usman in body:4 Usman in legs:3 Covington in head:9 Covington in body:2 Covington in legs:1\n...'),
(10906, 'Sterling:14 Yan:11', 'Sterling in head:9 Sterling in body:2 Sterling in legs:3 Yan in head:7 Yan in body:2 Yan in legs:2\n...'),
(10907, 'Namajunas:16 Zhang:8', 'Namajunas in head:10 Namajunas in body:3 Namajunas in legs:3 Zhang in head:5 Zhang in body:2 Zhang in legs:1\n...'),
(10908, 'Moreno:22 Figueiredo:21', 'Moreno in head:13 Moreno in body:5 Moreno in legs:4 Figueiredo in head:12 Figueiredo in body:6 Figueiredo in legs:3\n...');

-- 10. result (заменил Fighter3 и т.д. на реальные имена, корректируя результат)
INSERT INTO result (id, winner, round_number, end_time, win_method) VALUES
(20800, 'Alexander Volkanovski', 5, '5:00', 'Decision - Unanimous'),
(20900, 'Jon Jones', 1, '2:04', 'Submission'),
(20901, 'Islam Makhachev', 2, '3:45', 'KO'),
(20902, 'Israel Adesanya', 3, '4:10', 'TKO'),
(20903, 'Conor McGregor', 1, '2:25', 'Decision - Split'),
(20904, 'Valentina Shevchenko', 2, '3:55', 'Submission'),
(20905, 'Kamaru Usman', 1, '1:50', 'KO'),
(20906, 'Aljamain Sterling', 4, '5:00', 'Decision - Unanimous'),
(20907, 'Rose Namajunas', 2, '2:33', 'TKO'),
(20908, 'Brandon Moreno', 3, '4:44', 'Submission');

-- 11. tournament
INSERT INTO tournament (id, tournament_name, tournament_description, tournament_date) VALUES
(30800, 'UFC 314', 'Kaseya Center, Miami United States', '2025-04-13'),
(30900, 'UFC 285', 'T-Mobile Arena, Las Vegas United States', '2023-03-05'),
(30901, 'UFC 300', 'Madison Square Garden, NY', '2024-11-10'),
(30902, 'UFC 301', 'O2 Arena, London', '2024-05-15'),
(30903, 'UFC 302', 'Accor Arena, Paris', '2024-07-19'),
(30904, 'UFC 303', 'Saitama Super Arena, Japan', '2024-08-09'),
(30905, 'UFC 304', 'Jeunesse Arena, Rio', '2024-09-12'),
(30906, 'UFC 305', 'Rod Laver Arena, Melbourne', '2024-10-02'),
(30907, 'UFC 306', 'Arena Mexico, Mexico City', '2024-10-22'),
(30908, 'UFC 307', 'Palacio de los Deportes, Madrid', '2024-11-01');


-- 12. fight (теперь имена и пары соответствуют реальным)
INSERT INTO fight (id, fight_name, id_fight_stats, id_result, id_tournament) VALUES
(11122, 'Volkanovski vs Lopes', 10800, 20800, 30800),
(11133, 'Jones vs Gane', 10900, 20900, 30900),
(11134, 'Makhachev vs Oliveira', 10901, 20901, 30901),
(11135, 'Adesanya vs Pereira', 10902, 20902, 30902),
(11136, 'McGregor vs Poirier', 10903, 20903, 30903),
(11137, 'Shevchenko vs Grasso', 10904, 20904, 30904),
(11138, 'Usman vs Covington', 10905, 20905, 30905),
(11139, 'Sterling vs Yan', 10906, 20906, 30906),
(11140, 'Namajunas vs Zhang', 10907, 20907, 30907),
(11141, 'Moreno vs Figueiredo', 10908, 20908, 30908);

-- 13. fighter (теперь реальные имена, остальное можно доработать по необходимости)
INSERT INTO fighter (id, photo, name, nickname, record, style, number_PFP, division_name, fight_list, debut_date, status, id_fight, id_characteristics, id_stats, id_country, id_club, id_weight_category) VALUES
(23831, NULL, 'Alexander Volkanovski', 'The Great', '27-4-0', 'kickboxing', 9, '0(Champion)', 'Pro since 2012\n13 wins by KO, three by submission (Triangle, RNC, guillotine)\nSeven first round finishes\nHas won 24 of his last 27\nMade five successful title defenses', '2016-10-15', 'Active', 11122, 21100, 21110, 24500, 23800, 20350),
(23832, NULL, 'Jon Jones', 'Bones', '28-1-0', 'grappling', 2, '0(Champion)', 'Youngest champion in UFC history\nHas only gone the distance 10 times as a pro\n11 KO wins and seven by submission...', '2008-08-09', 'Active', 11133, 21200, 21111, 24400, 23700, 20400),
(23833, NULL, 'Islam Makhachev', 'Dagestani', '25-1-0', 'sambo', 5, '1', 'UFC lightweight champion\nMany time sambo champion', '2015-10-03', 'Active', 11134, 21201, 21112, 24401, 23701, 20351),
(23834, NULL, 'Charles Oliveira', 'Do Bronx', '34-9-0', 'bjj', 4, '2', 'Most submission wins in UFC history', '2010-08-01', 'Active', 11134, 21202, 21113, 24402, 23702, 20352),
(23835, NULL, 'Israel Adesanya', 'The Last Stylebender', '24-2-0', 'kickboxing', 7, '3', 'Former UFC middleweight champion', '2018-02-11', 'Active', 11135, 21203, 21114, 24403, 23703, 20353),
(23836, NULL, 'Alex Pereira', 'Poatan', '9-2-0', 'kickboxing', 3, '4', 'Double champion (Glory)', '2021-11-06', 'Active', 11135, 21204, 21115, 24404, 23704, 20354),
(23837, NULL, 'Conor McGregor', 'The Notorious', '22-6-0', 'boxing', 6, '5', 'Double UFC champion', '2013-04-06', 'Active', 11136, 21205, 21116, 24405, 23705, 20355),
(23838, NULL, 'Dustin Poirier', 'The Diamond', '29-8-0', 'boxing', 8, '6', 'Former interim UFC lightweight champion', '2011-01-01', 'Active', 11136, 21206, 21117, 24406, 23706, 20356),
(23839, NULL, 'Valentina Shevchenko', 'Bullet', '23-4-0', 'muay thai', 1, '7', 'Multiple time flyweight champion', '2015-12-19', 'Active', 11137, 21207, 21118, 24407, 23707, 20357),
(23840, NULL, 'Alexa Grasso', NULL, '16-3-0', 'boxing', 10, '8', 'Current UFC flyweight champion', '2016-11-05', 'Active', 11137, 21208, 21119, 24408, 23708, 20358);
