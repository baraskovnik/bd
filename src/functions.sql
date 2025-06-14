-- Удаляем, если уже есть
DROP FUNCTION IF EXISTS fn_avg_fighter_age;
DROP FUNCTION IF EXISTS fn_country_name_by_fighter;
DROP FUNCTION IF EXISTS fn_fighter_count_in_club;

-- Функция 1: Средний возраст всех бойцов
-- Возвращает среднее значение из characteristics.age (0 если нет бойцов)
DELIMITER $$
CREATE FUNCTION fn_avg_fighter_age() RETURNS FLOAT DETERMINISTIC
BEGIN
    DECLARE avg_age FLOAT DEFAULT 0;
    SELECT AVG(age) INTO avg_age FROM characteristics;
    RETURN IFNULL(avg_age, 0);
END$$
DELIMITER ;

-- Тест вызова функции:
SELECT fn_avg_fighter_age();

-- Функция 2: Имя страны по ID бойца
-- Возвращает country_name для бойца с заданным ID (NULL если не найден)
DELIMITER $$
CREATE FUNCTION fn_country_name_by_fighter(fid INT) RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE cname TEXT;
    SELECT co.country_name INTO cname
    FROM country co
    JOIN fighter f ON co.id = f.id_country
    WHERE f.id = fid
    LIMIT 1;
    RETURN cname;
END$$
DELIMITER ;

-- Тест вызова функции:
SELECT fn_country_name_by_fighter(1);

-- Функция 3: Количество бойцов в клубе по club_id
-- Возвращает число бойцов с заданным id_club (всегда >= 0)
DELIMITER $$
CREATE FUNCTION fn_fighter_count_in_club(cid INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cnt INT DEFAULT 0;
    SELECT COUNT(*) INTO cnt FROM fighter WHERE id_club = cid;
    RETURN cnt;
END$$
DELIMITER ;

-- Тест вызова функции:
SELECT fn_fighter_count_in_club(1);