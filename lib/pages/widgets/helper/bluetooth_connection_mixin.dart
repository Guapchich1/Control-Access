import 'package:flutter/material.dart';
import 'package:flutter_project/services/bluetooth_service.dart';

mixin BluetoothConnectionMixin {
  
  /// Проверяет соединение и выполняет действие при успехе
  Future<void> executeWithConnection(
      BuildContext context,
      VoidCallback onSuccess, {
        String? command,
        String? errorMessage,
      }) async {
    bool isConnected = await BluetoothService().checkServerConnection();

    if (!isConnected) {
      _showErrorSnackBar(context, 'Нет соединения с сервером. Проверьте Bluetooth');
      return;
    }

    if (command != null) {
      final response = await BluetoothService().sendCommand(command);
      // response — это Map<String, dynamic> с сервера
      if (response != null && response['status'] == 'ok') {
        onSuccess();
      } else {
        _showErrorSnackBar(
          context,
          response != null ? response['message'] : (errorMessage ?? 'Ошибка выполнения команды'),
        );
      }
    } else {
      onSuccess();
    }
  }

  /// Отправляет команду и возвращает ответ сервера
  Future<Map<String, dynamic>?> executeWithResponse(
      BuildContext context, {
        required String command,
        String? errorMessage,
      }) async {
    bool isConnected = await BluetoothService().checkServerConnection();

    if (!isConnected) {
      _showErrorSnackBar(context, 'Нет соединения с сервером. Проверьте Bluetooth');
      return null;
    }

    final response = await BluetoothService().sendCommand(command);

    if (response == null) {
      _showErrorSnackBar(context, errorMessage ?? 'Ошибка выполнения команды');
      return null;
    }

    return response;
  }

  /// Проверяет соединение и показывает соответствующее сообщение
  Future<void> checkConnectionAndNotify(
      BuildContext context,
      String command,
      String successMessage,
      ) async {
    bool isConnected = await BluetoothService().checkServerConnection();

    if (!isConnected) {
      _showErrorSnackBar(context, 'Нет соединения с сервером');
      return;
    }

    final response = await BluetoothService().sendCommand(command);

    bool success = response['status'] == 'ok';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? successMessage : response['message'] ?? 'Ошибка выполнения команды'),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }


  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
