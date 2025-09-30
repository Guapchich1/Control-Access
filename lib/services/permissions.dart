import 'package:permission_handler/permission_handler.dart';

Future<void> requestBluetoothPermissions() async {
  // нужно для android 12+
  if (await Permission.bluetoothScan.isDenied) {
    await Permission.bluetoothScan.request();
  }
  if (await Permission.bluetoothConnect.isDenied) {
    await Permission.bluetoothConnect.request();
  }
  if (await Permission.bluetoothAdvertise.isDenied) {
    await Permission.bluetoothAdvertise.request();
  }

  if (await Permission.locationWhenInUse.isDenied) {
    await Permission.locationWhenInUse.request();
  }
}
