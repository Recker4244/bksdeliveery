import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/collectionList.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold247/pages/auth/login.dart';
import 'package:gold247/pages/profile/Collection_Details.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/models/subscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gold247/models/user.dart';
import 'package:gold247/language/locale.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Collections extends StatefulWidget {
  const Collections({Key key}) : super(key: key);

  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  //List<subscription> temp;
  List res = [];
  List<collectionList> processing = [];
  List<collectionList> cancelled = [];
  List<collectionList> complete = [];
  changeStatus(String id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${baseurl}/api/appointment/status/$id'));
    request.body = json.encode({"status": "Cancelled"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await getplans();
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    res = [];
    processing = [];
    cancelled = [];
    complete = [];
    super.initState();
  }

  List<collectionList> collections = [];
  Future getplans() async {
    var request =
        http.Request('GET', Uri.parse('${baseurl}/api/order/transactions'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final det = jsonDecode(responseString);
      Iterable l = det;
      List cod = det;
      List<collectionList> collect = [];
      for (int i = 0; i < cod.length; i++) {
        collectionList temp = collectionList.fromJson(cod[i]);
        collect.add(temp);
      }
      collections = collect;

      collections = collect.where((element) {
        if (element.transactions.deleveryAgent !=
            null) if (element.transactions.deleveryAgent == Userdata.sId)
          return true;
        return false;
      }).toList();
      processing = collections.where((element) {
        if (element.status == "Assigned") return true;
        return false;
      }).toList();
      cancelled = collections
          .where((element) => element.status == "Cancelled")
          .toList();
      complete = collections
          .where((element) => element.status == "Delivered")
          .toList();

      return collections;
    } else {
      print(response.reasonPhrase);
    }
    return collections;
  }

  Future getsub() async {}

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return FutureBuilder(
      future: getplans(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
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
          if (snapshot.hasData) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: scaffoldBgColor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  automaticallyImplyLeading: false,
                  title: Text('Your Deliveries',
                      style: primaryColor22BoldTextStyle),
                  bottom: const TabBar(
                    labelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    indicatorColor: primaryColor,
                    tabs: [
                      Tab(
                        text: 'Processing',
                      ),
                      Tab(text: 'Cancelled'),
                      Tab(
                        text: 'Delivered',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Processing(),
                    Cancelled(),
                    Deliverd(),
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
    var locale = AppLocalizations.of(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.size,
                    //         alignment: Alignment.bottomCenter,
                    //         child: Collectiondetails(
                    //             temp: plan, name: plan.planName())));
                  },
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                      color: whiteColor,
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
                              width: 50.0,
                              height: 50.0,
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/crypto_icon/btc.png'),
                              ),
                            ),
                            widthSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount of Order:',
                                  style: grey12BoldTextStyle,
                                ),
                                height5Space,
                                Text(
                                  '${processing[index].transactions.amount} INR',
                                  style: black16SemiBoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 27.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: Collectiondetails(
                                    installment: processing[index],
                                    userid: processing[index].user.id,
                                  )));
                        },
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
                            'Click for more Details'.toUpperCase(),
                            style: primaryColor14MediumTextStyle,
                          ),
                        ),
                      ),
                      // Spacer(),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         PageTransition(
                      //             type: PageTransitionType.size,
                      //             alignment: Alignment.bottomCenter,
                      //             child: Collectiondetails(
                      //               installment: processing[index],
                      //               userid: processing[index].user.id,
                      //             )));
                      //   },
                      //   borderRadius: BorderRadius.vertical(
                      //     bottom: Radius.circular(10.0),
                      //   ),
                      //   child: Container(
                      //     padding: EdgeInsets.all(fixPadding),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.vertical(
                      //         bottom: Radius.circular(10.0),
                      //       ),
                      //       color: Colors.white,
                      //     ),
                      //     child: Text(
                      //       'Call Customer'.toUpperCase(),
                      //       style: primaryColor14MediumTextStyle,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )

                // InkWell(
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     PageTransition(
                //     //         type: PageTransitionType.size,
                //     //         alignment: Alignment.bottomCenter,
                //     //         child: ));
                //   },
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(10.0),
                //   ),
                //   child: Container(
                //     padding: EdgeInsets.all(fixPadding),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.vertical(
                //         bottom: Radius.circular(10.0),
                //       ),
                //       color: Colors.white,
                //     ),
                //     child: Text(
                //       'cancel collection'.toUpperCase(),
                //       style: primaryColor16BoldTextStyle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
      itemCount: processing.length,
    );
  }

  Cancelled() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.size,
                    //         alignment: Alignment.bottomCenter,
                    //         child: Collectiondetails(
                    //             temp: plan, name: plan.planName())));
                  },
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                      color: whiteColor,
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
                              width: 50.0,
                              height: 50.0,
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/crypto_icon/btc.png'),
                              ),
                            ),
                            widthSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount of Order:',
                                  style: grey12BoldTextStyle,
                                ),
                                height5Space,
                                Text(
                                  '${cancelled[index]} INR',
                                  style: black16SemiBoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 27.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: Collectiondetails(
                              installment: cancelled[index],
                              userid: cancelled[index].user.id,
                            )));
                  },
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
                      'Click for more detail'.toUpperCase(),
                      style: primaryColor14MediumTextStyle,
                    ),
                  ),
                ),

                // InkWell(
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     PageTransition(
                //     //         type: PageTransitionType.size,
                //     //         alignment: Alignment.bottomCenter,
                //     //         child: ));
                //   },
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(10.0),
                //   ),
                //   child: Container(
                //     padding: EdgeInsets.all(fixPadding),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.vertical(
                //         bottom: Radius.circular(10.0),
                //       ),
                //       color: Colors.white,
                //     ),
                //     child: Text(
                //       'cancel collection'.toUpperCase(),
                //       style: primaryColor16BoldTextStyle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
      itemCount: cancelled.length,
    );
  }

  Deliverd() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.size,
                    //         alignment: Alignment.bottomCenter,
                    //         child: Collectiondetails(
                    //             temp: plan, name: plan.planName())));
                  },
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                      color: whiteColor,
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
                              width: 50.0,
                              height: 50.0,
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/crypto_icon/btc.png'),
                              ),
                            ),
                            widthSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount of Order:',
                                  style: grey12BoldTextStyle,
                                ),
                                height5Space,
                                Text(
                                  '${complete[index]} INR',
                                  style: black16SemiBoldTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 27.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: Collectiondetails(
                              installment: complete[index],
                              userid: complete[index].user.id,
                            )));
                  },
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
                      'Click for more detail'.toUpperCase(),
                      style: primaryColor14MediumTextStyle,
                    ),
                  ),
                ),

                // InkWell(
                //   onTap: () {
                //     // Navigator.push(
                //     //     context,
                //     //     PageTransition(
                //     //         type: PageTransitionType.size,
                //     //         alignment: Alignment.bottomCenter,
                //     //         child: ));
                //   },
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(10.0),
                //   ),
                //   child: Container(
                //     padding: EdgeInsets.all(fixPadding),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.vertical(
                //         bottom: Radius.circular(10.0),
                //       ),
                //       color: Colors.white,
                //     ),
                //     child: Text(
                //       'cancel collection'.toUpperCase(),
                //       style: primaryColor16BoldTextStyle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
      itemCount: complete.length,
    );
  }

  Choice_Card1(
    String mainText,
    String amount,
    String bottomText1,
    String bottomText2,
    Widget navigateTo1,
    Widget navigateTo2,
    final inst,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,
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
                padding: EdgeInsets.all(fixPadding * 1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  color: whiteColor,
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
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('assets/crypto_icon/btc.png'),
                          ),
                        ),
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$mainText',
                              style: grey12BoldTextStyle,
                            ),
                            height5Space,
                            Text(
                              '$amount',
                              style: black16SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 27.0,
                      color: primaryColor,
                    ),
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
                    padding: EdgeInsets.all(fixPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$bottomText1'.toUpperCase(),
                      style: primaryColor14MediumTextStyle,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: navigateTo2));
                  },
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
                      '$bottomText2'.toUpperCase(),
                      style: primaryColor14MediumTextStyle,
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

  Choice_Card2(
    String mainText,
    String amount,
    String bottomText,
    Widget navigateTo,
    final inst,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,
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
                padding: EdgeInsets.all(fixPadding * 1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  color: whiteColor,
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
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('assets/crypto_icon/btc.png'),
                          ),
                        ),
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$mainText',
                              style: grey12BoldTextStyle,
                            ),
                            height5Space,
                            Text(
                              '$amount',
                              style: black16SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 27.0,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.size,
                        alignment: Alignment.bottomCenter,
                        child: navigateTo));
              },
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
                  '$bottomText'.toUpperCase(),
                  style: primaryColor16BoldTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
