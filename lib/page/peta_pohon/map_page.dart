import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/data_pohon_provider.dart';
import '../../models/data_pohon.dart';
import '../../constants/colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = const LatLng(-4.0167, 120.1833); // Pare, Sulawesi

  MapType _currentMapType = MapType.satellite;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(LatLng pos) {
    // Biar cuma tambah marker dari AddDataPage, kosongin dulu
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
            // Dropdown pilihan tipe peta
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8), // lebih ke atas
              child: Row(
                children: [
                  const Text('Tipe Peta:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.white),
                    ),
                    child: DropdownButton<MapType>(
                      value: _currentMapType,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      dropdownColor: Colors.white,
                      items: const [
                        DropdownMenuItem(child: Text('Normal', style: TextStyle(color: Colors.black)), value: MapType.normal),
                        DropdownMenuItem(child: Text('Satelit', style: TextStyle(color: Colors.black)), value: MapType.satellite),
                        DropdownMenuItem(child: Text('Terrain', style: TextStyle(color: Colors.black)), value: MapType.terrain),
                        DropdownMenuItem(child: Text('Hybrid', style: TextStyle(color: Colors.black)), value: MapType.hybrid),
                      ],
                      onChanged: (type) {
                        setState(() {
                          _currentMapType = type!;
                        });
                      },
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
                  child: Consumer<DataPohonProvider>(
                    builder: (ctx, provider, _) {
                      Set<Marker> markers = {};
                      for (var pohon in provider.pohonList) {
                        print('DEBUG pohon: id=${pohon.id}, koordinat=${pohon.koordinat}, nama=${pohon.namaPohon}');
                        if (pohon.koordinat.isEmpty || !pohon.koordinat.contains(',')) {
                          print('SKIP pohon id=${pohon.id} karena koordinat kosong/salah format');
                          continue;
                        }
                        List<String> coords = pohon.koordinat.split(',');
                        if (coords.length != 2) {
                          print('SKIP pohon id=${pohon.id} karena koordinat tidak dua angka');
                          continue;
                        }
                        double? lat = double.tryParse(coords[0]);
                        double? lng = double.tryParse(coords[1]);
                        if (lat == null || lng == null) {
                          print('SKIP pohon id=${pohon.id} karena gagal parsing koordinat');
                          continue;
                        }
                        markers.add(Marker(
                          markerId: MarkerId(pohon.id),
                          position: LatLng(lat, lng),
                          infoWindow: InfoWindow(title: pohon.namaPohon),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                        ));
                      }
                      print('DEBUG total marker: ${markers.length}');

                      return GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 20.0, // zoom maksimal
                        ),
                        mapType: _currentMapType,
                        minMaxZoomPreference: const MinMaxZoomPreference(15.0, 21.0),
                        markers: markers,
                        onTap: _addMarker,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}