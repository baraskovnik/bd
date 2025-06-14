-- 1. Таблица стран
CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name TEXT
);

-- 2. Таблица клубов
CREATE TABLE club (
    id INT PRIMARY KEY,
    club_name TEXT,
    description MEDIUMTEXT
);

-- 3. Таблица категорий веса
CREATE TABLE weight_category (
    id INT PRIMARY KEY,
    category_name TEXT,
    weight_limit NUMERIC
);

-- 4. Таблица характеристик бойца
CREATE TABLE characteristics (
    id INT PRIMARY KEY,
    age FLOAT,
    high FLOAT,
    weight FLOAT,
    arm_length FLOAT,
    leg_length FLOAT
);

-- 5. Таблица турниров
CREATE TABLE tournament (
    id INT PRIMARY KEY,
    tournament_name TEXT,
    tournament_description MEDIUMTEXT,
    tournament_date DATE
);

-- 6. Таблица результатов боёв
CREATE TABLE result (
    id INT PRIMARY KEY,
    winner TEXT,
    round_number NUMERIC,
    end_time TIME,
    win_method TEXT
);

-- 7. Таблица fight_stats
CREATE TABLE fight_stats (
    id INT PRIMARY KEY,
    strikes MEDIUMTEXT,
    stats MEDIUMTEXT
);

-- 8. Таблица боёв
CREATE TABLE fight (
    id INT PRIMARY KEY,
    fight_name TEXT,
    id_fight_stats INT,
    id_result INT,
    id_tournament INT,
    FOREIGN KEY (id_fight_stats) REFERENCES fight_stats(id),
    FOREIGN KEY (id_result) REFERENCES result(id),
    FOREIGN KEY (id_tournament) REFERENCES tournament(id)
);

-- 9. Таблица среднего значения показателей
CREATE TABLE average_number (
    id INT PRIMARY KEY,
    significant_beats FLOAT,
    missed_beats FLOAT,
    takedown_per_fight FLOAT,
    submissions_attempt FLOAT,
    knockdowns FLOAT
);

-- 10. Таблица ударов
CREATE TABLE punches (
    id INT PRIMARY KEY,
    precision_strikes FLOAT,
    hits NUMERIC,
    all_punches NUMERIC
);

-- 11. Таблица тейкдаунов
CREATE TABLE takedowns (
    id INT PRIMARY KEY,
    successful_takedowns NUMERIC,
    takedown_protection FLOAT,
    all_attempts NUMERIC
);

-- 12. Таблица статистики бойца
CREATE TABLE stats (
    id INT PRIMARY KEY,
    fight_average_duration TIME,
    number_of_KO NUMERIC,
    number_of_submissions NUMERIC,
    wins_by_decision NUMERIC,
    id_average_number INT,
    id_punches INT,
    id_takedowns INT,
    FOREIGN KEY (id_average_number) REFERENCES average_number(id),
    FOREIGN KEY (id_punches) REFERENCES punches(id),
    FOREIGN KEY (id_takedowns) REFERENCES takedowns(id)
);

-- 13. Таблица бойцов
CREATE TABLE fighter (
    id INT PRIMARY KEY,
    photo VARCHAR(255),
    name TEXT,
    nickname TEXT,
    record TEXT,
    style TEXT,
    number_PFP NUMERIC,
    division_name TEXT,
    fight_list LONGTEXT,
    debut_date DATE,
    status TEXT,
    id_fight INT,
    id_characteristics INT,
    id_stats INT,
    id_country INT,
    id_club INT,
    id_weight_category INT,
    FOREIGN KEY (id_characteristics) REFERENCES characteristics(id),
    FOREIGN KEY (id_fight) REFERENCES fight(id),
    FOREIGN KEY (id_country) REFERENCES country(id),
    FOREIGN KEY (id_club) REFERENCES club(id),
    FOREIGN KEY (id_weight_category) REFERENCES weight_category(id)
);
