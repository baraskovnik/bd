import random
import datetime

NUM_RECORDS = 10000

def random_date(start_year=2000, end_year=2025):
    start = datetime.date(start_year, 1, 1).toordinal()
    end = datetime.date(end_year, 12, 31).toordinal()
    return datetime.date.fromordinal(random.randint(start, end))

def random_time():
    hour = random.randint(0, 23)
    minute = random.randint(0, 59)
    second = random.randint(0, 59)
    return f"{hour:02d}:{minute:02d}:{second:02d}"

with open("insert_data.sql", "w", encoding="utf-8") as f:

    # 1. country (только id и country_name)
    for i in range(1, NUM_RECORDS + 1):
        f.write(f"INSERT INTO country (id, country_name) VALUES ({i}, 'Country_{i}');\n")

    # 2. club
    for i in range(1, NUM_RECORDS + 1):
        desc = f"Coach_{i}"
        f.write(f"INSERT INTO club (id, club_name, description) VALUES ({i}, 'Club_{i}', '{desc}');\n")

    # 3. weight_category
    for i in range(1, NUM_RECORDS + 1):
        f.write(f"INSERT INTO weight_category (id, category_name, weight_limit) VALUES ({i}, 'Category_{i}', {random.randint(115, 265)});\n")

    # 4. average_number
    for i in range(1, NUM_RECORDS + 1):
        f.write(
            f"INSERT INTO average_number (id, significant_beats, missed_beats, takedown_per_fight, submissions_attempt, knockdowns) VALUES "
            f"({i}, {round(random.uniform(2,8),2)}, {round(random.uniform(1,4),2)}, {round(random.uniform(0,3),2)}, {round(random.uniform(0,1),2)}, {round(random.uniform(0,1),2)});\n"
        )

    # 5. punches
    for i in range(1, NUM_RECORDS + 1):
        f.write(
            f"INSERT INTO punches (id, precision_strikes, hits, all_punches) VALUES "
            f"({i}, {round(random.uniform(0.5,0.65),2)}, {random.randint(1000,2000)}, {random.randint(2000,4000)});\n"
        )

    # 6. takedowns
    for i in range(1, NUM_RECORDS + 1):
        f.write(
            f"INSERT INTO takedowns (id, successful_takedowns, takedown_protection, all_attempts) VALUES "
            f"({i}, {random.randint(20,80)}, {round(random.uniform(0.6,1.0),2)}, {random.randint(80,220)});\n"
        )

    # 7. stats
    for i in range(1, NUM_RECORDS + 1):
        time_val = f"{random.randint(10, 25)}:{random.randint(0,59):02d}"
        f.write(
            f"INSERT INTO stats (id, fight_average_duration, number_of_KO, number_of_submissions, wins_by_decision, id_average_number, id_punches, id_takedowns) VALUES "
            f"({i}, '{time_val}', {random.randint(1,15)}, {random.randint(0,10)}, {random.randint(0,15)}, {random.randint(1,NUM_RECORDS)}, {random.randint(1,NUM_RECORDS)}, {random.randint(1,NUM_RECORDS)});\n"
        )

    # 8. characteristics
    for i in range(1, NUM_RECORDS + 1):
        f.write(
            f"INSERT INTO characteristics (id, age, high, weight, arm_length, leg_length) VALUES "
            f"({i}, {random.randint(18,40)}, {random.uniform(60,80):.2f}, {random.uniform(120,265):.2f}, {random.uniform(60,90):.2f}, {random.uniform(30,50):.2f});\n"
        )

    # 9. fight_stats
    for i in range(1, NUM_RECORDS + 1):
        strikes = f'FighterA:{random.randint(10,200)} FighterB:{random.randint(10,200)}'
        stats = f'FighterA head:{random.randint(0,50)} body:{random.randint(0,20)} legs:{random.randint(0,10)}; FighterB head:{random.randint(0,50)} body:{random.randint(0,20)} legs:{random.randint(0,10)}'
        f.write(
            f"INSERT INTO fight_stats (id, strikes, stats) VALUES ({i}, '{strikes}', '{stats}');\n"
        )

    # 10. result
    win_methods = ["KO", "TKO", "Submission", "Decision - Unanimous", "Decision - Split"]
    for i in range(1, NUM_RECORDS + 1):
        winner = f'Fighter_{random.randint(1,NUM_RECORDS)}'
        rounds = random.randint(1,5)
        end_time = f"{random.randint(0,5)}:{random.randint(0,59):02d}"
        win_method = random.choice(win_methods)
        f.write(
            f"INSERT INTO result (id, winner, round_number, end_time, win_method) VALUES "
            f"({i}, '{winner}', {rounds}, '{end_time}', '{win_method}');\n"
        )

    # 11. tournament
    for i in range(1, NUM_RECORDS + 1):
        descr = f"Description_{i}"
        date = random_date(2010, 2025)
        f.write(
            f"INSERT INTO tournament (id, tournament_name, tournament_description, tournament_date) VALUES "
            f"({i}, 'Tournament_{i}', '{descr}', '{date}');\n"
        )

    # 12. fight
    for i in range(1, NUM_RECORDS + 1):
        name = f'Fighter_{random.randint(1,NUM_RECORDS)} vs Fighter_{random.randint(1,NUM_RECORDS)}'
        id_fight_stats = random.randint(1, NUM_RECORDS)
        id_result = random.randint(1, NUM_RECORDS)
        id_tournament = random.randint(1, NUM_RECORDS)
        f.write(
            f"INSERT INTO fight (id, fight_name, id_fight_stats, id_result, id_tournament) VALUES "
            f"({i}, '{name}', {id_fight_stats}, {id_result}, {id_tournament});\n"
        )

    # 13. fighter
    styles = ["kickboxing", "boxing", "grappling", "wrestling", "karate", "muay thai", "judo", "bjj"]
    statuses = ["Active", "Inactive"]
    for i in range(1, NUM_RECORDS + 1):
        name = f'Fighter_{i}'
        nickname = f'Nick{i}'
        record = f'{random.randint(0,35)}-{random.randint(0,10)}-{random.randint(0,5)}'
        style = random.choice(styles)
        number_PFP = random.randint(1,15)
        division_name = f'Division_{random.randint(1,10)}'
        fight_list = f'Some info {i}'
        debut_date = random_date(2010, 2025)
        status = random.choice(statuses)
        id_fight = random.randint(1, NUM_RECORDS)
        id_characteristics = random.randint(1, NUM_RECORDS)
        id_stats = random.randint(1, NUM_RECORDS)
        id_country = random.randint(1, NUM_RECORDS)
        id_club = random.randint(1, NUM_RECORDS)
        id_weight_category = random.randint(1, NUM_RECORDS)
        f.write(
            f"INSERT INTO fighter (id, photo, name, nickname, record, style, number_PFP, division_name, fight_list, debut_date, status, id_fight, id_characteristics, id_stats, id_country, id_club, id_weight_category) VALUES "
            f"({i}, NULL, '{name}', '{nickname}', '{record}', '{style}', {number_PFP}, '{division_name}', '{fight_list}', '{debut_date}', '{status}', {id_fight}, {id_characteristics}, {id_stats}, {id_country}, {id_club}, {id_weight_category});\n"
        )

print("Файл insert_data.sql успешно сгенерирован.")
