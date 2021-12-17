// import 'dart:async';
// import 'dart:io';

// import 'package:gold247/constant/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:gold247/models/user.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:gold247/pages/screens.dart';
// import 'package:gold247/language/locale.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sizer/sizer.dart';

// class EditProfile extends StatefulWidget {
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   // DateTime parseDate =
//   //     new DateFormat("yyyy-mm-dd'T'HH:mm:ss.SSS'Z'").parse(Userdata.dob);
//   final nameController = TextEditingController(text: Userdata.fname);
//   final emailController = TextEditingController(text: Userdata.email);
//   final dobController = TextEditingController(text: Userdata.dob);
//   FocusNode nameControl = FocusNode();
//   FocusNode emailControl = FocusNode();
//   FocusNode dobControl = FocusNode();
//   DateTime selectedDate = DateTime.now();
//   String date = DateFormat("dd-MM-yyyy").format(DateTime.now());

//   // editProfile() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final email = prefs.getString('Email') ?? "bksgold@bks.com";
//   //   final username = prefs.getString('UserName') ?? "Unknown User";
//   //   final dob = prefs.getString('DOB') ?? "00-00-0000";
//   //   setState(() {
//   //     nameController.text = username;
//   //     emailController.text = email;
//   //     dobController.text = dob;
//   //   });
//   // }
//   Future getuserdetails(String id) async {
//     var request = http.Request('GET', Uri.parse('${baseurl}/api/user/$id'));

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       final responseString = json.decode(await response.stream.bytesToString());

//       Userdata = userdata.fromJson(responseString);
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

//   String profile_picture;
//   upload_picture(String path) async {
//     // TODO need api for image upload
//     final String apiUrl = baseurl + "user/upload";
//     var headers = {'Content-Type': 'multipart/form-data'};
//     var request = http.MultipartRequest(
//         'PUT', Uri.parse('${baseurl}/api/user/image/${Userdata.sId}'));
//     request.files.add(await http.MultipartFile.fromPath('image', path));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       String s = await response.stream.bytesToString();
//       await getuserdetails(Userdata.sId);
//       setState(() {
//         profile_picture = s;
//       });

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Profile picture updated")));
//       Navigator.of(context).pop();
//     } else if (response.statusCode == 413) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("File size is too big")));
//     } else {
//       setState(() {
//         profile_picture = "";
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to upload profile picture")));
//     }
//   }

//   File file;
//   Future selectprofilepic(ImageSource source) async {
//     final _picker = ImagePicker();
//     final imageFile = await _picker.pickImage(source: source);
//     if (this.mounted) {
//       setState(() {
//         file = File(imageFile.path);
//       });
//       upload_picture(file.path);
//     }
//   }

//   Future updateUserDetail(String name, String email) async {
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
//     if (name == "") {
//       Navigator.pop(context, true);
//       Fluttertoast.showToast(
//         msg: 'UserName Not Specified.',
//         backgroundColor: Colors.black,
//         textColor: whiteColor,
//       );
//       return FocusScope.of(context).requestFocus(nameControl);
//     }
//     if (email == "") {
//       Navigator.pop(context, true);
//       Fluttertoast.showToast(
//         msg: 'Email Not Specified.',
//         backgroundColor: Colors.black,
//         textColor: whiteColor,
//       );
//       return FocusScope.of(context).requestFocus(emailControl);
//     }

