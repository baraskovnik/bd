-- Удаляем, если уже есть
DROP VIEW IF EXISTS vw_fighter_and_club;
DROP VIEW IF EXISTS vw_fighter_age;
DROP VIEW IF EXISTS vw_country_fighter_count;

-- Представление 1: Все бойцы и их клубы
-- Показывает ID бойца, имя и название клуба (если есть)
CREATE VIEW vw_fighter_and_club AS
SELECT f.id AS fighter_id, f.name AS fighter_name, c.club_name
FROM fighter f
LEFT JOIN club c ON f.id_club = c.id;

-- Тест просмотра:
SELECT * FROM vw_fighter_and_club LIMIT 10;

-- Представление 2: Все бойцы и их возраст
-- Показывает ID бойца, имя и возраст (если указан)
CREATE VIEW vw_fighter_age AS
SELECT f.id AS fighter_id, f.name AS fighter_name, ch.age
FROM fighter f
LEFT JOIN characteristics ch ON f.id_characteristics = ch.id;

-- Тест просмотра:
SELECT * FROM vw_fighter_age LIMIT 10;

-- Представление 3: Количество бойцов по странам
-- Показывает название страны и число бойцов из этой страны
CREATE VIEW vw_country_fighter_count AS
SELECT co.country_name, COUNT(f.id) AS fighter_count
FROM country co
LEFT JOIN fighter f ON co.id = f.id_country
GROUP BY co.id, co.country_name;

-- Тест просмотра:
SELECT * FROM vw_country_fighter_count;
