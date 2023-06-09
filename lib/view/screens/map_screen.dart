import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwik/utils/customButton.dart';
import 'package:kwik/view/screens/profile_page.dart';
import 'package:kwik/view/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

List cars = [
  {'id': 0, 'name': 'swipe up'},
  {'id': 1, 'name': 'kwik bike', 'price': 230.0},
  {'id': 2, 'name': 'kwik Auto', 'price': 300.0},
  {'id': 3, 'name': 'kwik XL', 'price': 500.0},
  {'id': 4, 'name': 'kwik pro', 'price': 140.0},
];

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

  int selectedCarId = 0;
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

  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ap = Provider.of<AuthProvider>(context, listen: false);

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
            DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 1,
                snapSizes: [0.2, 1],
                snap: true,
                builder: (BuildContext context, scrollSheetController) {
                  return Container(
                      color: Colors.white,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: ClampingScrollPhysics(),
                        controller: scrollSheetController,
                        itemCount: cars.length,
                        itemBuilder: (BuildContext context, int index) {
                          final car = cars[index];
                          if (index == 0) {
                            return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Divider(
                                        thickness: 5,
                                      ),
                                    ),
                                    Text('')
                                  ],
                                ));
                          }
                          return Card(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              onTap: () {
                                setState(() {
                                  selectedCarId = car['id'];
                                });
                              },
                              leading: Icon(Icons.car_rental),
                              title: Text(car['name']),
                              trailing: Text(
                                car['price'].toString(),
                              ),
                              selected: selectedCarId == car['id'],
                              selectedTileColor: Colors.grey[200],
                            ),
                          );
                        },
                      ));
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            loadData();
          },
          child: Icon(Icons.navigate_next_outlined),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(ap.userModel.profilePic)),
                accountEmail: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(ap.userModel.email),
                ),
                accountName: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                  child: Text(
                    ap.userModel.name,
                    style: TextStyle(fontSize: 21.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {
                  Get.to(ProfilePage());
                },
              ),
              ListTile(
                leading: const Icon(Icons.discount_rounded),
                title: const Text(
                  'Coupons',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: const Text(
                  'Add Money',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.share_rounded),
                title: const Text(
                  'Refferal',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {},
              ),
              Divider(
                thickness: 1,
              ),
              SwitchListTile(
                title: Text('Switch to Driver'),
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
                subtitle: Text('Share and Earn'),
                secondary: Icon(Icons.motorcycle),
                activeColor: Colors.green,
                inactiveTrackColor: Colors.red.shade100,
              ),
            ],
          ),
        ));
  }
}
