-- 1. Для каждой страны — средний процент точных ударов всех бойцов, отсортировать по убыванию
SELECT co.country_name,
       ROUND(AVG(p.precision_strikes)*100, 2) AS avg_precision_percent
FROM country co
JOIN fighter f ON co.id = f.id_country
JOIN stats s ON f.id_stats = s.id
JOIN punches p ON s.id_punches = p.id
GROUP BY co.country_name
ORDER BY avg_precision_percent DESC;


-- 2. Для каждого клуба — вывести имя самого возрастного бойца и его возраст
SELECT c.club_name, f.name, ch.age
FROM club c
JOIN fighter f ON c.id = f.id_club
JOIN characteristics ch ON f.id_characteristics = ch.id
WHERE ch.age = (
    SELECT MAX(ch2.age)
    FROM fighter f2
    JOIN characteristics ch2 ON f2.id_characteristics = ch2.id
    WHERE f2.id_club = c.id
)
ORDER BY c.club_name;

-- 3. Топ-5 самых часто встречающихся значений роста среди бойцов (сколько бойцов у каждого такого роста)
SELECT 
    ch.high AS height,
    COUNT(*) AS fighter_count
FROM 
    characteristics ch
JOIN 
    fighter f ON f.id_characteristics = ch.id
GROUP BY 
    ch.high
ORDER BY 
    fighter_count DESC
LIMIT 5;





-- 4. Для каждого клуба — среднее число попыток тейкдауна на бойца, топ-2 клуба по этому показателю
SELECT c.club_name, ROUND(AVG(t.all_attempts), 2) AS avg_takedown_attempts
FROM club c
JOIN fighter f ON c.id = f.id_club
JOIN stats s ON f.id_stats = s.id
JOIN takedowns t ON s.id_takedowns = t.id
GROUP BY c.club_name
ORDER BY avg_takedown_attempts DESC
LIMIT 2;


-- 5. Количество бойцов в каждом клубе, средний возраст, максимальный и минимальный вес в клубе
SELECT 
    c.club_name,
    COUNT(f.id) AS fighters_count,
    ROUND(AVG(ch.age), 1) AS avg_age,
    MAX(ch.weight) AS max_weight,
    MIN(ch.weight) AS min_weight
FROM 
    club c
LEFT JOIN 
    fighter f ON f.id_club = c.id
LEFT JOIN 
    characteristics ch ON f.id_characteristics = ch.id
GROUP BY 
    c.club_name
ORDER BY 
    fighters_count DESC, c.club_name
LIMIT 10;

