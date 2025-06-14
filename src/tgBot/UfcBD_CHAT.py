import telebot
from telebot import types
import mysql.connector
from mysql.connector import Error

# Инициализация бота (замени на свой токен)
bot = telebot.TeleBot('7802610929:AAE7hYyehHiLkm8U7RqBZeBVgb_NCq1oqG8')

# Создание подключения к БД
def create_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="12345",
        database="ufc"
    )

import telebot
from telebot import types
import mysql.connector

# Токен бота
bot = telebot.TeleBot('7802610929:AAE7hYyehHiLkm8U7RqBZeBVgb_NCq1oqG8')

# Создание подключения к БД
def create_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="12345",
        database="ufc"
    )

def show_main_menu(chat_id):
    markup = types.InlineKeyboardMarkup(row_width=2)
    markup.add(
        types.InlineKeyboardButton('📸СТРАНЫ📸', callback_data='menu_country'),
        types.InlineKeyboardButton('👕КЛУБЫ👕', callback_data='menu_club'),
        types.InlineKeyboardButton('👑КАТЕГОРИИ ВЕСА👑', callback_data='menu_weight'),
        types.InlineKeyboardButton('🥇БОЙЦЫ🥇', callback_data='menu_fighter')
    )
    bot.send_message(chat_id, "Выберите таблицу:", reply_markup=markup)

def send_error_and_main_menu(chat_id, error_msg):
    bot.send_message(chat_id, f"❌ Ошибка: {error_msg}")
    show_main_menu(chat_id)

@bot.message_handler(commands=['start'])
def start(message):
    show_main_menu(message.chat.id)

@bot.callback_query_handler(func=lambda call: call.data.startswith('menu_'))
def main_menu(call):
    chat_id = call.message.chat.id
    table = call.data.split('_')[1]
    table_names = {
        'country': 'стран',
        'club': 'клубов',
        'weight': 'категорий веса',
        'fighter': 'бойцов'
    }
    table_full = table_names.get(table, table)
    markup = types.InlineKeyboardMarkup(row_width=2)
    markup.add(
        types.InlineKeyboardButton('СПИСОК', callback_data=f'view_{table}'),
        types.InlineKeyboardButton('ДОБАВЛЕНИЕ', callback_data=f'add_{table}'),
        types.InlineKeyboardButton('ОБНОВЛЕНИЕ', callback_data=f'update_{table}'),
        types.InlineKeyboardButton('УДАЛЕНИЕ', callback_data=f'delete_{table}'),
        types.InlineKeyboardButton('ВЕРНУТЬСЯ В ГЛАВНОЕ МЕНЮ', callback_data='back_to_main')
    )
    bot.edit_message_text(f"Выберите действие для {table_full}:", chat_id, call.message.message_id, reply_markup=markup)

@bot.callback_query_handler(func=lambda call: call.data == 'back_to_main')
def back_to_main(call):
    show_main_menu(call.message.chat.id)

# ========== CRUD COUNTRY ==========
@bot.callback_query_handler(func=lambda call: call.data == 'view_country')
def view_country(call):
    conn = cur = None
    try:
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM country")
        rows = cur.fetchall()
        msg = "<b>Страны:</b>\n"
        for row in rows:
            msg += f"ID {row[0]}: {row[1]}\n"
        bot.send_message(call.message.chat.id, msg, parse_mode='HTML')
        show_main_menu(call.message.chat.id)
    except Exception as e:
        send_error_and_main_menu(call.message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'add_country')
def add_country(call):
    msg = bot.send_message(call.message.chat.id, "Введите страну (id;название):")
    bot.register_next_step_handler(msg, insert_country)

def insert_country(message):
    conn = cur = None
    try:
        cid, name = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO country VALUES (%s, %s)", (cid, name))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Страна добавлена.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'update_country')
def update_country(call):
    msg = bot.send_message(call.message.chat.id, "Введите id страны для обновления:")
    bot.register_next_step_handler(msg, update_country_step2)

def update_country_step2(message):
    cid = message.text
    msg = bot.send_message(message.chat.id, "Введите новое название:")
    bot.register_next_step_handler(msg, update_country_final, cid)

def update_country_final(message, cid):
    conn = cur = None
    try:
        name = message.text
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("UPDATE country SET country_name=%s WHERE id=%s", (name, cid))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Страна обновлена.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'delete_country')
def delete_country(call):
    msg = bot.send_message(call.message.chat.id, "Введите id страны для удаления:")
    bot.register_next_step_handler(msg, delete_country_final)

def delete_country_final(message):
    conn = cur = None
    try:
        cid = message.text
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("DELETE FROM country WHERE id=%s", (cid,))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Страна удалена.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

# ========== CRUD CLUB ==========
@bot.callback_query_handler(func=lambda call: call.data == 'view_club')
def view_club(call):
    conn = cur = None
    try:
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT id, club_name, description FROM club")
        rows = cur.fetchall()
        msg = "<b>Клубы:</b>\n"
        for row in rows:
            msg += f"ID {row[0]}: {row[1]} ({row[2]})\n"
        bot.send_message(call.message.chat.id, msg, parse_mode='HTML')
        show_main_menu(call.message.chat.id)
    except Exception as e:
        send_error_and_main_menu(call.message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'add_club')
def add_club(call):
    msg = bot.send_message(call.message.chat.id, "Введите клуб (id;название;описание):")
    bot.register_next_step_handler(msg, insert_club)

def insert_club(message):
    conn = cur = None
    try:
        cid, name, desc = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO club (id, club_name, description) VALUES (%s, %s, %s)", (cid, name, desc))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Клуб добавлен.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'update_club')
