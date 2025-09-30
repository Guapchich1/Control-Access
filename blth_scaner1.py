import bluetooth

UUID = "00001101-0000-1000-8000-00805F9B34FB"

server_sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
server_sock.bind(("", bluetooth.PORT_ANY))
server_sock.listen(1)

bluetooth.advertise_service(
    server_sock,
    "ContorlAccessServer",
    service_id=UUID,
    service_classes=[UUID, bluetooth.SERIAL_PORT_CLASS],
    profiles=[bluetooth.SERIAL_PORT_PROFILE],
)

print("Сервер запущен. Жду клиентов...")

while True:
    client_sock, client_info = server_sock.accept()
    print(f"[+] Подключился: {client_info}")

    try:
        while True:
            data = client_sock.recv(1024).decode("utf-8").strip()
            if not data:
                break
            print(f"[{client_info}] {data}")
            if data.lower() == "ping":
                client_sock.send("PONG\n".encode("utf-8"))
    except OSError:
        print(f"[-] Клиент {client_info} отключился")
    finally:
        client_sock.close()

