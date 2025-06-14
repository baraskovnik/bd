SELECT
    table_name   AS 'TABLE_NAME',
    table_rows   AS 'TABLE_ROWS'
FROM
    information_schema.tables
WHERE
    table_schema = DATABASE()
    AND table_type = 'BASE TABLE'
    AND table_name IN (
        'country',
        'club',
        'weight_category',
        'characteristics',
        'tournament',
        'result',
        'fight_stats',
        'fight',
        'average_number',
        'punches',
        'takedowns',
        'stats',
        'fighter'
    )
ORDER BY
    table_name;