def update_club(call):
    msg = bot.send_message(call.message.chat.id, "Введите id клуба для обновления:")
    bot.register_next_step_handler(msg, update_club_step2)

def update_club_step2(message):
    cid = message.text
    msg = bot.send_message(message.chat.id, "Введите новые данные (название;описание):")
    bot.register_next_step_handler(msg, update_club_final, cid)

def update_club_final(message, cid):
    conn = cur = None
    try:
        name, desc = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("UPDATE club SET club_name=%s, description=%s WHERE id=%s", (name, desc, cid))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Клуб обновлён.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'delete_club')
def delete_club(call):
    msg = bot.send_message(call.message.chat.id, "Введите id клуба для удаления:")
    bot.register_next_step_handler(msg, delete_club_final)

def delete_club_final(message):
    conn = cur = None
    try:
        cid = message.text
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("DELETE FROM club WHERE id=%s", (cid,))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Клуб удалён.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

# ========== CRUD WEIGHT CATEGORY ==========
@bot.callback_query_handler(func=lambda call: call.data == 'view_weight')
def view_weight(call):
    conn = cur = None
    try:
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM weight_category")
        rows = cur.fetchall()
        msg = "<b>Категории веса:</b>\n"
        for row in rows:
            msg += f"ID {row[0]}: {row[1]}, лимит: {row[2]}\n"
        bot.send_message(call.message.chat.id, msg, parse_mode='HTML')
        show_main_menu(call.message.chat.id)
    except Exception as e:
        send_error_and_main_menu(call.message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'add_weight')
def add_weight(call):
    msg = bot.send_message(call.message.chat.id, "Введите категорию (id;название;лимит):")
    bot.register_next_step_handler(msg, insert_weight)

def insert_weight(message):
    conn = cur = None
    try:
        cid, name, limit = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO weight_category VALUES (%s, %s, %s)", (cid, name, limit))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Категория веса добавлена.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'update_weight')
def update_weight(call):
    msg = bot.send_message(call.message.chat.id, "Введите id категории для обновления:")
    bot.register_next_step_handler(msg, update_weight_step2)

def update_weight_step2(message):
    cid = message.text
    msg = bot.send_message(message.chat.id, "Введите новые данные (название;лимит):")
    bot.register_next_step_handler(msg, update_weight_final, cid)

def update_weight_final(message, cid):
    conn = cur = None
    try:
        name, limit = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("UPDATE weight_category SET category_name=%s, weight_limit=%s WHERE id=%s", (name, limit, cid))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Категория веса обновлена.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'delete_weight')
def delete_weight(call):
    msg = bot.send_message(call.message.chat.id, "Введите id категории для удаления:")
    bot.register_next_step_handler(msg, delete_weight_final)

def delete_weight_final(message):
    conn = cur = None
    try:
        cid = message.text
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("DELETE FROM weight_category WHERE id=%s", (cid,))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Категория веса удалена.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

# ========== CRUD FIGHTER ==========
@bot.callback_query_handler(func=lambda call: call.data == 'view_fighter')
def view_fighter(call):
    conn = cur = None
    try:
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT id, name, nickname, record, status FROM fighter")
        rows = cur.fetchall()
        msg = "<b>Бойцы:</b>\n"
        for row in rows:
            msg += f"ID {row[0]}: {row[1]}, Nickname: {row[2]}, Record: {row[3]}, Status: {row[4]}\n"
        bot.send_message(call.message.chat.id, msg, parse_mode='HTML')
        show_main_menu(call.message.chat.id)
    except Exception as e:
        send_error_and_main_menu(call.message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'add_fighter')
def add_fighter(call):
    msg = bot.send_message(call.message.chat.id, "Введите бойца (id;name;nickname;record;status):")
    bot.register_next_step_handler(msg, insert_fighter)

def insert_fighter(message):
    conn = cur = None
    try:
        fid, name, nickname, record, status = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO fighter (id, name, nickname, record, status) VALUES (%s, %s, %s, %s, %s)",
            (fid, name, nickname, record, status)
        )
        conn.commit()
        bot.send_message(message.chat.id, "✅ Боец добавлен.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'update_fighter')
def update_fighter(call):
    msg = bot.send_message(call.message.chat.id, "Введите id бойца для обновления:")
    bot.register_next_step_handler(msg, update_fighter_step2)

def update_fighter_step2(message):
    fid = message.text
    msg = bot.send_message(message.chat.id, "Введите новые данные (name;nickname;record;status):")
    bot.register_next_step_handler(msg, update_fighter_final, fid)

def update_fighter_final(message, fid):
    conn = cur = None
    try:
        name, nickname, record, status = message.text.split(';')
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute(
            "UPDATE fighter SET name=%s, nickname=%s, record=%s, status=%s WHERE id=%s",
            (name, nickname, record, status, fid)
        )
        conn.commit()
        bot.send_message(message.chat.id, "✅ Данные бойца обновлены.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

@bot.callback_query_handler(func=lambda call: call.data == 'delete_fighter')
def delete_fighter(call):
    msg = bot.send_message(call.message.chat.id, "Введите id бойца для удаления:")
    bot.register_next_step_handler(msg, delete_fighter_final)

def delete_fighter_final(message):
    conn = cur = None
    try:
        fid = message.text
        conn = create_db_connection()
        cur = conn.cursor()
        cur.execute("DELETE FROM fighter WHERE id=%s", (fid,))
        conn.commit()
        bot.send_message(message.chat.id, "✅ Боец удалён.")
        show_main_menu(message.chat.id)
    except Exception as e:
        send_error_and_main_menu(message.chat.id, e)
    finally:
        if cur: cur.close()
        if conn: conn.close()

if __name__ == "__main__":
    bot.polling(non_stop=True)


