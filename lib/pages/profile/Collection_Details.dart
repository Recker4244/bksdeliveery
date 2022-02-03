import 'package:gold247/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold247/models/collectionList.dart';
import 'package:gold247/models/order.dart';
import 'package:gold247/models/referral.dart';
import 'package:gold247/models/subscription.dart';
import 'package:gold247/language/locale.dart';
import 'package:gold247/models/user.dart';

import 'package:gold247/pages/portfolio/Collections.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gold247/models/customSub.dart';
import 'package:gold247/models/standardSub.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Collectiondetails extends StatefulWidget {
  collectionList installment;
  String userid;
  Collectiondetails({this.installment, this.userid});
  @override
  CollectiondetailsState createState() => CollectiondetailsState();
}

class CollectiondetailsState extends State<Collectiondetails> {
  Future<bool> init;

  Future<Order> fetchsubscription(String user, String id) async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/order/user/${user}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map det = jsonDecode(responseString);
      Iterable i = det['data'];

      List<Order> subs = [];
      subs = List<Order>.from(i.map((model) => Order.fromJson(model)));
      for (int j = 0; j < subs.length; j++) {
        if (subs[j].transactions == id) return subs[j];
      }
    } else {
      print(response.reasonPhrase);
    }

    //return temp;
  }

  Order temp;
  Future<bool> initialise() async {
    //temp = await fetchsubscription(widget.userid, widget.installment.id);
    return true;
  }

  @override
  void initState() {
    init = initialise();
    super.initState();
  }

  TextEditingController otp = TextEditingController();
  // changeStatus(String id, String status) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return Dialog(
  //         elevation: 0.0,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //         child: Wrap(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(20.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   SpinKitRing(
  //                     color: primaryColor,
  //                     size: 40.0,
  //                     lineWidth: 1.2,
  //                   ),
  //                   SizedBox(height: 25.0),
  //                   Text(
  //                     'Please Wait..',
  //                     style: grey14MediumTextStyle,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  //   var request = http.Request('POST',
  //       Uri.parse('http://13.59.57.74:5000/api/appointment/status/$id'));
  //   request.bodyFields = {'status': 'Order Completed'};
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     changeSub(id)
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  changeSub(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://13.59.57.74:5000/api/order/status/$id'));
    request.body = json.encode({"status": "Order Completed"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.bottomCenter,
              child: Collections()));
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: scaffoldBgColor,
                title: Center(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      size: 30.0,
                      color: scaffoldBgColor,
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Verified",
                        style: black18BoldTextStyle,
                      )),
                      // Center(
                      //     child: Text(
                      //   '${DateTime.now()}',
                      //   style: black14MediumTextStyle,
                      // )),
                      heightSpace,
                    ],
                  ),
                ),
              ));
    } else {
      print(response.reasonPhrase);
    }
  }

  void verify() {
    if (otp.text == widget.installment.opt) {
      // Navigator.push(
      //     context,
      //     PageTransition(
      //         type: PageTransitionType.size,
      //         alignment: Alignment.bottomCenter,
      //         child: PurchaseEntry(
      //           appointment: widget.installment,
      //         )));
      changeSub(widget.installment.id);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: scaffoldBgColor,
                title: Center(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.cancel,
                      size: 30.0,
                      color: scaffoldBgColor,
                    ),
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Failed to verify , check the OTP and try again",
                        style: black18BoldTextStyle,
                      )),
                      // Center(
                      //     child: Text(
                      //   '${DateTime.now()}',
                      //   style: black14MediumTextStyle,
                      // )),
                      heightSpace,
                    ],
                  ),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    box2() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        // width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "",
              //     style: TextStyle(
              //       color: primaryColor,
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Appointment ID:",
                      //locale.OrderID,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "#${widget.installment.id}",
                      //"#${widget.temp.id}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Date:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${DateTime.parse(widget.installment.appointmentDate).toString()}",
                      //widget.temp.createdAt(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Time:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.installment.appointmentTime}",
                      //widget.temp.createdAt(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Customer Name:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.installment.user.fname}",
                      //widget.temp.status().toUpperCase(),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Consignment Number:",
              //         style: TextStyle(
              //           color: blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "${temp.consignment}",
              //         style: TextStyle(
              //           color: blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Estimated Valuation:",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "INR ${widget.installment.valuation}",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              // Wrap(
              //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Landmark:",
              //         style: TextStyle(
              //           color: blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "${temp.address.landMark}",
              //         style: TextStyle(
              //           color: blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Pincode:",
              //         style: TextStyle(
              //           color: blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "${temp.address.pin}",
              //         style: TextStyle(
              //           color: blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      );
    }

    box3() {
      return Container(
        decoration: BoxDecoration(
          color: scaffoldLightColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mode of Payment",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Collect from Your Location",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: init,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ))),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: scaffoldLightColor,
                appBar: AppBar(
                  foregroundColor: primaryColor,
                  backgroundColor: scaffoldLightColor,
                  titleSpacing: 0.0,
                  elevation: 0.0,
                  title: Text(
                    "Appointment Details",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                body: ListView(
                  children: [
                    box2(),
                    (widget.installment.status == "Appointment Placed" ||
                            widget.installment.status == "Verifier Assigned")
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: whiteColor,
                                textSelectionTheme: TextSelectionThemeData(
                                  cursorColor: primaryColor,
                                ),
                              ),
                              child: TextField(
                                controller: otp,
                                keyboardType: TextInputType.emailAddress,
                                style: primaryColor16BoldTextStyle,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  labelText: 'Enter Verification OTP details',
                                  labelStyle: primaryColor16BoldTextStyle,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                bottomNavigationBar: Visibility(
                  visible: (widget.installment.status == "Appointment Placed" ||
                      widget.installment.status == "Verifier Assigned"),
                  child: InkWell(
                    child: Container(
                      height: 8.h,
                      // width: double.infinity,
                      padding: EdgeInsets.all(fixPadding * 1.7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        "Verify to confirm",
                        style: white18MediumTextStyle,
                      ),
                    ),
                    onTap: () {
                      verify();
                    },
                  ),
                ));
          } else {
            return errorScreen;
          }
        }
      },
    );
  }

  Widget box1() {
    return Container(
      decoration: BoxDecoration(
        color: scaffoldLightColor,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/crypto_icon/gold_ingots.png'),
            Container(
              height: 20,
            ),
            Text(
              "",
              // widget.name.toUpperCase(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
