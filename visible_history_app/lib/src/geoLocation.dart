import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MyGeoApp extends StatefulWidget {
  const MyGeoApp({super.key});
  @override
  State<MyGeoApp> createState() => GeoState();
}

class GeoState extends State<MyGeoApp> {
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print("Location permission denied");
        } else if (permission == LocationPermission.deniedForever) {
          print("Location permission denied forever");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS not enabled");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude);
    print(position.latitude);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh the UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude);
      print(position.latitude);

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh the UI
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get GPS Location"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            Text(serviceStatus ? "GPS Enabled" : "GPS Disabled"),
            Text(hasPermission ? "GPS Enabled" : "GPS Disabled"),
            Text("Longitude: $long", style: TextStyle(fontSize: 20)),
            Text("Latitude: $lat", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
