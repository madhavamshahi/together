import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../models/userModel.dart';

class SameBox extends StatelessWidget {
  const SameBox({Key? key, required this.model}) : super(key: key);

  final UserModel model;
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMMd');
    final String formatted = formatter.format(now);

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7),
            topRight: Radius.circular(7),
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(model.url),
              ),
              SizedBox(height: 15),
              Text(
                formatted,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name),
                SizedBox(
                  height: 5,
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 5),
                //   child: Text(
                //     "${model.desc}",
                //     maxLines: 3,
                //     overflow: TextOverflow.ellipsis,
                //     style: GoogleFonts.josefinSans(
                //       textStyle: TextStyle(
                //         fontSize: 12,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _launchURL(model.email);
            },
            child: Icon(
              FontAwesomeIcons.message,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}

_launchURL(String phn) async {
  String url = 'sms:$phn';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
