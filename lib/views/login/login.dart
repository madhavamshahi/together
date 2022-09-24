import 'package:carely/views/widgets/googleSignin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                      'Care-ly',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We're in this together ❤️.",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Image.asset(
                      'assets/images/illus6.png',
                      height: 200,
                    ),
                    Text(
                      'Login to continue',
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    GoogleSignInButton(),
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
