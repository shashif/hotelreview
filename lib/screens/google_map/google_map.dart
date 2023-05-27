

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hotel_review/providers/free_post_provider.dart';
import 'package:location/location.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../../../widgets/color_widget.dart';

class CostomGoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<CostomGoogleMap> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude!, event.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    FreePostProvider freePostProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        await _location.getLocation().then((value) {
                          if (value != null) {
                            setState(() {
                              freePostProvider.setLoaction = value;
                            });
                          }
                        });
                        Navigator.of(context).pop();
                      } catch (e) {
                        print('Error: $e');
                        // Handle the error gracefully, e.g., show an error message to the user.
                      }
                    },

                    color: primaryColor,
                    child: Text("Set Location"),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
