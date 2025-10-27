import bluetooth
import json
from database import  init_db, check_code, update_user, check_install_id,  is_registered, get_user_auth_data, is_registered2
import bcrypt

UUID = "00001101-0000-1000-8000-00805F9B34FB"

# Инициализация БД
init_db()

# Настройка Bluetooth-сервера
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

# Основной цикл
while True:
    client_sock, client_info = server_sock.accept()
    print(f"[+] Подключился: {client_info}")

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
                
            # Безопасный вывод данных (маскируем чувствительные поля)
                try:
                    parsed = json.loads(data)
                    safe_request = parsed.copy()

                    # Маскируем пароль, если есть
                    if "password" in safe_request and safe_request["password"]:
                        safe_request["password"] = "*" * len(safe_request["password"])

                    # Маскируем install_id (оставляем первый и последний символ)
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
                    # Если не JSON — выводим как есть
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
                    client_sock.send((json.dumps(response) + "\n").encode("utf-8"))
                    continue

                action = request.get("action")

                if action == 'proverka':
                    if not check_code(code):
                        response = {"status": "error", "message": "Код не найден"}

                    elif is_registered(code):
                        response = {"status": "error", "message": "Этот код уже зарегистрирован"}

                    elif is_registered2(install_id):
                        response = {"status": "error", "message": "Телефон закреплен за другим пользователем"}

                    else:
                        response = {"status": "ok", "message": "Код подтверждён"}

                elif action == 'registr':
                    # Хэшируем пароль перед сохранением
                    hashed_password = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
                    update_user(code, install_id, hashed_password)
                    response = {"status": "ok", "message": "Регистрация завершена успешно"}

                elif action == 'proverka_install_id':
                    if check_install_id(install_id):
                        response = {"status": "ok", "message": "Успешно"}
                    else:
                        response = {"status": "error", "message": "Вы не зарегистрированы"}

                elif action == 'autoriz':
                # Получаем данные пользователя
                    user_data = get_user_auth_data(install_id, phone, name, surname)

                    if user_data:
                        hashed_password, access_level = user_data
                        if bcrypt.checkpw(password.encode(), hashed_password.encode()):
                            response = {
                                "status": "ok",
                                "message": "Авторизация прошла успешно",
                                "access_level": access_level
                            }
                        else:
                            response = {"status": "error", "message": "Ошибка авторизации (неверный пароль)"}
                    else:
                        response = {"status": "error", "message": "Пользователь не найден"}

                client_sock.send((json.dumps(response) + "\n").encode("utf-8"))

    except OSError:
        print(f"[-] Клиент {client_info} отключился")
    finally:
        client_sock.close()