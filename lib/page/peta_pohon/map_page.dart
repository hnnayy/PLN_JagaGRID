
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/colors.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = const LatLng(-4.0167, 120.1833); // Pare, Sulawesi
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('pare'),
        position: _initialPosition,
        infoWindow: const InfoWindow(title: 'Pare, Sulawesi'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tealGelap,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 18, left: 0, right: 0, bottom: 8),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.tealGelap,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      'Peta Pohon',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.yellow,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/addData');
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.cyan,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Map Fullscreen
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: GoogleMap(
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
                ),
              ),
            ),
          ],
        ),
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