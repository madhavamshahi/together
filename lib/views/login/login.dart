import 'package:together/views/widgets/googleSignin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String major = "Stomach Flu";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Together ❤️',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We're in this together",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          "https://media.giphy.com/media/26BRv0ThflsHCqDrG/giphy.gif"),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "Please select the medical treatment you're looking for your child.",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(color: Colors.white),
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.0)),
                          ),
                        ),
                        popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: [
                          "Stomach Flu",
                          "Hand,Foot,Mouth Disease",
                          "Febrile Seizures",
                          "Chickenpox",
                          "Eczema",
                          "Cough",
                          "Asthma",
                          "Allergic Rhinitis",
                          "Cancer",
                          "Constipation",
                          "Bone Fracture",
                          "Depression",
                        ],
                        onChanged: (String? s) {
                          setState(() {
                            major = s!;
                          });

                          print(major);
                        },
                        selectedItem: "Cough",
                      ),
                    ),
                    GoogleSignInButton(
                      major: major,
                    ),
                    SizedBox(height: 200),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
