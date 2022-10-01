import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: GestureDetector(
        child: Container(
          height: 50,
          width: 100,
          color: Colors.greenAccent.shade700,
          child: Center(child: Text('Connect')),
        ),
        onTap: onTap,
        //color: Colors.greenAccent,
      ),
    );
  }
}
