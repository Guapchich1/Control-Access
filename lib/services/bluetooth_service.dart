import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';

class BluetoothService {
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;
  BluetoothService._internal();

  BluetoothConnection? _connection;
  BluetoothDevice? _targetDevice;
  bool _isConnecting = false;

  // Поток для входящих данных
  late StreamController<String> _inputController;

  // MAC адрес сервера
  final String targetDeviceAddress = "80:AF:CA:CC:91:DF"; // Заменить на MAC

  Future<bool> checkServerConnection() async {
    // Если соединение есть, пробуем пинг
    if (_connection?.isConnected == true) {
      try {
        bool ping = await _pingServer();
        if (ping) return true;
        // Пинг не прошёл, соединение разорвано
        await _resetConnection();
      } catch (_) {
        await _resetConnection();
      }
    }
    return await _connectAndPing(); // Создаём новое соединение
  }

  // Сброс соединения
  Future<void> _resetConnection() async {
    try {
      await _connection?.close();
    } catch (_) {}
    _connection = null;
    // Закрываем старый контроллер потока
    try {
      await _inputController.close();
    } catch (_) {}
  }

  Future<bool> _connectAndPing() async {
    try {
      if (_isConnecting) return false;
      _isConnecting = true;

      await _findTargetDevice(); // Ищем устройство среди привязанных
      if (_targetDevice == null) {
        _isConnecting = false;
        return false;
      }

      _connection = await BluetoothConnection.toAddress(
        targetDeviceAddress,
      ); // Устанавливаем соединение
      _inputController = StreamController<String>.broadcast();
      _connection!.input!.listen(
        (Uint8List data) {
          final text = utf8.decode(data);
          _inputController.add(text);
        },
        onDone: () async {
          // Если соединение закрылось со стороны сервера
          await _resetConnection();
        },
      );

      // Проверяем ping
      bool pingResult = await _pingServer();
      _isConnecting = false;
      return pingResult;
    } catch (e) {
      _isConnecting = false;
      print('Bluetooth connection error: $e');
      return false;
    }
  }

  // Найти устройство среди спаренных
  Future<void> _findTargetDevice() async {
    try {
      List<BluetoothDevice> bondedDevices = await FlutterBluetoothSerial
          .instance
          .getBondedDevices();

      _targetDevice = bondedDevices.firstWhere(
        (device) => device.address == targetDeviceAddress,
        orElse: () => BluetoothDevice(name: null, address: targetDeviceAddress),
      );
    } catch (e) {
      print('Error finding target device: $e');
    }
  }

  // Отправляем ping
  Future<bool> _pingServer() async {
    if (_connection?.isConnected != true) return false;

    _connection!.output.add(Uint8List.fromList(utf8.encode("ping\n")));
    await _connection!.output.allSent;

    // Ждём ответа
    try {
      final response = await _inputController.stream
          .firstWhere((s) => s.toLowerCase().contains('pong'))
          .timeout(Duration(seconds: 5));
      return response.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // Отправить любую команду
  Future<Map<String, dynamic>> sendCommand(String command) async {
    try {
      if (_connection == null || !_connection!.isConnected) {
        if (!await _connectAndPing()) {
          return {"status": "error", "message": "Нет соединения"};
        }
      }

      _connection!.output.add(Uint8List.fromList(utf8.encode("$command\n")));
      await _connection!.output.allSent;

      // Ждём ответа JSON
      final responseStr = await _inputController.stream
          .firstWhere((s) => s.trim().isNotEmpty)
          .timeout(Duration(seconds: 30));

      return json.decode(responseStr);
    } catch (e) {
      print('Send command error: $e');
      return {"status": "error", "message": e.toString()};
    }
  }

  // Принудительное отключение
  Future<void> disconnect() async {
    try {
      await _connection?.close();
      _connection = null;
    } catch (e) {
      print('Disconnect error: $e');
    }
  }

  // Проверка на блютуз
  Future<bool> isBluetoothEnabled() async {
    try {
      return await FlutterBluetoothSerial.instance.isEnabled ?? false;
    } catch (e) {
      return false;
    }
  }
}