//     http.Response response = await http.put(
//       Uri.parse("${baseurl}/api/user/" + Userdata.sId),
//       body: {"fname": name, "email": email},
//     );
//     if (response.statusCode == 200) {
//       final responseString = json.decode(response.body);
//       Map datas = responseString;
//       setState(() {
//         Userdata = userdata.fromJson(datas);
//       });
//       Navigator.pop(context, true);
//       Fluttertoast.showToast(
//         msg: 'Changes Saved Successfully.',
//         backgroundColor: Colors.black,
//         textColor: whiteColor,
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // var inputDate = DateTime.parse(parseDate.toString());
//     // var outputFormat = DateFormat('yyyy-MM-dd');
//     // var outputDate = outputFormat.format(inputDate);
//     // setState(() {
//     //   dobController.text = outputDate;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: scaffoldBgColor,
//       appBar: AppBar(
//         titleSpacing: 0.0,
//         backgroundColor: primaryColor,
//         title: Text(
//           'Edit Profile',
//           style: white16SemiBoldTextStyle,
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: whiteColor,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             padding: EdgeInsets.all(fixPadding * 2.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 20.h,
//                   alignment: Alignment.center,
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: width - fixPadding * 4.0,
//                         alignment: Alignment.center,
//                         child: Container(
//                           width: 40.w,
//                           height: 50.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(70.0),
//                             image: DecorationImage(
//                               image: Userdata.image == null
//                                   ? AssetImage(
//                                       'assets/user/default.jpeg',
//                                     )
//                                   : NetworkImage(Userdata.image),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0.0,
//                         child: Container(
//                           width: width - fixPadding * 4.0,
//                           alignment: Alignment.center,
//                           child: InkWell(
//                             onTap: () {},
//                             //borderRadius: BorderRadius.circular(20.0),
//                             child: Container(
//                               width: 40.w,
//                               padding: EdgeInsets.symmetric(
//                                   vertical: fixPadding * 0.6),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 color: primaryColor,
//                                 border: Border.all(
//                                   width: 2.0,
//                                   color: whiteColor,
//                                 ),
//                               ),
//                               child: InkWell(
//                                 onTap: () {
//                                   _selectOptionBottomSheet();
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.camera_alt,
//                                       size: 16.0,
//                                       color: whiteColor,
//                                     ),
//                                     SizedBox(width: 5.0),
//                                     Text(
//                                       'Change',
//                                       style: white12MediumTextStyle,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 heightSpace,

//                 // Name Field Start
//                 Container(
//                   padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
//                   child: Theme(
//                     data: ThemeData(
//                       primaryColor: whiteColor,
//                       textSelectionTheme: TextSelectionThemeData(
//                         cursorColor: primaryColor,
//                       ),
//                     ),
//                     child: TextField(
//                       focusNode: nameControl,
//                       controller: nameController,
//                       keyboardType: TextInputType.text,
//                       style: primaryColor16BoldTextStyle,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: const BorderRadius.all(
//                             const Radius.circular(10.0),
//                           ),
//                           borderSide: BorderSide(color: primaryColor, width: 1),
//                         ),
//                         labelText: 'Full Name',
//                         labelStyle: primaryColor16BoldTextStyle,
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: const BorderRadius.all(
//                             const Radius.circular(10.0),
//                           ),
//                           borderSide: BorderSide(color: primaryColor, width: 1),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Name Field End

//                 // Email Field Start
//                 Container(
//                   padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
//                   child: Theme(
//                     data: ThemeData(
//                       primaryColor: whiteColor,
//                       textSelectionTheme: TextSelectionThemeData(
//                         cursorColor: primaryColor,
//                       ),
//                     ),
//                     child: TextField(
//                       focusNode: emailControl,
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       style: primaryColor16BoldTextStyle,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: const BorderRadius.all(
//                             const Radius.circular(10.0),
//                           ),
//                           borderSide: BorderSide(color: primaryColor, width: 1),
//                         ),
//                         labelText: 'Email',
//                         labelStyle: primaryColor16BoldTextStyle,
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: const BorderRadius.all(
//                             const Radius.circular(10.0),
//                           ),
//                           borderSide: BorderSide(color: primaryColor, width: 1),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Email Field End

//                 heightSpace,
//                 // Save Button Start
//                 InkWell(
//                   onTap: () => updateUserDetail(
//                       nameController.text, emailController.text),
//                   borderRadius: BorderRadius.circular(7.0),
//                   child: Container(
//                     width: width,
//                     padding: EdgeInsets.all(fixPadding * 1.5),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7.0),
//                       color: primaryColor,
//                     ),
//                     child: Text(
//                       'Save',
//                       style: white14BoldTextStyle,
//                     ),
//                   ),
//                 ),
//                 // Save Button End
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Bottom Sheet for Select Options (Camera or Gallery) Start Here
//   void _selectOptionBottomSheet() {
//     double width = MediaQuery.of(context).size.width;
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Container(
//             color: whiteColor,
//             child: Wrap(
//               children: <Widget>[
//                 Container(
//                   child: Container(
//                     padding: EdgeInsets.all(fixPadding),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           width: width,
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Text(
//                             'Choose Option',
//                             textAlign: TextAlign.center,
//                             style: black18BoldTextStyle,
//                           ),
//                         ),
//                         heightSpace,
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: fixPadding),
//                           width: width,
//                           height: 1.0,
//                           color: greyColor.withOpacity(0.5),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             selectprofilepic(ImageSource.camera);
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: width,
//                             padding: EdgeInsets.all(10.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.camera_alt,
//                                   color: Colors.black.withOpacity(0.7),
//                                   size: 20.0,
//                                 ),
//                                 SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text('Camera', style: black14MediumTextStyle),
//                               ],
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             selectprofilepic(ImageSource.gallery);
//                           },
//                           child: Container(
//                             width: width,
//                             padding: EdgeInsets.all(10.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.photo_album,
//                                   color: Colors.black.withOpacity(0.7),
//                                   size: 20.0,
//                                 ),
//                                 SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Text(
//                                   'Upload from Gallery',
//                                   style: black14MediumTextStyle,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// // Bottom Sheet for Select Options (Camera or Gallery) Ends Here
// }
