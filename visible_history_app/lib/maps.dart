import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class MyCustomMap extends StatefulWidget {
  const MyCustomMap({super.key});

  @override
  State<MyCustomMap> createState() => _MyCustomMapState();
}

class _MyCustomMapState extends State<MyCustomMap> {
  late Position position;
  late StreamSubscription<Position> positionStream;
  late LocationPermission permission;
  bool serviceStatus = false;
  bool hasPermission = false;
  double long = 0, lat = 0;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == await LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print("Permission denied");
        } else if (permission == LocationPermission.deniedForever) {
          print("permission denied forever");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh UI
        });
        getLocation();
      }
    } else {
      print("GPS not enabled");
    }

    setState(() {
      //refresh UI
    });
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();

    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      //refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Locations"),
          elevation: 2,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            //the zoom works as 0 is the screen width of the world is 256
            //zoom 1.0 the screen width of the world is: 2¹ * 256
            //zoom 2.0 the screen width of the world is: 2² * 256
            // and so on which means: at zoom 8.0 the width is: 2⁸ * 256
            zoom: 20.0,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
