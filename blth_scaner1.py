import bluetooth
import json
import threading
import bcrypt
from database import init_db, check_code, update_user, check_install_id, is_registered, get_user_auth_data, is_registered2
from datetime import datetime
from pathlib import Path

UUID = "00001101-0000-1000-8000-00805F9B34FB"

init_db()

stats_file = Path("stats.json")
stats_lock = threading.Lock()

def load_stats():
    if stats_file.exists():
        with open(stats_file, "r", encoding="utf-8") as f:
            return json.load(f)
    return {"connections": 0, "registrations": 0, "authorizations": 0, "errors": 0}

def save_stats(stats):
    with stats_lock:
        with open(stats_file, "w", encoding="utf-8") as f:
            json.dump(stats, f, ensure_ascii=False, indent=4)

def update_stat(key):
    stats = load_stats()
    stats[key] = stats.get(key, 0) + 1
    stats["last_update"] = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    save_stats(stats)

def handle_client(client_sock, client_info):
    print(f"[+] Подключился: {client_info}")
    update_stat("connections")

    try:
        buffer = ""

        while True:
            chunk = client_sock.recv(1024).decode("utf-8")
            if not chunk:
                break
            buffer += chunk

            while "\n" in buffer:
                line, buffer = buffer.split("\n", 1)
                data = line
                if not data:
                    continue
                
                try:
                    parsed = json.loads(data)
                    safe_request = parsed.copy()

                    if "password" in safe_request and safe_request["password"]:
                        safe_request["password"] = "*" * len(safe_request["password"])

                    if "install_id" in safe_request and safe_request["install_id"]:
                        install_id = safe_request["install_id"]
                        if len(install_id) > 2:
                            safe_request["install_id"] = (
                                install_id[0] + "*" * (len(install_id) - 2) + install_id[-1]
                            )
                        else:
                            safe_request["install_id"] = "*" * len(install_id)

                    print(f"[{client_info}] {json.dumps(safe_request, ensure_ascii=False)}")

                except Exception:
                    print(f"[{client_info}] {data}")

                if data.lower() == "ping":
                    client_sock.send("PONG\n".encode("utf-8"))
                    continue

                try:
                    request = json.loads(data)
                    code = request.get("code")
                    install_id = request.get("install_id")
                    password = request.get("password")
                    phone = request.get("phone")
                    name = request.get("name")
                    surname = request.get("surname")
                except json.JSONDecodeError:
                    response = {"status": "error", "message": "Неверный формат JSON"}
                    update_stat("errors")
                    client_sock.send((json.dumps(response) + "\n").encode("utf-8"))
                    continue

                action = request.get("action")

                if action == 'proverka':
                    if not check_code(code):
                        response = {"status": "error", "message": "Код не найден"}
                        update_stat("errors")

                    elif is_registered(code):
                        response = {"status": "error", "message": "Этот код уже зарегистрирован"}
                        update_stat("errors")

                    elif is_registered2(install_id):
                        response = {"status": "error", "message": "Телефон закреплен за другим пользователем"}
                        update_stat("errors")

                    else:
                        response = {"status": "ok", "message": "Код подтверждён"}

                elif action == 'registr':
                    hashed_password = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
                    update_user(code, install_id, hashed_password)
                    response = {"status": "ok", "message": "Регистрация завершена успешно"}
                    update_stat("registrations")

                elif action == 'proverka_install_id':
                    if check_install_id(install_id):
                        response = {"status": "ok", "message": "Успешно"}
                    else:
                        response = {"status": "error", "message": "Вы не зарегистрированы"}
                        update_stat("errors")

                elif action == 'autoriz':
                    user_data = get_user_auth_data(install_id, phone, name, surname)
                    if user_data:
                        hashed_password, access_level = user_data
                        if bcrypt.checkpw(password.encode(), hashed_password.encode()):
                            response = {
                                "status": "ok",
                                "message": "Авторизация прошла успешно",
                                "access_level": access_level
                            }
                            update_stat("authorizations")
                        else:
                            response = {"status": "error", "message": "Ошибка авторизации (неверный пароль)"}
                            update_stat("errors")
                    else:
                        response = {"status": "error", "message": "Пользователь не найден"}
                        update_stat("errors")

                client_sock.send((json.dumps(response) + "\n").encode("utf-8"))

    except OSError:
        print(f"[-] Клиент {client_info} отключился")
    finally:
        client_sock.close()


server_sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
server_sock.bind(("", bluetooth.PORT_ANY))
server_sock.listen(1)

bluetooth.advertise_service(
    server_sock,
    "ControlAccessServer",
    service_id=UUID,
    service_classes=[UUID, bluetooth.SERIAL_PORT_CLASS],
    profiles=[bluetooth.SERIAL_PORT_PROFILE],
)

print("Сервер запущен. Жду клиентов...")

while True:
    client_sock, client_info = server_sock.accept()
    thread = threading.Thread(target=handle_client, args=(client_sock, client_info))
    thread.daemon = True
    thread.start()
