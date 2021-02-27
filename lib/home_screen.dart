import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> searchOptions = [
    'Search Set Number',
    'Search Set by Train Number'
  ];

  String searchValue = 'Search Set Number';


  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    final prefs = await SharedPreferences.getInstance();
    Position coordinates = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final latitude = coordinates.latitude;
    final longitude = coordinates.longitude;
    prefs.setDouble('latitude', latitude);
    prefs.setDouble('longitude', longitude);

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF011627),
          leading: Icon(
            Icons.keyboard,
            color: Colors.white,
          ),
          leadingWidth: 40,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/Raster.png',
                color: Colors.white,
                height: 35,
                width: 35,
              ),
              SizedBox(
                width: 5,
              ),
              Text('SERVICE MANAGER'),
            ],
          ),
          actions: [
            Icon(
              Icons.notifications_none_outlined,
              color: Colors.deepPurpleAccent[300],
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              height: 400,
              color: Color(0xFF011627),
            ),
            Container(
              height: mediaQuery.height * 0.8,
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white),
              child: Column(
                children: [
                  Container(
                    width: mediaQuery.width,
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                              value: searchValue,
                              groupValue: searchOptions,
                              onChanged: (value) {
                                searchValue = value;
                              },
                            ),
                            title: Text('Search Set Number'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                              value: searchValue,
                              groupValue: searchOptions,
                              onChanged: (value) {
                                searchValue = value;
                              },
                            ),
                            title: Text('Search Set By Train Number'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0x0F011627)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.red,
                          ),
                          labelText: 'SET NO 232',
                          contentPadding: EdgeInsets.only(left: 5),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    height: mediaQuery.height * 0.5,
                    width: mediaQuery.width * 0.9,
                    decoration: BoxDecoration(
                        color: Color(0xa5505FE1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              height: mediaQuery.height * 0.08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  SizedBox(width: 2,),
                                  Column(
                                    children: [
                                      Text('SIGN ON',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                          )),
                                      Text(
                                        '13:21',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text('KYN',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                  SizedBox(width: 2,),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    dashGapLength: 1,
                                    lineThickness: 0.2,
                                    lineLength: mediaQuery.height * 0.3,
                                  ),
                                  SizedBox(width: 2,),
                                  Column(
                                    children: [
                                      Text('SIGN OFF',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                          )),
                                      Text(
                                        '13:21',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text('KYN',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                  SizedBox(width: 2,),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    dashGapLength: 1,
                                    lineThickness: 0.2,
                                    lineLength: mediaQuery.height * 0.3,
                                  ),
                                  SizedBox(width: 2,),
                                  Column(
                                    children: [
                                      Text('DUTY HRS',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                          )),
                                      Text(
                                        '13:21',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 2,),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    dashGapLength: 1,
                                    lineThickness: 0.2,
                                    lineLength: mediaQuery.height * 0.3,
                                  ),
                                  SizedBox(width: 2,),
                                  Column(
                                    children: [
                                      Text('KMS',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                          )),
                                      Text(
                                        '13:21',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 2,),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    dashGapLength: 1,
                                    lineThickness: 0.2,
                                    lineLength: mediaQuery.height * 0.3,
                                  ),
                                  SizedBox(width: 2,),
                                  Column(
                                    children: [
                                      Text('NDH',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400
                                          )),
                                      Text(
                                        '13:21',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 2,),
                                ],
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Container(
                                height: mediaQuery.height * 0.075,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                child: Center(
                                  child: Text(
                                    '232',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 5,)
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          height: mediaQuery.height * 0.3,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 4),
                                child: Column(
                                  children: [
                                    Text(
                                      'Train No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'S',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.brown),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '90001',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'F',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.green),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '90002',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'S',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.brown),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '90003',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.vertical,
                                dashGapLength: 1,
                                lineThickness: 0.2,
                                lineLength: mediaQuery.height * 0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 4),
                                child: Column(
                                  children: [
                                    Text(
                                      'START',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'KYN',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '16:56',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'CSMT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '16:56',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'ASO',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '16:56',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.vertical,
                                dashGapLength: 1,
                                lineThickness: 0.2,
                                lineLength: mediaQuery.height * 0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 4),
                                child: Column(
                                  children: [
                                    Text(
                                      'CHANGE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'CSMT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '16:56',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'ASO',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '16:56',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'KYN',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '16:56',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.vertical,
                                dashGapLength: 1,
                                lineThickness: 0.2,
                                lineLength: mediaQuery.height * 0.3,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                          height: mediaQuery.height * 0.05,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Color(0xFF8FB339),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Add To Roaster',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Color(0xFFF95F62),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.notifications,
                                          color: Colors.blue,
                                        ),
                                        Text(
                                          'SET REMINDER',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () {},
            color: Colors.purple[200],
            iconSize: 35,
          ),
          onPressed: () {},
          backgroundColor: Colors.grey[300],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.red[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5,),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
                color: Colors.white,
                iconSize: 35,
              ),
              SizedBox(width: 5,),
              IconButton(
                icon: Icon(Icons.train),
                onPressed: () {},
                color: Colors.white,
                iconSize: 35,
              ),
              SizedBox(width: 5,),
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () {},
                color: Colors.white,
                iconSize: 35,
              ),
              SizedBox(width: 5,),
              IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () {},
                color: Colors.white,
                iconSize: 35,
              ),
              SizedBox(width: 5,),
              // IconButton(
              //   icon: Icon(Icons.person),
              //   onPressed: () {},
              //   color: Colors.white,
              //   iconSize: 35,
              // ),
            ],
          ),
          notchMargin: 4.0,
          shape: CircularNotchedRectangle(),
        )
      // BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: 'Person'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Person'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Person'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Person'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Person')
      //   ],
      //   backgroundColor: Colors.red[900],
      // ),
    );
  }
}
