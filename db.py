import sqlite3

connection = sqlite3.connect('my_database.db')
cursor = connection.cursor()

cursor.execute('''
    CREATE TABLE IF NOT EXISTS Users (
        imei TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        surname TEXT NOT NULL,
        password TEXT NOT NULL
    )
    ''')

# создаём таблицу посещений
cursor.execute('''
CREATE TABLE IF NOT EXISTS Visits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    imei TEXT NOT NULL,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
        pened_at TEXT NOT NULL,
    FOREIGN KEY (imei) REFERENCES Users(imei)
)
''')
connection.commit()
connection.close()