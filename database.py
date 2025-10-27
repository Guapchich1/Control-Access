import sqlite3
import random
import string

DB_NAME = "codes.db"

def init_db():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    # Создаем таблицу, если её нет
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT UNIQUE NOT NULL,
            install_id TEXT,
            password TEXT,
            phone TEXT,
            name TEXT,
            surname TEXT,
            access_level INTEGER
        )
    """)
    conn.commit()
    conn.close()


def generate_code(length: int = 8) -> str:
    """Генерирует случайный код из цифр, букв и символов"""
    chars = string.ascii_letters + string.digits + "!@#$%^&*"
    return ''.join(random.choices(chars, k=length))


def add_new_user():
    """Добавление нового пользователя вручную"""
    code = generate_code()
    print(f"Сгенерированный код: {code}")

    name = input("Введите имя: ")
    surname = input("Введите фамилию: ")
    phone = input("Введите телефон: ")
    access_level = input("Введите уровень доступа (например, 1, 2, 3...): ")

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO users (code, install_id, password, phone, name, surname, access_level)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """, (code, None, None, phone, name, surname, access_level))
    conn.commit()
    conn.close()

    print(f"Пользователь {name} {surname} успешно добавлен с кодом: {code}")


def check_code(code: str) -> bool:
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT 1 FROM users WHERE code = ?", (code,))
    result = cursor.fetchone()
    conn.close()
    return result is not None


def check_install_id(install_id: str) -> bool:
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT 1 FROM users WHERE install_id = ?", (install_id,))
    result = cursor.fetchone()
    conn.close()
    return result is not None


def update_user(code: str, install_id: str, password: str):
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE users
        SET install_id = ?, password = ?
        WHERE code = ?
    """, (install_id, password, code))
    conn.commit()
    conn.close()


def is_registered(code: str) -> bool:
    """Проверяет, зарегистрирован ли код (т.е. уже привязан install_id)"""
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT install_id FROM users WHERE code = ?", (code,))
    row = cursor.fetchone()
    conn.close()
    return row and row[0] is not None

def is_registered2(install_id: str) -> bool:
    """Проверяет, зарегистрирован ли install_id под другим кодом"""
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT code FROM users WHERE install_id = ?", (install_id,))
    row = cursor.fetchone()
    conn.close()
    return row and row[0] is not None

def get_user_auth_data(install_id: str, phone: str, name: str, surname: str):
    """
    Возвращает кортеж (password, access_level) для авторизации пользователя.
    Если пользователь не найден — возвращает None.
    """
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("""
        SELECT password, access_level FROM users
        WHERE install_id = ? AND phone = ? AND name = ? AND surname = ?
    """, (install_id, phone, name, surname))
    row = cursor.fetchone()
    conn.close()
    return row