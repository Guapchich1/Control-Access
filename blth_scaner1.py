import bluetooth
import json
from database import check_all, init_db, check_code, update_user, check_install_id, check_all, is_registered

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

                    else:
                        response = {"status": "ok", "message": "Код подтверждён"}

                elif action == 'registr':
                    if not check_code(code):
                        response = {"status": "error", "message": "Код не найден"}

                    else:
                        update_user(code, install_id, password)
                        response = {"status": "ok", "message": "Регистрация завершена успешно"}

                elif action == 'proverka_install_id':
                    if check_install_id(install_id):
                        response = {"status": "ok", "message": "Код подтверждён"}
                    else:
                        response = {"status": "error", "message": "Код не найден"}

                elif action == 'autoriz':
                    if check_all(install_id,password,phone,name,surname):
                        response = {"status": "ok", "message": "Код подтверждён"}
                    else:
                        response = {"status": "error", "message": "Код не найден"}
                else:
                    response = {"status": "error", "message": "Код не найден"}

                client_sock.send((json.dumps(response) + "\n").encode("utf-8"))

    except OSError:
        print(f"[-] Клиент {client_info} отключился")
    finally:
        client_sock.close()



