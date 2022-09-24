// import 'package:carely/views/widgets/widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:carely/services/auth.dart';
// import 'package:carely/services/services.dart';

// passReset({
//   required BuildContext context,
// }) {
//   TextEditingController cont = TextEditingController();

//   return Alert(
//       context: context,
//       title: "Send password reset link",
//       content: Column(
//         children: <Widget>[
//           TextField(
//             controller: cont,
//             decoration: InputDecoration(
//               icon: Icon(Icons.email),
//               labelText: 'Email',
//             ),
//           ),
//         ],
//       ),
//       buttons: [
//         DialogButton(
//           onPressed: () async {
//             if (await hasConnection()) {
//               Auth auth = Auth();

//               await auth.passReset(email: cont.text);
//               showToast(
//                   toast: "Link Sent", context: context, color: Colors.green);
//             } else {
//               showToast(
//                   toast: "No internet connection",
//                   context: context,
//                   color: Colors.red);
//             }
//           },
//           child: Text(
//             "Send",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         )
//       ]).show();
// }
