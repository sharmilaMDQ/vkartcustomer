import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';

class MapExample extends StatefulWidget {
  const MapExample({super.key});

  @override
  State<MapExample> createState() => _MapExampleState();
}



class _MapExampleState extends State<MapExample> {

  LatLng mylatlong = LatLng( 26.850000, 80.949997);
  String address = 'Lucknow';
  final googleMapController = Completer<GoogleMapController>();

  setMarker(LatLng value)async{
    mylatlong = value;

    List<Placemark> result  = await placemarkFromCoordinates(value.latitude, value.longitude);

    if (result.isNotEmpty){
      address ='${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}';
    }

    setState(() {});
    Fluttertoast.showToast(msg: '📍'+ address);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target: mylatlong,
            zoom: 12
        ),
        onMapCreated: (GoogleMapController controller) => googleMapController.complete(controller),
        markers: {
          Marker(
              infoWindow: InfoWindow(title: address),
              position: mylatlong,
              draggable: true,
              markerId: MarkerId('1'),
              onDragEnd: (value){
                print(value);
                setMarker(value);
              }
          ),
        },

        onTap: (value){
          setMarker(value);
        },

      ),

    );
  }
}