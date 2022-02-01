import 'package:flutter/material.dart';
import 'package:gold247/constant/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:gold247/pages/AppontmentDetails.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  // List<dynamic> temp=[];
  // List<dynamic> processing=[];
  // List<dynamic> cancelled=[];
  // List<dynamic> delivered=[];
  // Future getAppointments() async {
  //   var request = http.Request(
  //       'GET', Uri.parse('${baseurl}/api/appointment/user/${Userdata.id}'));

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     final responseString = await response.stream.bytesToString();
  //     Map det = jsonDecode(responseString);
  //     Iterable l = det['data'];
  //     temp =
  //         List<appointment>.from(l.map((model) => appointment.fromJson(model)));

  //     processing = temp
  //         .where((item) =>
  //             item.status == "Request Placed" ||
  //             item.status == "Verifier Assigned")
  //         .toList();
  //     delivered =
  //         temp.where((item) => item.status == "Bank Transfer Done").toList();
  //     cancelled = temp
  //         .where((item) => item.status == "Offer Declined by User")
  //         .toList();
  //   } else {
  //     print(response.reasonPhrase);
  //   }

  //   return temp;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: getAppointments(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (false) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: Center(
                    child: SpinKitRing(
                  duration: Duration(milliseconds: 700),
                  color: primaryColor,
                  size: 40.0,
                  lineWidth: 1.2,
                ))),
          );
        } else {
          if (true) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  automaticallyImplyLeading: false,
                  title: Text('Your Appointments',
                      style: primaryColor22BoldTextStyle),
                  bottom: const TabBar(
                    labelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    indicatorColor: primaryColor,
                    tabs: [
                      Tab(
                        text: 'Running',
                      ),
                      Tab(text: 'Cancelled'),
                      Tab(
                        text: 'Completed',
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Processing(),
                    Cancelled(),
                    Completed(),
                  ],
                ),
              ),
            );
          } else {
            return errorScreen;
          }
        }
      },
    );
  }

  Processing() {
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     String name =
    //         "${processing[index].weight} GRAM ${processing[index].metalGroup.karatage} GOLD";
    //     return Choice_Card1(
    //         name,
    //         'INR ${processing[index].valuation}',
    //         'TRACK APPOINTMENTS',
    //         'CANCEL',
    //         Eshop(),
    //         Eshop(),
    //         processing[index]);
    //   },
    //   itemCount: processing.length,
    // );
    return ListView.builder(
      itemBuilder: (context, index) {
        String name = "100 GRAM GOLD";
        String customerName = "Sumit kumar Sahu";
        String navigateUrl = "dd";
        String call = "788";
        return Choice_Card1(
          customerName,
          name,
          navigateUrl,
          call,
        );
      },
      itemCount: 4,
    );
  }

  Cancelled() {
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     String name =
    //         "${cancelled[index].weight} GRAM ${cancelled[index].metalGroup.karatage} GOLD";
    //     return Choice_Card2(name, 'INR ${cancelled[index].valuation}',
    //         'ORDER DETAIL', Eshop(), cancelled[index]);
    //   },
    //   itemCount: cancelled.length,
    // );
    return ListView.builder(
      itemBuilder: (context, index) {
        String name = "100 GRAM GOLD";
        String customerName = "Sumit kumar Sahu";
        String navigateUrl = "dd";
        String call = "788";
        return Choice_Card1(
          customerName,
          name,
          navigateUrl,
          call,
        );
      },
      itemCount: 4,
    );
  }

  Completed() {
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     String name =
    //         "${delivered[index].weight} GRAM ${delivered[index].metalGroup.karatage} GOLD";
    //     return Choice_Card2(name, 'INR ${delivered[index].valuation}',
    //         'ORDER DETAIL', Eshop(), delivered[index]);
    //   },
    //   itemCount: delivered.length,
    // );
    return ListView.builder(
      itemBuilder: (context, index) {
        String name = "100 GRAM GOLD";
        String customerName = "Sumit kumar Sahu";
        String navigateUrl = "dd";
        String call = "788";
        return Choice_Card1(
          customerName,
          name,
          navigateUrl,
          call,
        );
      },
      itemCount: 4,
    );
  }

  Choice_Card1(
    String customerName,
    String name,
    String navigateUrl,
    String call,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(fixPadding * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  color: scaffoldLightColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: scaffoldBgColor, shape: BoxShape.circle),
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image(
                              image: AssetImage(
                                  'assets/crypto_icon/gold_ingots.png'),
                            ),
                          ),
                        ),
                        width20Space,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customerName,
                              style: grey16MediumTextStyle,
                            ),
                            height5Space,
                            Text(
                              name,
                              style: black18SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AppointMentDetails()));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: primaryColor,
                        )),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding * 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      'Verify User OTP'.toUpperCase(),
                      style: primaryColor16BoldTextStyle.copyWith(
                          color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      'call user'.toUpperCase(),
                      style: primaryColor16BoldTextStyle.copyWith(
                          color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//   Choice_Card2(String mainText, String amount, String bottomText,
//       Widget navigateTo, appointment apt) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(
//           fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: whiteColor,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     PageTransition(
//                         type: PageTransitionType.size,
//                         alignment: Alignment.bottomCenter,
//                         child: Appointmentdetails(
//                           temp: apt,
//                         )));
//               },
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(10.0),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(fixPadding * 1.5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(10.0),
//                   ),
//                   color: whiteColor,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 50.0,
//                           height: 50.0,
//                           alignment: Alignment.center,
//                           child: Image(
//                             image: AssetImage('assets/crypto_icon/btc.png'),
//                           ),
//                         ),
//                         widthSpace,
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '$mainText',
//                               style: grey12BoldTextStyle,
//                             ),
//                             height5Space,
//                             Text(
//                               '$amount',
//                               style: black16SemiBoldTextStyle,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 27.0,
//                       color: primaryColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     PageTransition(
//                         type: PageTransitionType.size,
//                         alignment: Alignment.bottomCenter,
//                         child: Appointmentdetails(
//                           temp: apt,
//                         )));
//               },
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(10.0),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(fixPadding),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(10.0),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Text(
//                   '$bottomText'.toUpperCase(),
//                   style: primaryColor16BoldTextStyle,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}
