import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressPage extends StatefulWidget {
  final double lat;
  final double lang;
  const AddressPage({required this.lat, required this.lang});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController address4 = TextEditingController();
  TextEditingController address5 = TextEditingController();
  Future getAddress() async {
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(52.2165157, 6.9437819);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.lat, widget.lang);
    print(placemarks);
    Placemark getDetails = placemarks[0];
    print(getDetails);
    setState(() {
      address1.text = getDetails.street.toString();
      address2.text = getDetails.administrativeArea.toString();
      address3.text = getDetails.locality.toString();
      address4.text = getDetails.postalCode.toString();
      address5.text = getDetails.country.toString();
    });
  }

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Address", style: TextStyle(fontSize: 30)),
                ),
                TextField(
                  controller: address1,
                  decoration: InputDecoration(
                      label: Text("address1"), border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: address2,
                  decoration: InputDecoration(
                      label: Text("address2"), border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: address3,
                  decoration: InputDecoration(
                      label: Text("address3"), border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: address4,
                  decoration: InputDecoration(
                      label: Text("address4"), border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: address5,
                  decoration: InputDecoration(
                      label: Text("address5"), border: OutlineInputBorder()),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return super.widget;
                    }));
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
