import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = const LatLng(-4.0167, 120.1833);  // Pare, Sulawesi
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Tambahkan marker contoh
    _markers.clear(); // Clear existing markers if needed
    _markers.add(
      Marker(
        markerId: const MarkerId('pare'),
        position: _initialPosition,
        infoWindow: const InfoWindow(title: 'Pare, Sulawesi'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
  _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Pohon'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addData');
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 11.0,
        ),
        markers: _markers,
        onTap: _addMarker,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman tambah data jika ada
        },
        child: const Icon(Icons.add_location),
      ),
    );
  }
  void _addMarker(LatLng pos) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(pos.toString()),
          position: pos,
          infoWindow: InfoWindow(
            title: 'Marker',
            snippet: '(${pos.latitude}, ${pos.longitude})',
          ),
        ),
      );
    });
  }
}