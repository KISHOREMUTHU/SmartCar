import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.devices,size: 27,color: Colors.black),
        title: Text(device.name ?? "Unknown device",
         style: GoogleFonts.montserrat(fontSize: 18,color: Colors.black),
        ),
        subtitle: Text(device.address.toString(), style:GoogleFonts.montserrat(color: Colors.black)),
        trailing: GestureDetector(
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade700,
              borderRadius: BorderRadius.circular(15)
            ),

            child: Center(child: Text('Connect',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16),)),
          ),
          onTap: onTap,
          //color: Colors.greenAccent,
        ),
      ),
    );
  }
}
