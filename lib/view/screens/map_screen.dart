import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwik/utils/customButton.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(21.5982359, 73.0157957), zoom: 15.5);

  final List<Marker> _markers = const <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(21.5982359, 73.0157957),
        infoWindow: InfoWindow(title: 'You'))
  ];

  final _pickcontroller = TextEditingController();
  final _dropController = TextEditingController();
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(21.5982359, 73.0157957), zoom: 15.5);
  @override
  void dispose() {
    _pickcontroller.dispose();
    _dropController.dispose();
    super.dispose();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());
      _markers.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: "Me")));
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(
        value.latitude,
        value.longitude,
      ));

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: _initialCameraPosition),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              child: Icon(Icons.menu),
                              onTap: () =>
                                  _scaffoldKey.currentState?.openDrawer(),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(17, 0, 0, 0),
                        width: screenSize.width * 0.7,
                        height: screenSize.height * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.adjust_rounded,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _pickcontroller,
                                        onTap: () async {},
                                        decoration: InputDecoration(
                                            hintText: 'Search Location',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.grey.shade100,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _dropController,
                                        onTap: () async {},
                                        decoration: InputDecoration(
                                            hintText: 'Drop Location',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadData();
        },
        child: Icon(Icons.location_searching_rounded),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
              child: Container(
            color: Colors.red,
          )),
          ListTile(
            title: Text('Page1'),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            title: Text('Page2'),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            title: Text('Page2'),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      )),
    );
  }
}
