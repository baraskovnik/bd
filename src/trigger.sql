-- Триггер: запрещает добавлять бойца с весом меньше 40 кг
DELIMITER $$

CREATE TRIGGER trg_check_fighter_weight
BEFORE INSERT ON characteristics
FOR EACH ROW
BEGIN
    -- Если вес бойца меньше 40 кг, выбрасываем ошибку
    IF NEW.weight < 40 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Weight must be at least 40 kg';
    END IF;
END$$

DELIMITER ;

-- 1) Корректная вставка (успешно)
INSERT INTO characteristics(id, age, high, weight, arm_length, leg_length)
VALUES (911999, 25, 180, 75, 70, 105);

-- 2) Некорректная вставка (ошибка, вес < 40)
INSERT INTO characteristics(id, age, high, weight, arm_length, leg_length)
VALUES (1011000, 22, 165, 35, 60, 98);