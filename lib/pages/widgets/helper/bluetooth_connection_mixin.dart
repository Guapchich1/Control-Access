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
    
    if (isConnected) {
      if (command != null) {
        bool commandSent = await BluetoothService().sendCommand(command);
        if (commandSent) {
          onSuccess();
        } else {
          _showErrorSnackBar(
            context, 
            errorMessage ?? 'Ошибка выполнения команды'
          );
        }
      } else {
        onSuccess();
      }
    } else {
      _showErrorSnackBar(
        context,
        'Нет соединения с сервером. Проверьте Bluetooth'
      );
    }
  }

  /// Проверяет соединение и показывает соответствующее сообщение
  Future<void> checkConnectionAndNotify(
    BuildContext context,
    String command,
    String successMessage,
  ) async {
    bool isConnected = await BluetoothService().checkServerConnection();
    
    if (isConnected) {
      bool commandSent = await BluetoothService().sendCommand(command);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(commandSent ? successMessage : 'Ошибка выполнения команды'),
          backgroundColor: commandSent ? Colors.green : Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      _showErrorSnackBar(context, 'Нет соединения с сервером');
    }
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
