// import 'package:gold247/constant/constant.dart';
// import 'package:gold247/main.dart';
// import 'package:gold247/pages/screens.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:gold247/language/locale.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gold247/models/user.dart';
// import 'package:intl/intl.dart';

// class Register extends StatefulWidget {
//   String id;
//   Register({this.id});
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final dobController = TextEditingController();
//   final panController = TextEditingController();
//   final refferController = TextEditingController();
//   final pan = TextEditingController();
//   FocusNode firstFocusNode = FocusNode();
//   FocusNode secondFocusNode = FocusNode();
//   FocusNode thirdFocusNode = FocusNode();
//   FocusNode fourthFocusNode = FocusNode();
//   DateTime selectedDate = DateTime.now();
//   String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
//   register() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return Dialog(
//           elevation: 0.0,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           child: Wrap(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SpinKitRing(
//                       color: primaryColor,
//                       size: 40.0,
//                       lineWidth: 1.2,
//                     ),
//                     SizedBox(height: 25.0),
//                     Text(
//                       'Please Wait..',
//                       style: grey14MediumTextStyle,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//     if (nameController.text == "") {
//       Navigator.pop(context, true);
//       Fluttertoast.showToast(
//         msg: 'Full Name Not Specified.',
//         backgroundColor: Colors.black,
//         textColor: whiteColor,
//       );
//       return FocusScope.of(context).requestFocus(firstFocusNode);
//     }
//     if (emailController.text == "" ||
//         !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//             .hasMatch(emailController.text)) {
//       Navigator.pop(context, true);
//       Fluttertoast.showToast(
//         msg: 'Email Not Specified.',
//         backgroundColor: Colors.black,
//         textColor: whiteColor,
//       );
//       return FocusScope.of(context).requestFocus(secondFocusNode);
//     }
//     if (dobController.text == "") {
//       Navigator.pop(context, true);
//       Fluttertoast.showToast(
//         msg: 'Date Of Birth Not Specified.',
//         backgroundColor: Colors.black,
//         textColor: whiteColor,
//       );
//       return FocusScope.of(context).requestFocus(thirdFocusNode);
//     }
//     if (pan.text != "") {
//       if (await verifyPan(pan.text) == true) {
//         Fluttertoast.showToast(
//           msg: 'PAN NUMBER VERIFIED',
//           backgroundColor: Colors.black,
//           textColor: whiteColor,
//         );
//       } else {
//         Navigator.pop(context, true);
//         Fluttertoast.showToast(
//           msg: 'PAN NUMBER INVALID',
//           backgroundColor: Colors.black,
//           textColor: whiteColor,
//         );
//         return FocusScope.of(context).requestFocus(fourthFocusNode);
//       }
//     }
//     http.Response response = await http.put(
//       Uri.parse("${baseurl}/api/user/" + widget.id),
//       body: {
//         "fname": nameController.text.toUpperCase(),
//         "email": emailController.text,
//         "dob": dobController.text,
//         "refCode": refferController.text,
//         "pan": pan.text.toUpperCase(),
//         "deviceToken": deviceToken
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseString = json.decode(response.body);
//       Map datas = responseString;
//       setState(() {
//         Userdata = userdata.fromJson(datas);
//       });
//       Navigator.push(context,
//           PageTransition(type: PageTransitionType.fade, child: BottomBar()));
//     }
//   }

//   Future<String> getAccessToken() async {
//     var headers = {
//       'x-api-key': 'key_live_1XilWqECfePBMRzHKIfj4719kkc7q7C4',
//       'x-api-secret': 'secret_live_x9NUTRidCJAidEDRj4JT9VyMwgcttZ2x',
//       'x-api-version': '1.0'
//     };
//     var request = http.Request(
//         'POST', Uri.parse('https://api.sandbox.co.in/authenticate'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       final responseString = await response.stream.bytesToString();
//       Map det = jsonDecode(responseString);
//       return det['access_token'];
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

//   Future<bool> verifyPan(String panno) async {
//     var token = await getAccessToken();
//     var headers = {
//       'Authorization': token,
//       'x-api-key': 'key_live_1XilWqECfePBMRzHKIfj4719kkc7q7C4',
//       'x-api-version': '1.0'
//     };
//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             'https://api.sandbox.co.in/pans/${panno}/verify?consent=Y&reason=Opening an account'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final responseString = jsonDecode(await response.stream.bytesToString());
//       if (responseString['data']['full_name'] ==
//           nameController.text.toUpperCase())
//         return true;
//       else
//         return false;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context);
//     return Scaffold(
//       backgroundColor: scaffoldBgColor,
//       body: ListView(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: blackColor,
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: 70.0),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/Logo.png',
//                 width: 150,
//                 height: 150.0,
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(height: 30.0),
//               Text(
//                 locale.register,
//                 style: grey14BoldTextStyle,
//               ),
//               height20Space,
//               Padding(
//                 padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4.0,
//                         spreadRadius: 1.0,
//                         color: blackColor.withOpacity(0.05),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     focusNode: firstFocusNode,
//                     controller: nameController,
//                     style: black14MediumTextStyle,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 20.0),
//                       hintText: "Full Name as per PAN",
//                       hintStyle: black14MediumTextStyle,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ), //username
//               height20Space,
//               Padding(
//                 padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4.0,
//                         spreadRadius: 1.0,
//                         color: blackColor.withOpacity(0.05),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     focusNode: secondFocusNode,
//                     controller: emailController,
//                     style: black14MediumTextStyle,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 20.0),
//                       hintText: locale.email,
//                       hintStyle: black14MediumTextStyle,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ), //Email
//               height20Space,
//               Padding(
//                 padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4.0,
//                         spreadRadius: 1.0,
//                         color: blackColor.withOpacity(0.05),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     readOnly: true,
//                     focusNode: thirdFocusNode,
//                     controller: dobController,
//                     style: black14MediumTextStyle,
//                     onTap: () async {
//                       final DateTime picked = await showDatePicker(
//                           context: context,
//                           initialDate: selectedDate,
//                           firstDate: DateTime(1900),
//                           lastDate: DateTime(2100));
//                       if (picked != null && picked != selectedDate) {
//                         setState(() {
//                           selectedDate = picked;
//                           dobController.text =
//                               new DateFormat("yyyy-MM-dd").format(picked);
//                         });
//                       }
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 20.0),
//                       hintText: locale.DateOfBirth,
//                       hintStyle: black14MediumTextStyle,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               height20Space,
//               Padding(
//                 padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4.0,
//                         spreadRadius: 1.0,
//                         color: blackColor.withOpacity(0.05),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: pan,
//                     focusNode: fourthFocusNode,
//                     style: black14MediumTextStyle,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 20.0),
//                       hintText: locale.pan,
//                       hintStyle: black14MediumTextStyle,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ), //Password
//               height20Space,
//               Padding(
//                 padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4.0,
//                         spreadRadius: 1.0,
//                         color: blackColor.withOpacity(0.05),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: refferController,
//                     style: black14MediumTextStyle,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 20.0),
//                       hintText: locale.referalcode,
//                       hintStyle: black14MediumTextStyle,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ), //Referal ID
//               SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
//                 child: InkWell(
//                   onTap: () => register(),
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Container(
//                     width: double.infinity,
//                     height: 50.0,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: primaryColor,
//                     ),
//                     child: Text(
//                       locale.continuebutton,
//                       style: white14BoldTextStyle,
//                     ),
//                   ),
//                 ),
//               ), //Continue
//               heightSpace,
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
