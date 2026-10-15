import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_store/core/util/styles.dart';

import 'package:my_store/feature/payment/presentation/view/new_address_view/custom_bottom_sheet.dart';

class NewAddressView extends StatefulWidget {
  const NewAddressView({super.key});

  @override
  State<NewAddressView> createState() => _NewAddressViewState();
}

class _NewAddressViewState extends State<NewAddressView> {
  LatLng? selectedLocation;
  String addressText = 'No Address Selected yet';
  Future<void> getAddressFromLatLng(LatLng point) async {
    try {
      List<Placemark> placeMark = await Geocoding().placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      if (placeMark.isNotEmpty) {
        setState(() {
          addressText =
              '${placeMark[0].street} ,${placeMark[0].locality}';
        });
      }
    } catch (e) {
      addressText =
          'Lat: ${point.latitude.toStringAsFixed(4)}, Lng: ${point.longitude.toStringAsFixed(4)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: (context),
            builder: (context) => CustomBottomSheet(fullAddressText: addressText),
          );
        },
        child: const Icon(Icons.location_on),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Address', style: Styles.textStyle32),
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: (tapPosition, point) {
            setState(() {
              getAddressFromLatLng(point);
              selectedLocation = point;
            });
          },
          initialCenter: const LatLng(36.206892, 37.147481),
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
            userAgentPackageName: 'com.example.my_store',
          ),
          if (selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selectedLocation!,
                  child: const Icon(Icons.location_on, size: 64, color: Colors.red),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
