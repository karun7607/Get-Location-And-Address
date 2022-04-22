import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:task02/address_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScrn(),
    );
  }
}

class HomeScrn extends StatefulWidget {
  const HomeScrn({Key? key}) : super(key: key);

  @override
  State<HomeScrn> createState() => _HomeScrnState();
}

class _HomeScrnState extends State<HomeScrn> {
  String currentlocation = "location";
  double? _latitude;
  double? _longitude;
  Future getcurrentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      currentlocation =
          ("latitude: ${position.latitude}, longtitude: ${position.longitude}");
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.location_pin,
              color: Colors.blue,
              size: 60,
            ),
          ),
          Text(currentlocation),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () {
                  _determinePosition();
                  getcurrentlocation();
                },
                child: Text("Get Location"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddressPage(lat: _latitude!, lang: _longitude!)));
                },
                child: Text("Get Address"),
                color: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }
}
