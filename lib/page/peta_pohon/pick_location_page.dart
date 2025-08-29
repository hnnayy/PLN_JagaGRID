import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationPage extends StatefulWidget {
  @override
  _PickLocationPageState createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  GoogleMapController? _mapController;
  LatLng? _selectedPosition;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Lokasi Pohon')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(-4.0167, 120.1833), // Pare default
          zoom: 11.0,
        ),
        onTap: (pos) {
          setState(() {
            _selectedPosition = pos;
          });
        },
        markers: _selectedPosition == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId('selected'),
                  position: _selectedPosition!,
                ),
              },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedPosition != null) {
            Navigator.pop(context, '${_selectedPosition!.latitude},${_selectedPosition!.longitude}');
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}