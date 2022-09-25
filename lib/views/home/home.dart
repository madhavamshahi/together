import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:filter_list/filter_list.dart';
import 'package:together/models/userModel.dart';
import 'package:together/services/geoService.dart';
import 'package:geolocator/geolocator.dart';
import '../article/articleview.dart';
import '../widgets/sameBox.dart';
import '../widgets/userProfileView.dart';

List<String> selectedList = ["Maths"];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _openFilterDialog({required BuildContext context}) async {
    await FilterListDialog.display<String>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select medical conditions',
      height: 500,
      listData: diseases,
      selectedListData: selectedList,
      choiceChipLabel: (item) {
        String g = item as String;
        return g;
      },
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (sub, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        String? f = sub as String;
        return f.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedList = List.from(list!);
        });
        print(selectedList);
        Navigator.pop(context);
      },
    );
  }

  List<String> diseases = [
    "Stomach Flu",
    "Hand,Foot,Mouth Disease",
    "Febrile Seizures",
    "Chickenpox",
    "Eczema",
    "Asthma",
    "Allergic Rhinitis",
    "Cancer",
    "Constipation",
    "Bone Fracture",
    "Depression",
  ];

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  bool isOpened = false;

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

// get the collection reference or query
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Container(
        margin: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        toggleMenu(true);
                      },
                      child: Icon(FontAwesomeIcons.bars)),
                ),
                Center(
                    child: Text(
                  "Find parents nearby",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: IconButton(
                      onPressed: () {
                        _openFilterDialog(context: context);
                      },
                      icon: Icon(FontAwesomeIcons.filter, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: ((context, AsyncSnapshot snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snap.hasError) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snap.hasData) {
                    Map data = snap.data.data() as Map;

                    GeoService geoo = GeoService();

                    return FutureBuilder<Position>(
                        future: geoo.determinePosition(),
                        builder: (context, snap) {
                          if (snap.hasData) {
                            final geo = Geoflutterfire();

                            GeoFirePoint center = geo.point(
                                latitude: snap.data!.latitude,
                                longitude: snap.data!.longitude);

                            // Create a geoFirePoint

                            // get the collection reference or query
                            var collectionReference =
                                FirebaseFirestore.instance.collection('users');

                            double radius = 50;
                            String field = 'position';

                            Stream<List<DocumentSnapshot>> stream = geo
                                .collection(collectionRef: collectionReference)
                                .within(
                                    center: center,
                                    radius: radius,
                                    field: field);

                            return StreamBuilder(
                                stream: stream,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .where('disease',
                                                arrayContainsAny: selectedList)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot> snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (snap.hasError) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          if (snap.hasData) {
                                            return ListView.builder(
                                                itemCount:
                                                    snap.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  Map data = {};
                                                  data = snap.data!.docs[index]
                                                      .data() as Map;

                                                  UserModel model =
                                                      UserModel.fromJson(data);

                                                  return SameBox(model: model);
                                                });
                                          }

                                          return Container();
                                        });
                                  }

                                  if (!snap.hasData) {
                                    return Center(
                                        child: Text("No nearby people"));
                                  }

                                  return CircularProgressIndicator();
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  }

                  return Container();
                }),
              ),
            )

            // Expanded(
            //   child: ListView.builder(itemBuilder: (context, int n) {
            //     return BuddyBox();
            //   }),
            // )
          ],
        ),
      ),
      UserProfileView(),
    ];

    return SideMenu(
      key: _endSideMenuKey,
      type: SideMenuType.slide,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.orange,
                hoverColor: Colors.orange,
                gap: 8,
                activeColor: Colors.blueAccent,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: FontAwesomeIcons.house,
                    text: 'Home',
                    iconColor: Colors.orange,
                  ),
                  GButton(
                    icon: FontAwesomeIcons.user,
                    iconColor: Colors.orange,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildMenu() {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(vertical: 50.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22.0,
              ),
              SizedBox(height: 16.0),
              Text(
                "Hello, John Doe",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
          title: const Text("Home"),
          textColor: Colors.white,
          dense: true,
        ),
        ListTile(
          onTap: () {},
          leading:
              const Icon(Icons.verified_user, size: 20.0, color: Colors.white),
          title: const Text("Profile"),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.monetization_on,
              size: 20.0, color: Colors.white),
          title: const Text("Wallet"),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        ListTile(
          onTap: () {},
          leading:
              const Icon(Icons.shopping_cart, size: 20.0, color: Colors.white),
          title: const Text("Cart"),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        ListTile(
          onTap: () {},
          leading:
              const Icon(Icons.star_border, size: 20.0, color: Colors.white),
          title: const Text("Favorites"),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.settings, size: 20.0, color: Colors.white),
          title: const Text("Settings"),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
      ],
    ),
  );
}
