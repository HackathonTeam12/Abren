import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapWidget extends StatefulWidget {
  final List<String> images;

  const MapWidget({Key key, this.images}) : super(key: key);
  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onStyleLoaded() {
    widget.images.forEach((element) {
      addImageFromAsset("assetImage", element);
    });
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  void addSymbol(LatLng geometry, String image) {
    mapController.addSymbol(SymbolOptions(
      geometry: geometry,
      iconImage: image,
    ));
  }

  void addLine(List<LatLng> geometry, String color) {
    mapController.addLine(
      LineOptions(
          geometry: geometry,
          lineColor: color,
          lineWidth: 7.0,
          lineOpacity: 0.6,
          draggable: true),
    );
  }

  void removeAll() {
    mapController.removeSymbols(mapController.symbols);
  }

//  Future<LocationData> locationFuture;
//  Future<LocationData> getLocation() async {
//    Location location = new Location();
//
//    bool _serviceEnabled;
//    PermissionStatus _permissionGranted;
//
//    _serviceEnabled = await location.serviceEnabled();
//    if (!_serviceEnabled) {
//      _serviceEnabled = await location.requestService();
//      if (!_serviceEnabled) {
//        return null;
//      }
//    }
//
//    _permissionGranted = await location.hasPermission();
//    if (_permissionGranted == PermissionStatus.DENIED) {
//      //TODO: Handle better
//      _permissionGranted = await location.requestPermission();
//      if (_permissionGranted != PermissionStatus.GRANTED) {
//        return null;
//      }
//    }
//
//    return await location.getLocation();
//  }

//  @override
//  void initState() {
//    locationFuture = getLocation();
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
              onMapClick: (point, latlng) {
                print(latlng);
              },
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: _onStyleLoaded,
              styleString: "mapbox://styles/lydiag/ckbey6dzy3mmj1ipgwlpmi7sv",
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(9.003083, 38.818455),
                  zoom: 13),
              myLocationEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            );

  }
}
