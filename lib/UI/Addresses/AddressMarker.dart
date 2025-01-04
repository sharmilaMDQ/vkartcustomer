import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMarkerWidget extends StatelessWidget {
  CustomMarkerWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Order will be delivered here',
                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                'Place the pin accurately on the map',
                style: TextStyle(fontSize: 8, color: Colors.white),
              )
            ],
          ).paddingAll(2),
        ),
        Icon(CupertinoIcons.location_solid, size: 40.0, color: Colors.black),
        SizedBox(
          height: 90,
        )
      ],
    );
  }
}
